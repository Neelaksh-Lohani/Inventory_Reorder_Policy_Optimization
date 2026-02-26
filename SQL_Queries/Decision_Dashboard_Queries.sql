-- 1.) SKU Risk Classification (Service Risk Layer)
-- High CV = High service failure risk

CREATE TABLE sku_risk_classification AS
SELECT
    product_card_id,
    demand_cv,
    CASE
        WHEN demand_cv < 0.5 THEN 'Stable'
        WHEN demand_cv BETWEEN 0.5 AND 1 THEN 'Moderate'
        ELSE 'Volatile'
    END AS demand_risk_class
FROM sku_demand_variability;

--2.) Inventory Policy Master Table
-- This becomes Our primary fact table in Power BI.

CREATE TABLE inventory_policy_master AS
SELECT
    p.product_card_id,
    p.mean_daily_demand,
    p.stddev_daily_demand,
    p.avg_lead_time_days,
    p.safety_stock,
    p.reorder_point,
    pc.current_rop,
    pc.buffer_gap,
    f.additional_inventory_value,
    r.demand_risk_class
FROM sku_policy_inputs p
JOIN policy_comparison pc
ON p.product_card_id = pc.product_card_id
JOIN financial_impact f
ON p.product_card_id = f.product_card_id
JOIN sku_risk_classification r
ON p.product_card_id = r.product_card_id;


-- 3.) Executive KPI Aggregation Table
CREATE TABLE inventory_policy_kpis AS
SELECT
    COUNT(*) AS total_skus,
    AVG(buffer_gap) AS avg_buffer_required,
    SUM(additional_inventory_value) AS total_capital_required,
    COUNT(CASE WHEN buffer_gap > 0 THEN 1 END) * 100.0 / COUNT(*) 
    AS percent_skus_underbuffered
FROM inventory_policy_master;




