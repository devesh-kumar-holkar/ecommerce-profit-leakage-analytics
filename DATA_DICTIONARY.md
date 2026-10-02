# Data Dictionary

The CSV files are small on purpose. They are linked tables that can be loaded into SQL or Power BI without much setup.

## customers.csv

| Column | Meaning |
|---|---|
| customer_id | Customer identifier |
| signup_date | Date the customer joined |
| customer_segment | New, Regular or High Value |
| city | Customer city |
| acquisition_channel | How the customer was acquired |

## products.csv

| Column | Meaning |
|---|---|
| product_id | Product identifier |
| product_name | Product name |
| category | Main category |
| subcategory | Subcategory |
| seller_id | Seller associated with the product |
| list_price_inr | Listed price |
| unit_cost_inr | Simplified unit cost used for contribution analysis |

## sellers.csv

| Column | Meaning |
|---|---|
| seller_id | Seller identifier |
| seller_name | Seller name |
| seller_city | Seller location |
| seller_tier | Gold, Silver or Standard |
| dispatch_sla_days | Expected dispatch time |

## orders.csv

| Column | Meaning |
|---|---|
| order_id | Order identifier |
| order_date | Date of order |
| customer_id | Customer who placed the order |
| order_status | Delivered, Cancelled or Returned |
| payment_method | COD, UPI, Card or Wallet |
| gross_amount_inr | Order value before discount |
| discount_inr | Discount recorded on the order |
| net_order_value_inr | Gross amount less discount |

## order_items.csv

One row per order/product combination.

| Column | Meaning |
|---|---|
| order_id | Related order |
| product_id | Product purchased |
| seller_id | Seller fulfilling the product |
| quantity | Units in the line |
| unit_price_inr | Price used for the line |
| line_revenue_inr | Quantity × unit price |

## shipments.csv

| Column | Meaning |
|---|---|
| shipment_id | Shipment identifier |
| order_id | Related order |
| dispatch_date | Date shipment was dispatched |
| promised_delivery_date | Promised delivery date |
| actual_delivery_date | Recorded delivery date |
| delivery_status | On Time, Late or Not Shipped |
| logistics_partner | Delivery partner |
| shipping_cost_inr | Shipping cost recorded for the shipment |

## returns.csv

Only returned orders appear in this table.

| Column | Meaning |
|---|---|
| return_id | Return identifier |
| order_id | Related order |
| return_date | Date return was recorded |
| return_reason | Reason given for the return |
| refund_amount_inr | Refund amount |
| return_handling_cost_inr | Estimated handling cost |

## Calculated measures

- Discount rate = discount / gross amount
- Cancellation rate = cancelled orders / total orders
- Return rate = returned orders / delivered orders
- On-time delivery % = on-time shipments / shipped shipments
- Identified leakage = discount + shipping cost + refund value + return handling cost

The leakage measure is a portfolio metric for comparison. It is not intended to represent a company's actual accounting profit.
