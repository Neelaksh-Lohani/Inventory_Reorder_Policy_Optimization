-- 1.) Add Unit Cost
CREATE TABLE sku_cost AS
SELECT
    product_card_id,
    AVG(product_price) AS avg_unit_cost
FROM encoded_dataco_supplychain
GROUP BY product_card_id;


--2.) Combine Policy + Cost
CREATE TABLE financial_impact AS
SELECT
    p.product_card_id,
    p.buffer_gap,
    c.avg_unit_cost,
    (p.buffer_gap * c.avg_unit_cost) AS additional_inventory_value
FROM policy_comparison p
JOIN sku_cost c
ON p.product_card_id = c.product_card_id;


--3.) Estimate Working Capital Change
SELECT
    SUM(additional_inventory_value) AS total_inventory_investment
FROM financial_impact;

