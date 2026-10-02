-- Business KPI layer

SELECT
    COUNT(*) AS total_orders,
    SUM(gross_amount_inr) AS gmv,
    SUM(discount_inr) AS total_discount,
    SUM(net_order_value_inr) AS net_order_value,
    ROUND(AVG(net_order_value_inr), 2) AS average_order_value,
    ROUND(
        100.0 * SUM(discount_inr) / NULLIF(SUM(gross_amount_inr),0), 2
    ) AS discount_rate_pct
FROM orders;

SELECT
    order_status,
    COUNT(*) AS orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS order_share_pct
FROM orders
GROUP BY order_status
ORDER BY orders DESC;

SELECT
    s.logistics_partner,
    COUNT(*) AS shipments,
    ROUND(AVG(s.shipping_cost_inr), 2) AS avg_shipping_cost,
    ROUND(
        100.0 * AVG(CASE WHEN s.delivery_status = 'Late' THEN 1 ELSE 0 END), 2
    ) AS late_delivery_pct
FROM shipments s
GROUP BY s.logistics_partner
ORDER BY late_delivery_pct DESC;

SELECT
    r.return_reason,
    COUNT(*) AS return_count,
    SUM(r.refund_amount_inr) AS refund_value,
    SUM(r.return_handling_cost_inr) AS handling_cost
FROM returns r
GROUP BY r.return_reason
ORDER BY refund_value DESC;