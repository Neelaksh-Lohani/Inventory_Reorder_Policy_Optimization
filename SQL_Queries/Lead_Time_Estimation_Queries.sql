-- 1.) Compute Order-Level Lead Time
CREATE TABLE order_lead_time AS
SELECT
    product_card_id,
    (shipping_date - order_date) AS lead_time
FROM encoded_dataco_supplychain
WHERE shipping_date IS NOT NULL;


--2.) Convert Lead Time to Days
CREATE TABLE order_lead_time_days AS
SELECT
    product_card_id,
    EXTRACT(DAY FROM lead_time) AS lead_time_days
FROM order_lead_time;


--3.) Estimate Avg Lead Time per SKU
CREATE TABLE sku_leadtime_mean AS
SELECT
    product_card_id,
    AVG(lead_time_days) AS avg_lead_time_days
FROM order_lead_time_days
GROUP BY product_card_id;


--4.) Estimate Lead Time Variability
CREATE TABLE sku_leadtime_stddev AS
SELECT
    product_card_id,
    STDDEV(lead_time_days) AS stddev_lead_time_days
FROM order_lead_time_days
GROUP BY product_card_id;


--5.) Combine
CREATE TABLE sku_leadtime_variability AS
SELECT
    m.product_card_id,
    m.avg_lead_time_days,
    s.stddev_lead_time_days
FROM sku_leadtime_mean m
JOIN sku_leadtime_stddev s
ON m.product_card_id = s.product_card_id;


SELECT * FROM sku_leadtime_variability
LIMIT 20;