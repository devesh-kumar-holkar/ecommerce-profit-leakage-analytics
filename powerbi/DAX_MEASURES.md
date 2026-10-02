# Power BI measures

These are the core measures for the report. The names follow the terms used in the CSV files so the model stays easy to maintain.

## Order value

```DAX
Total Orders =
DISTINCTCOUNT(orders[order_id])
```

```DAX
GMV =
SUM(orders[gross_amount_inr])
```

```DAX
Discount Cost =
SUM(orders[discount_inr])
```

```DAX
Net Order Value =
SUM(orders[net_order_value_inr])
```

```DAX
Average Order Value =
DIVIDE([Net Order Value], [Total Orders])
```

```DAX
Discount Rate =
DIVIDE([Discount Cost], [GMV])
```

## Order status

```DAX
Cancelled Orders =
CALCULATE(
    [Total Orders],
    orders[order_status] = "Cancelled"
)
```

```DAX
Cancellation Rate =
DIVIDE([Cancelled Orders], [Total Orders])
```

```DAX
Delivered Orders =
CALCULATE(
    [Total Orders],
    orders[order_status] = "Delivered"
)
```

```DAX
Returned Orders =
CALCULATE(
    [Total Orders],
    orders[order_status] = "Returned"
)
```

```DAX
Return Rate =
DIVIDE([Returned Orders], [Delivered Orders])
```

## Fulfillment

```DAX
Shipped Orders =
CALCULATE(
    DISTINCTCOUNT(shipments[shipment_id]),
    shipments[delivery_status] <> "Not Shipped"
)
```

```DAX
Late Shipments =
CALCULATE(
    DISTINCTCOUNT(shipments[shipment_id]),
    shipments[delivery_status] = "Late"
)
```

```DAX
On Time Delivery % =
DIVIDE(
    [Shipped Orders] - [Late Shipments],
    [Shipped Orders]
)
```

```DAX
Shipping Cost =
SUM(shipments[shipping_cost_inr])
```

## Returns

```DAX
Refund Value =
SUM(returns[refund_amount_inr])
```

```DAX
Return Handling Cost =
SUM(returns[return_handling_cost_inr])
```

## Cost view

```DAX
Identified Leakage =
[Discount Cost]
    + [Shipping Cost]
    + [Refund Value]
    + [Return Handling Cost]
```

This is a project-level tracking measure. It is not an accounting profit/loss calculation.

Format rates as percentages and monetary measures as INR.
