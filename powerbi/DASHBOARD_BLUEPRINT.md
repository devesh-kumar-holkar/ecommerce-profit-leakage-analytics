# Power BI dashboard notes

The report is planned around the questions I would ask while reviewing the data. The idea is to keep each page useful on its own instead of filling the report with charts.

## 1. Overview

**Question:** Are orders growing without the same improvement in realized order value?

Show:

- Total orders
- GMV
- Net order value
- Average order value
- Discount rate
- Order status

Main visuals:

- Monthly GMV and net order value
- Monthly discount rate
- Order status split
- Category contribution

Filters:

- Month
- Category
- Customer segment
- Payment method

---

## 2. Where is value leaking?

**Question:** Which cost buckets need a closer look?

Start with:

- Discount cost
- Shipping cost
- Refund value
- Return handling cost
- Identified leakage

Then break the numbers down by:

- category
- return reason
- logistics partner
- product

A useful table here is **high-revenue products with lower contribution**. Sales alone should not decide which products get attention.

---

## 3. Fulfillment and sellers

**Question:** Are delivery and seller operations creating avoidable cost?

Useful views:

- On-time delivery %
- Average shipping cost
- Late deliveries by logistics partner
- Seller cancellation rate
- Seller late-delivery rate
- Seller order volume

Keep order volume beside the rate. A seller with 1 late order out of 2 should not be read the same way as a seller with 20 late orders out of 200.

---

## 4. Customers

**Question:** What does the customer base look like beyond total revenue?

Show:

- New / Regular / High Value customers
- Orders by customer segment
- Revenue by acquisition channel
- Average order value
- Customer order frequency

For a later version, this page could be extended with repeat-purchase cohorts. That is intentionally left out of the current sample rather than forcing a complicated metric onto a small dataset.

## Layout notes

Keep the first page simple enough to scan quickly.

Use the other pages for investigation. A manager should be able to start at the overview, notice a change in a KPI, and then move to the page that explains it.

Avoid unnecessary gauges and decorative charts. The table and trend should do most of the work.
