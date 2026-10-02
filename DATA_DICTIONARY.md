# Data Dictionary

The sample is split into linked tables so that the same questions can be checked in SQL and Power BI. The values are synthetic and are included for portfolio analysis, not as company data.

## customers.csv

| Column | Meaning |
|---|---|
| customer_id | Customer identifier |
| signup_date | Date the customer joined |
| customer_segment | New, Regular or High Value |
| city | Customer city |
| acquisition_channel | Acquisition source |

## products.csv

| Column | Meaning |
|---|---|
| product_id | Product identifier |
| product_name | Product name |
| category | Main product category |
| subcategory | Product subcategory |
| seller_id | Seller associated with the product |
| list_price_inr | Listed price |
| unit_cost_inr | Simplified cost used for contribution analysis |

## sellers.csv

| Column | Meaning |
|---|---|
| seller_id | Seller identifier |
| seller_name | Sample seller name |
| seller_city | Seller location |
| seller_tier | Seller tier |
| dispatch_sla_days | Expected dispatch time |

## orders.csv

| Column | Meaning |
|---|---|
| order_id | Order identifier |
| order_date | Order date |
| customer_id | Customer who placed the order |
| order_status | Delivered, Cancelled or Returned |
| payment_method | Payment method |
| gross_amount_inr | Order value before discount |
| discount_inr | Discount recorded on the order |
| net_order_value_inr | Gross amount less discount |

## order_items.csv

One row represents one order/product line.

| Column | Meaning |
|---|---|
| order_id | Related order |
| product_id | Product purchased |
| seller_id | Seller fulfilling the line |
| quantity | Units in the line |
| unit_price_inr | Price used for the line |
| line_revenue_inr | Quantity multiplied by unit price |

## shipments.csv

| Column | Meaning |
|---|---|
| shipment_id | Shipment identifier |
| order_id | Related order |
| dispatch_date | Dispatch date |
| promised_delivery_date | Promised delivery date |
| actual_delivery_date | Recorded delivery date |
| delivery_status | On Time, Late or Not Shipped |
| logistics_partner | Delivery partner in the sample |
| shipping_cost_inr | Shipping cost recorded for the shipment |

## returns.csv

Only returned orders are included.

| Column | Meaning |
|---|---|
| return_id | Return identifier |
| order_id | Related order |
| return_date | Date the return was recorded |
| return_reason | Reason given for the return |
| refund_amount_inr | Refund amount |
| return_handling_cost_inr | Estimated handling cost |

## Calculated measures

- Discount rate = discount / gross amount
- Cancellation rate = cancelled orders / total orders
- Return rate = returned orders / delivered orders
- On-time delivery % = on-time shipments / shipped shipments
- Identified leakage = discount + shipping cost + refund value + return handling cost

The leakage measure is a portfolio tracking metric. It is not an accounting profit/loss measure.
