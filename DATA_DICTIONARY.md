# Data Dictionary

## customers.csv

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| signup_date | Customer registration date |
| customer_segment | New, Regular or High Value segment |
| city | Customer city |
| acquisition_channel | Acquisition source |

## products.csv

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_name | Product name |
| category | Product category |
| subcategory | Product subcategory |
| seller_id | Primary seller |
| list_price_inr | Listed selling price |
| unit_cost_inr | Simplified product cost |

## sellers.csv

| Column | Description |
|---|---|
| seller_id | Unique seller identifier |
| seller_name | Seller name |
| seller_city | Seller location |
| seller_tier | Marketplace seller tier |
| dispatch_sla_days | Promised dispatch time |

## orders.csv

| Column | Description |
|---|---|
| order_id | Unique order |
| order_date | Order date |
| customer_id | Customer |
| order_status | Delivered, Cancelled or Returned |
| payment_method | COD, UPI, Card or Wallet |
| gross_amount_inr | Product value before discount |
| discount_inr | Discount applied |
| net_order_value_inr | Gross amount after discount |

## order_items.csv

Line-level product details for each order.

## shipments.csv

Shipment and delivery performance including promised and actual delivery dates, shipping cost and logistics partner.

## returns.csv

Return/refund records including return reason, refund amount and return handling cost.

## Derived metrics

- Discount rate = Discount / Gross amount
- Cancellation rate = Cancelled orders / Total orders
- Return rate = Returned orders / Delivered orders
- On-time delivery = On-time delivered orders / Delivered orders
- Net contribution = Net revenue - shipping cost - return cost - payment cost
