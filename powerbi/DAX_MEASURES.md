# Power BI DAX Measures

## Revenue

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

## Order quality

```DAX
Total Orders =
DISTINCTCOUNT(orders[order_id])
```

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
Returned Orders =
CALCULATE(
    [Total Orders],
    orders[order_status] = "Returned"
)
```

```DAX
Return Rate =
DIVIDE(
    [Returned Orders],
    CALCULATE([Total Orders], orders[order_status] = "Delivered")
)
```

## Fulfillment

```DAX
Shipping Cost =
SUM(shipments[shipping_cost_inr])
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
1 - DIVIDE([Late Shipments], DISTINCTCOUNT(shipments[shipment_id]))
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

## Leakage

```DAX
Identified Leakage =
[Discount Cost]
    + [Shipping Cost]
    + [Refund Value]
    + [Return Handling Cost]
```

```DAX
Average Order Value =
DIVIDE([Net Order Value], [Total Orders])
```

Use percentage formatting for rate measures and INR formatting for monetary measures.
