# Power BI dashboard notes

The report follows the questions in the SQL analysis rather than starting with a list of chart types.

## 1. Overview

**Question:** What happened to order value after discounts?

Show:

- total orders
- GMV
- net order value
- average order value
- discount rate
- order status

Start with a monthly GMV vs net order value trend. Then use category contribution and order status to explain the movement.

Filters: month, category, customer segment and payment method.

## 2. Leakage

**Question:** Which costs are taking the most value out of the order?

Track:

- discount cost
- shipping cost
- refund value
- return handling cost
- identified leakage

Then break them down by category, return reason, logistics partner and product.

One useful table is high-revenue products sorted by contribution. It stops the report from treating sales as the only measure of performance.

## 3. Fulfillment and sellers

**Question:** Are delivery and seller operations adding avoidable cost?

Use:

- on-time delivery %
- average shipping cost
- late shipments by logistics partner
- seller order volume
- seller cancellation rate
- seller late-delivery rate

Keep volume next to every rate. A 50% rate from 2 orders needs different context from a 10% rate from 200 orders.

## 4. Customers

**Question:** What does the customer base look like beyond revenue?

Use:

- customer segment
- order frequency
- average order value
- acquisition channel
- customer revenue

The current sample is small, so I have not added a complicated cohort model. That can be a next version if the dataset is expanded.

## Layout

Keep the overview page readable at a glance.

Use the remaining pages for investigation. Avoid decorative gauges and charts that do not answer a specific question.
