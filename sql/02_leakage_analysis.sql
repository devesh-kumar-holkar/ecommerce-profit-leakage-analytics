-- The idea here is to look past GMV and find where value is being lost.

-- 1. Product contribution by category.
-- unit_cost_inr is a simplified portfolio cost field.
SELECT
    p.category,
    SUM(oi.line_revenue_inr) AS revenue,
    SUM(oi.quantity * p.unit_cost_inr) AS estimated_product_cost,
    SUM(
        oi.line_revenue_inr
        - oi.quantity * p.unit_cost_inr
    ) AS gross_contribution
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY gross_contribution DESC;


-- 2. Seller scorecard.
-- Build the seller/order level first so one order item does not
-- accidentally give a seller multiple copies of the same order.
WITH seller_orders AS (
    SELECT
        oi.seller_id,
        o.order_id,
        o.order_status,
        o.gross_amount_inr,
        o.discount_inr,
        MAX(
            CASE WHEN sh.delivery_status = 'Late' THEN 1 ELSE 0 END
        ) AS was_late
    FROM order_items oi
    JOIN orders o
        ON oi.order_id = o.order_id
    LEFT JOIN shipments sh
        ON o.order_id = sh.order_id
    GROUP BY
        oi.seller_id,
        o.order_id,
        o.order_status,
        o.gross_amount_inr,
        o.discount_inr
)
SELECT
    so.seller_id,
    s.seller_name,
    s.seller_tier,
    COUNT(*) AS orders,
    ROUND(
        AVG(so.discount_inr / NULLIF(so.gross_amount_inr, 0)) * 100,
        2
    ) AS avg_discount_pct,
    ROUND(
        100.0 * AVG(
            CASE WHEN so.order_status = 'Cancelled' THEN 1.0 ELSE 0.0 END
        ), 2
    ) AS cancellation_rate_pct,
    ROUND(100.0 * AVG(so.was_late), 2) AS late_delivery_pct
FROM seller_orders so
JOIN sellers s
    ON so.seller_id = s.seller_id
GROUP BY so.seller_id, s.seller_name, s.seller_tier
ORDER BY late_delivery_pct DESC;


-- 3. Monthly view of the costs being tracked.
-- Aggregate each source before joining them.
WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(gross_amount_inr) AS gmv,
        SUM(discount_inr) AS discount
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
monthly_shipping AS (
    SELECT
        DATE_TRUNC('month', dispatch_date) AS month,
        SUM(shipping_cost_inr) AS shipping
    FROM shipments
    GROUP BY DATE_TRUNC('month', dispatch_date)
),
monthly_returns AS (
    SELECT
        DATE_TRUNC('month', return_date) AS month,
        SUM(refund_amount_inr) AS refunds,
        SUM(return_handling_cost_inr) AS return_handling
    FROM returns
    GROUP BY DATE_TRUNC('month', return_date)
)
SELECT
    o.month,
    o.gmv,
    o.discount,
    COALESCE(s.shipping, 0) AS shipping,
    COALESCE(r.refunds, 0) AS refunds,
    COALESCE(r.return_handling, 0) AS return_handling,
    o.discount
        + COALESCE(s.shipping, 0)
        + COALESCE(r.refunds, 0)
        + COALESCE(r.return_handling, 0) AS identified_leakage
FROM monthly_orders o
LEFT JOIN monthly_shipping s
    ON o.month = s.month
LEFT JOIN monthly_returns r
    ON o.month = r.month
ORDER BY o.month;


-- 4. Products where sales volume alone may hide a weak contribution.
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.line_revenue_inr) AS revenue,
    SUM(oi.quantity * p.unit_cost_inr) AS product_cost,
    SUM(
        oi.line_revenue_inr
        - oi.quantity * p.unit_cost_inr
    ) AS contribution
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
HAVING SUM(oi.line_revenue_inr) > 10000
ORDER BY contribution ASC;
