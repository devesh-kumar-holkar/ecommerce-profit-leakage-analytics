"""
E-commerce Profit Leakage Analytics
Portfolio analysis: data quality + business KPI validation.
"""

from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data"

def quality_check(df, name):
    print(f"\n--- {name} ---")
    print("Rows:", len(df))
    print("Duplicate rows:", df.duplicated().sum())
    print("Missing values:", int(df.isna().sum().sum()))

def main():
    customers = pd.read_csv(DATA / "customers.csv")
    orders = pd.read_csv(DATA / "orders.csv")
    items = pd.read_csv(DATA / "order_items.csv")
    shipments = pd.read_csv(DATA / "shipments.csv")
    returns = pd.read_csv(DATA / "returns.csv")

    for df, name in [
        (customers, "Customers"),
        (orders, "Orders"),
        (items, "Order Items"),
        (shipments, "Shipments"),
        (returns, "Returns"),
    ]:
        quality_check(df, name)

    total_orders = len(orders)
    cancelled = (orders["order_status"] == "Cancelled").sum()
    delivered = (orders["order_status"] == "Delivered").sum()
    returned = (orders["order_status"] == "Returned").sum()

    orders["discount_rate"] = orders["discount_inr"] / orders["gross_amount_inr"]

    print("\nCore KPIs")
    print("GMV:", round(orders["gross_amount_inr"].sum(), 2))
    print("Discount cost:", round(orders["discount_inr"].sum(), 2))
    print("Cancellation rate:", round(cancelled / total_orders * 100, 2), "%")
    print("Return rate:", round(returned / max(delivered, 1) * 100, 2), "%")
    print("Average order value:", round(orders["net_order_value_inr"].mean(), 2))

    print("\nDiscount by order status")
    print(orders.groupby("order_status")["discount_inr"].agg(["count","sum"]).round(2))

    print("\nLogistics performance")
    print(
        shipments.groupby("logistics_partner")
        .agg(
            shipments=("shipment_id", "count"),
            avg_shipping_cost=("shipping_cost_inr", "mean"),
            late_rate=("delivery_status", lambda s: (s == "Late").mean() * 100),
        )
        .round(2)
        .sort_values("late_rate", ascending=False)
    )

    if not returns.empty:
        print("\nReturn reasons")
        print(
            returns.groupby("return_reason")
            .agg(
                returns=("return_id", "count"),
                refund=("refund_amount_inr", "sum"),
                handling_cost=("return_handling_cost_inr", "sum"),
            )
            .round(2)
            .sort_values("refund", ascending=False)
        )

if __name__ == "__main__":
    main()
