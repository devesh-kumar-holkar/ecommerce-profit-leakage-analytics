CREATE TABLE customers (
    customer_id VARCHAR(20),
    signup_date DATE,
    customer_segment VARCHAR(30),
    city VARCHAR(50),
    acquisition_channel VARCHAR(30)
);

CREATE TABLE products (
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    seller_id VARCHAR(20),
    list_price_inr NUMERIC(12,2),
    unit_cost_inr NUMERIC(12,2)
);

CREATE TABLE sellers (
    seller_id VARCHAR(20),
    seller_name VARCHAR(100),
    seller_city VARCHAR(50),
    seller_tier VARCHAR(30),
    dispatch_sla_days INTEGER
);

CREATE TABLE orders (
    order_id VARCHAR(20),
    order_date DATE,
    customer_id VARCHAR(20),
    order_status VARCHAR(30),
    payment_method VARCHAR(30),
    gross_amount_inr NUMERIC(14,2),
    discount_inr NUMERIC(14,2),
    net_order_value_inr NUMERIC(14,2)
);

CREATE TABLE order_items (
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    seller_id VARCHAR(20),
    quantity INTEGER,
    unit_price_inr NUMERIC(12,2),
    line_revenue_inr NUMERIC(14,2)
);

CREATE TABLE shipments (
    shipment_id VARCHAR(20),
    order_id VARCHAR(20),
    dispatch_date DATE,
    promised_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_status VARCHAR(30),
    logistics_partner VARCHAR(50),
    shipping_cost_inr NUMERIC(12,2)
);

CREATE TABLE returns (
    return_id VARCHAR(20),
    order_id VARCHAR(20),
    return_date DATE,
    return_reason VARCHAR(50),
    refund_amount_inr NUMERIC(14,2),
    return_handling_cost_inr NUMERIC(12,2)
);