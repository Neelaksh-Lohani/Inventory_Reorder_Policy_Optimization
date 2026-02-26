-- 1.) Combine Demand + Lead Time Inputs
CREATE TABLE sku_policy_inputs AS
SELECT
    d.product_card_id,
    d.mean_weekly_demand,
    d.stddev_weekly_demand,
    l.avg_lead_time_days
FROM sku_demand_variability d
JOIN sku_leadtime_variability l
ON d.product_card_id = l.product_card_id;

--2.) Convert Weekly Demand to Daily
/*Inventory policy operates in:

Daily demand × Lead time (in days)
*/
ALTER TABLE sku_policy_inputs
ADD COLUMN mean_daily_demand NUMERIC,
ADD COLUMN stddev_daily_demand NUMERIC;

UPDATE sku_policy_inputs
SET
    mean_daily_demand = mean_weekly_demand / 7,
    stddev_daily_demand = stddev_weekly_demand / 7;


--3.) Compute Safety Stock
/* Assume:

Target Service Level = 95%
Z = 1.65
*/

ALTER TABLE sku_policy_inputs
ADD COLUMN safety_stock NUMERIC;

UPDATE sku_policy_inputs
SET safety_stock =
    1.65 * stddev_daily_demand * SQRT(avg_lead_time_days);

--4.) Compute Reorder Point (ROP)
ALTER TABLE sku_policy_inputs
ADD COLUMN reorder_point NUMERIC;

UPDATE sku_policy_inputs
SET reorder_point =
    (mean_daily_demand * avg_lead_time_days)
    + safety_stock;


SELECT * FROM sku_policy_inputs
LIMIT 20;





	