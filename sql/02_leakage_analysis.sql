-- Profit leakage analysis

-- 1. Category contribution
WITH order_profit AS (
    SELECT
        o.order_id,
        o.order_status,
        o.net_order_value_inr,
        SUM(oi.quantity * p.unit_cost_inr) AS product_cost
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_id, o.order_status, o.net_order_value_inr
)
SELECT
    p.category,
    SUM(oi.line_revenue_inr) AS revenue,
    SUM(oi.quantity * p.unit_cost_inr) AS estimated_product_cost,
    SUM(oi.line_revenue_inr - oi.quantity * p.unit_cost_inr) AS gross_contribution
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY gross_contribution DESC;


-- 2. Seller operational scorecard
SELECT
    p.seller_id,
    s.seller_name,
    s.seller_tier,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(AVG(o.discount_inr / NULLIF(o.gross_amount_inr,0)) * 100, 2) AS avg_discount_pct,
    ROUND(
        100.0 * AVG(CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END), 2
    ) AS cancellation_rate_pct,
    ROUND(
        100.0 * AVG(CASE WHEN sh.delivery_status = 'Late' THEN 1 ELSE 0 END), 2
    ) AS late_delivery_pct
FROM products p
JOIN sellers s ON p.seller_id = s.seller_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN shipments sh ON o.order_id = sh.order_id
GROUP BY p.seller_id, s.seller_name, s.seller_tier
ORDER BY late_delivery_pct DESC;


-- 3. Leakage by month
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(o.gross_amount_inr) AS gmv,
        SUM(o.discount_inr) AS discount,
        SUM(sh.shipping_cost_inr) AS shipping
    FROM orders o
    LEFT JOIN shipments sh ON o.order_id = sh.order_id
    GROUP BY DATE_TRUNC('month', o.order_date)
),
returns_monthly AS (
    SELECT
        DATE_TRUNC('month', return_date) AS month,
        SUM(refund_amount_inr) AS refunds,
        SUM(return_handling_cost_inr) AS return_handling
    FROM returns
    GROUP BY DATE_TRUNC('month', return_date)
)
SELECT
    m.month,
    m.gmv,
    m.discount,
    m.shipping,
    COALESCE(r.refunds,0) AS refunds,
    COALESCE(r.return_handling,0) AS return_handling,
    m.discount + m.shipping + COALESCE(r.refunds,0)
        + COALESCE(r.return_handling,0) AS identified_leakage
FROM monthly m
LEFT JOIN returns_monthly r ON m.month = r.month
ORDER BY m.month;


-- 4. Products with high revenue but weak unit economics
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.line_revenue_inr) AS revenue,
    SUM(oi.quantity * p.unit_cost_inr) AS product_cost,
    SUM(oi.line_revenue_inr - oi.quantity * p.unit_cost_inr) AS contribution
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
HAVING SUM(oi.line_revenue_inr) > 10000
ORDER BY contribution ASC;