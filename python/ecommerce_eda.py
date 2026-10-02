"""
Small validation script for the e-commerce sample.

Run from the repository root:
    python python/ecommerce_eda.py
"""

from pathlib import Path

import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data"


def check_table(df, name):
    print(f"\n{name}")
    print("-" * len(name))
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print(f"Duplicate rows: {df.duplicated().sum():,}")
    print(f"Missing cells: {int(df.isna().sum().sum()):,}")


def main():
    customers = pd.read_csv(DATA / "customers.csv")
    orders = pd.read_csv(DATA / "orders.csv")
    products = pd.read_csv(DATA / "products.csv")
    shipments = pd.read_csv(DATA / "shipments.csv")
    returns = pd.read_csv(DATA / "returns.csv")

    for df, name in [
        (customers, "Customers"),
        (orders, "Orders"),
        (products, "Products"),
        (shipments, "Shipments"),
        (returns, "Returns"),
    ]:
        check_table(df, name)

    total_orders = len(orders)
    cancelled = (orders["order_status"] == "Cancelled").sum()
    delivered = (orders["order_status"] == "Delivered").sum()
    returned = (orders["order_status"] == "Returned").sum()

    print("\nOrder summary")
    print("-------------")
    print(f"GMV: INR {orders['gross_amount_inr'].sum():,.0f}")
    print(f"Discounts: INR {orders['discount_inr'].sum():,.0f}")
    print(
        "Average order value: "
        f"INR {orders['net_order_value_inr'].mean():,.0f}"
    )
    print(f"Cancellation rate: {cancelled / total_orders:.1%}")
    print(f"Return rate: {returned / max(delivered, 1):.1%}")

    print("\nDiscount by order status")
    print("------------------------")
    print(
        orders.groupby("order_status")["discount_inr"]
        .agg(order_count="count", discount_value="sum")
        .round(0)
    )

    # A cancelled order may still have a shipment record.
    # Those records should not enter the late-delivery rate.
    shipped = shipments[shipments["delivery_status"] != "Not Shipped"]

    print("\nLogistics check")
    print("---------------")
    logistics = shipped.groupby("logistics_partner").agg(
        shipments=("shipment_id", "count"),
        avg_shipping_cost=("shipping_cost_inr", "mean"),
        late_shipments=(
            "delivery_status",
            lambda status: (status == "Late").sum(),
        ),
    )
    logistics["late_rate"] = (
        logistics["late_shipments"] / logistics["shipments"]
    )
    print(logistics.sort_values("late_rate", ascending=False).round(3))

    if not returns.empty:
        print("\nReturn reasons")
        print("--------------")
        print(
            returns.groupby("return_reason")
            .agg(
                returns=("return_id", "count"),
                refund_value=("refund_amount_inr", "sum"),
                handling_cost=("return_handling_cost_inr", "sum"),
            )
            .sort_values("refund_value", ascending=False)
            .round(0)
        )


if __name__ == "__main__":
    main()
