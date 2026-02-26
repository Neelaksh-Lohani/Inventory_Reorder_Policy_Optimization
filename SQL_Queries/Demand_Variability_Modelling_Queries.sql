-- 1.) Estimate Demand Mean (μ) per SKU
CREATE TABLE sku_demand_mean AS
SELECT
    product_card_id,
    AVG(weekly_demand) AS mean_weekly_demand
FROM final_sku_weekly_demand
GROUP BY product_card_id;

-- 2.) Estimate Demand Std Deviation (σ)
CREATE TABLE sku_demand_stddev AS
SELECT
    product_card_id,
    STDDEV(weekly_demand) AS stddev_weekly_demand
FROM final_sku_weekly_demand
GROUP BY product_card_id;

--3.) Combine Mean and Std Dev
CREATE TABLE sku_demand_variability AS
SELECT
    m.product_card_id,
    m.mean_weekly_demand,
    s.stddev_weekly_demand
FROM sku_demand_mean m
JOIN sku_demand_stddev s
ON m.product_card_id = s.product_card_id;

--4.) Compute Coefficient of Variation (CV)
-- CV tells Us:
--     How volatile demand is relative to its mean
ALTER TABLE sku_demand_variability
ADD COLUMN demand_cv NUMERIC;

UPDATE sku_demand_variability
SET demand_cv =
    CASE
        WHEN mean_weekly_demand = 0 THEN NULL
        ELSE stddev_weekly_demand / mean_weekly_demand
    END;


SELECT * FROM sku_demand_variability
ORDER BY demand_cv DESC
LIMIT 20;












