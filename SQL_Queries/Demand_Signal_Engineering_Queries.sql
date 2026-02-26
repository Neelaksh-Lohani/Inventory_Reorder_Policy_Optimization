-- Demand Signal Engineering — SQL Transformation Pipeline
-- 1.) Create Raw Staging Table

CREATE TABLE encoded_dataco_supplychain (
    transaction_type TEXT,
    days_for_shopping_real INT,
    days_for_shipment_scheduled INT,
    benefit_per_order NUMERIC,
    sales_per_customer NUMERIC,
    delivery_status TEXT,
    late_delivery_risk INT,
    category_id INT,
    category_name TEXT,
    customer_city TEXT,
    customer_country TEXT,
    customer_email TEXT,
    customer_fname TEXT,
    customer_id INT,
    customer_lname TEXT,
    customer_password TEXT,
    customer_segment TEXT,
    customer_state TEXT,
    customer_street TEXT,
    customer_zipcode TEXT,
    department_id INT,
    department_name TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    market TEXT,
    order_city TEXT,
    order_country TEXT,
    order_customer_id INT,
    order_date TIMESTAMP,
    order_id INT,
    order_item_cardprod_id INT,
    order_item_discount NUMERIC,
    order_item_discount_rate NUMERIC,
    order_item_id INT,
    order_item_product_price NUMERIC,
    order_item_profit_ratio NUMERIC,
    order_item_quantity INT,
    sales NUMERIC,
    order_item_total NUMERIC,
    order_profit_per_order NUMERIC,
    order_region TEXT,
    order_state TEXT,
    order_status TEXT,
    order_zipcode TEXT,
    product_card_id INT,
    product_category_id INT,
    product_description TEXT,
    product_image TEXT,
    product_name TEXT,
    product_price NUMERIC,
    product_status INT,
    shipping_date TIMESTAMP,
    shipping_mode TEXT
);


COPY encoded_dataco_supplychain
FROM 'C:/NPW_Projects/Inventory_Policy_Optimization_Analysis/DataCoSupplyChainDataset.csv/encoded_dataco_supplychain.csv'
DELIMITER ','
CSV HEADER;


SELECT COUNT(*) FROM encoded_dataco_supplychain;


-- 2.) Create Weekly Aggregated Demand per SKU
CREATE TABLE sku_weekly_demand AS
SELECT
    product_card_id,
    DATE_TRUNC('week', order_date) AS week_start,
    SUM(order_item_quantity) AS weekly_demand
FROM encoded_dataco_supplychain
GROUP BY
    product_card_id,
    DATE_TRUNC('week', order_date)
ORDER BY
    product_card_id,
    week_start;


SELECT * FROM sku_weekly_demand
LIMIT 10;


--3.) Create Weekly Calendar Table
-- to capture zero-demand weeks.
CREATE TABLE calendar_weeks AS
SELECT generate_series(
    (SELECT MIN(DATE_TRUNC('week', order_date)) FROM encoded_dataco_supplychain),
    (SELECT MAX(DATE_TRUNC('week', order_date)) FROM encoded_dataco_supplychain),
    interval '1 week'
) AS week_start;


SELECT * FROM calendar_weeks;


--4.) Create SKU List
CREATE TABLE sku_list AS
SELECT DISTINCT product_card_id
FROM encoded_dataco_supplychain;

SELECT COUNT(*) FROM sku_list;


--5.) Create SKU × Week Planning Grid
CREATE TABLE sku_week_grid AS
SELECT
    s.product_card_id,
    c.week_start
FROM sku_list s
CROSS JOIN calendar_weeks c;


SELECT COUNT(*) FROM sku_week_grid;


--6.) Fill Missing Weeks with Zero Demand
-- Final planning demand table:
CREATE TABLE final_sku_weekly_demand AS
SELECT
    g.product_card_id,
    g.week_start,
    COALESCE(d.weekly_demand, 0) AS weekly_demand
FROM sku_week_grid g
LEFT JOIN sku_weekly_demand d
ON g.product_card_id = d.product_card_id
AND g.week_start = d.week_start
ORDER BY
    g.product_card_id,
    g.week_start;


SELECT * FROM final_sku_weekly_demand
LIMIT 1000;
