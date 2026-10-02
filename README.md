# E-commerce Profit Leakage & Fulfillment Analytics

A business-focused **Data Analyst portfolio project** that investigates where an e-commerce business loses contribution across the order lifecycle.

Instead of stopping at sales reporting, the analysis follows:

**Order → Discount → Payment → Shipment → Delivery → Return → Refund → Net Contribution**

## Business objective

A marketplace can show strong GMV while still losing margin through discounts, returns, shipping costs, cancellations and refund-related leakage.

This project answers:

- Which categories and products generate revenue but weak contribution?
- Where is discount spend eroding margin?
- Which sellers have high cancellation, return or dispatch-delay rates?
- Does delivery performance coincide with cancellations and returns?
- Which regions and logistics partners have the highest fulfillment leakage?
- How much revenue is lost through returns, refunds and cancellations?
- Which customer segments generate repeat business without excessive return cost?

## Tech stack

- **Python:** Pandas, NumPy, Matplotlib
- **SQL:** joins, CTEs, CASE statements, window functions and cohort-style analysis
- **Power BI:** KPI cards, trend analysis, drill-downs and business dashboards
- **Excel:** optional validation and ad-hoc reporting

No machine learning is used.

## Core business KPIs

### GMV
Total merchandise value before discounts and adjustments.

### Net Revenue
Revenue after discounts and cancelled/returned order adjustments.

### Discount Rate
Discount value as a percentage of gross merchandise value.

### Return Rate
Returned orders divided by delivered orders.

### Cancellation Rate
Cancelled orders divided by total orders.

### On-time Delivery %
Delivered orders completed within the promised delivery date.

### Fulfillment Cost
Shipping and logistics cost associated with fulfilled orders.

### Net Contribution
A simplified contribution metric:

**Net Revenue − Shipping Cost − Return Cost − Payment Cost**

This is a portfolio analytical measure, not an accounting profit statement.

## Dataset design

The project uses synthetic marketplace-style data with linked operational tables:

```text
customers
    │
    └── orders ─── order_items ─── products
          │             │
          ├── payments  └── sellers
          │
          └── shipments ─── logistics
                    │
                    └── returns / refunds
```

The data is synthetic and created for portfolio/learning purposes. It does not represent any real company's internal data.

## Dashboard pages

### 1. Executive Profitability
- GMV
- Net Revenue
- Discount Cost
- Return Cost
- Shipping Cost
- Net Contribution
- Contribution Margin %

### 2. Profit Leakage
- Discount leakage
- Return/refund leakage
- Cancellation leakage
- Leakage by category
- Product-level contribution analysis

### 3. Fulfillment & Seller Performance
- On-time delivery %
- Average delivery days
- Seller dispatch delay
- Cancellation rate
- Return rate
- Logistics partner comparison

### 4. Customer Economics
- New vs repeat customers
- Orders per customer
- Customer revenue
- Return-heavy customers
- Segment contribution

## Repository structure

```text
ecommerce-profit-leakage-analytics/
├── data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── products.csv
│   ├── sellers.csv
│   ├── shipments.csv
│   └── returns.csv
├── python/
│   └── ecommerce_eda.py
├── sql/
│   ├── 00_schema.sql
│   ├── 01_business_kpis.sql
│   └── 02_leakage_analysis.sql
├── powerbi/
│   ├── DAX_MEASURES.md
│   └── DASHBOARD_BLUEPRINT.md
├── DATA_DICTIONARY.md
└── requirements.txt
```

## Analyst workflow

**Raw transactional data → quality checks → metric validation → SQL business analysis → leakage investigation → Power BI reporting**

The project demonstrates how a Data Analyst can move from operational records to actionable business questions rather than only producing a sales dashboard.
