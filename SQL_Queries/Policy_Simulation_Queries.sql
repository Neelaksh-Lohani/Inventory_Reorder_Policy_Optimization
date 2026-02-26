-- 1.) Simulate Current Policy ROP
-- Current ROP = μ × Lead Time

ALTER TABLE sku_policy_inputs
ADD COLUMN current_rop NUMERIC;

UPDATE sku_policy_inputs
SET current_rop =
    mean_daily_demand * avg_lead_time_days;


-- 2.) Compare Current vs Optimized
CREATE TABLE policy_comparison AS
SELECT
    product_card_id,
    current_rop,
    reorder_point AS optimized_rop,
    safety_stock,
    (reorder_point - current_rop) AS buffer_gap
FROM sku_policy_inputs;


-- 3.) Validate
SELECT * FROM policy_comparison
ORDER BY buffer_gap DESC
LIMIT 20;


