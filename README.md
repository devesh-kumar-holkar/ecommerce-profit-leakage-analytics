# E-commerce Profit Leakage & Fulfillment Analytics

This project looks at a problem that is easy to miss in e-commerce reporting:

**orders can grow while the money made on those orders does not improve at the same pace.**

Instead of building another sales dashboard, I used order, product, seller, shipment and return data to trace where value is lost between an order being placed and the order being completed.

The analysis is built around four areas:

- discounting
- returns and refunds
- delivery and shipping
- seller and product performance

The data in this repository is synthetic and was created for portfolio use.

## What I wanted to find out

Some of the questions behind the analysis:

1. Which categories generate good sales but relatively weak product contribution?
2. How much of the order value is being given away through discounts?
3. Which sellers have higher cancellation or delivery-delay rates?
4. Which return reasons account for most of the refund value?
5. How much does shipping and return handling add to the cost of fulfilling an order?
6. Which products are worth investigating beyond their sales number?

The point is not to label a seller or category as "bad". The dashboard is meant to help identify **where someone should look next**.

## Tools used

- **SQL** — joins, aggregations, CTEs and window functions
- **Python / Pandas** — data checks and exploratory analysis
- **Power BI** — KPI reporting and drill-down analysis
- **Excel** — optional manual checks

There is no machine learning in this project.

## Data in the project

The sample covers 2025 and contains:

- 500 customers
- 40 products
- 12 sellers
- 600 orders
- 600 order-item records
- 600 shipment records
- return records for returned orders

The main relationships are:

Customers → Orders → Order Items → Products → Sellers

Orders also connect to Shipments and Returns.

There is deliberately no separate payments table in the current version; payment method is stored in the orders table.

## Main measures

### Order value

net_order_value_inr is the order value after the recorded discount.

### Discount rate

discount / gross amount

### Cancellation rate

cancelled orders / total orders

### Return rate

For this project:

returned orders / delivered orders

### On-time delivery

Orders marked On Time in the shipment table divided by shipped orders.

### Identified fulfillment leakage

For the dashboard, this is a practical tracking measure:

discount + shipping cost + refund value + return handling cost

It should not be treated as an accounting profit calculation. It is used here to compare where operational costs are accumulating.

## SQL work

The SQL folder is split into three steps:

- 00_schema.sql — table definitions
- 01_business_kpis.sql — basic business metrics
- 02_leakage_analysis.sql — category, seller, monthly leakage and product-level analysis

The queries are written so that the business question comes first and the calculation follows it.

## Python work

ecommerce_eda.py checks:

- row counts
- duplicate rows
- missing values
- basic order KPIs
- discount levels
- delivery performance
- return reasons and refund values

It is intentionally a small validation script rather than a large notebook full of repeated charts.

## Power BI

The dashboard plan is documented in:

- powerbi/DAX_MEASURES.md
- powerbi/DASHBOARD_BLUEPRINT.md

The suggested report has four pages:

1. **Overview** — sales, discounts and order status
2. **Leakage** — discounts, refunds, shipping and product contribution
3. **Fulfillment** — delivery and seller performance
4. **Customers** — customer segments, order frequency and acquisition channels

## Repository structure

- data/ — source CSV files
- python/ — validation and exploratory analysis
- sql/ — database schema and analysis queries
- powerbi/ — measures and report notes
- DATA_DICTIONARY.md — column definitions
- requirements.txt — Python packages

## Workflow

**Check the data → calculate the basic KPIs → investigate leakage → compare sellers/products → build the dashboard.**

This is meant to show the type of analysis I would do before presenting a management dashboard, rather than just putting sales numbers into a few charts.
