# Inventory Reorder Policy Evaluation

### Assessing Replenishment Policy Adequacy under Demand & Lead Time Variability

---

## Project Overview

Inventory replenishment decisions are commonly based on:

* Historical average demand
* Fixed supplier lead times
* Static Min–Max reorder policies

These planning approaches assume:

> Stable demand and supply conditions

However, in real-world operations:

* Weekly product demand fluctuates
* Supplier lead times vary
* Shipment schedules shift due to logistics constraints

This creates a mismatch between:

> Inventory planning assumptions
> and
> Actual operational variability

As a result:

* Reorder points may be triggered too late
* Safety buffers may remain insufficient
* Stockout risk may increase
  even when inventory is available

---

### Business Objective

Evaluate whether the current replenishment policy can:

> Maintain a 95% service level
> under demand and lead time variability
> without significantly increasing inventory holding cost

---

## Dataset Information

This project uses the **DataCo Supply Chain Dataset**, which contains transactional-level order and shipment data from a multi-regional retail supply chain system.

Each row represents:

> A product-level order transaction

Including:

* Order placement date
* Product identifier (SKU)
* Quantity ordered
* Scheduled shipment timeline
* Actual shipping date
* Unit inventory price

---

### Key Variables Used

| Variable            | Description                    |
| ------------------- | ------------------------------ |
| product_card_id     | Unique identifier for each SKU |
| order_item_quantity | Quantity of product ordered    |
| order_date          | Customer order placement date  |
| shipping_date       | Shipment dispatch date         |
| product_price       | Unit inventory price           |
| shipping_mode       | Shipment method                |
| delivery_status     | Shipment completion status     |

These fields enable:

* SKU-level demand aggregation
* Lead time estimation
* Inventory policy evaluation

---

## Analytical Workflow

---

### 1.) Demand Signal Engineering

Transactional order data was aggregated to construct:

> Weekly SKU-level demand time series

This converts:

* Individual customer transactions
  into
* Planning-ready demand signals

required for inventory policy modelling.

---

### 2️.) Demand Variability Modelling

Weekly demand signals were analyzed to estimate:

* Mean demand per SKU
* Standard deviation of demand
* Coefficient of variation

This quantifies:

> Demand uncertainty
> across the SKU portfolio

---

### 3️.) Lead Time Estimation

Shipment dispatch timelines were used to calculate:

> Actual replenishment lead time
> between order placement
> and shipment initiation

Lead time variability was estimated at SKU level
to account for supply-side uncertainty.

---

### 4️.) Inventory Policy Modelling

Using:

* Demand variability
* Lead time variability

Safety stock was computed for each SKU
to align replenishment policy with a:

> 95% service-level target

Reorder points were recalibrated using:

ROP = Mean Demand During Lead Time + Safety Stock

---

### 5️.) Policy Simulation

Recalibrated reorder points were compared with:

> Current reorder levels

to identify:

* Reorder gap
* Under-buffered SKUs
* Inventory policy inadequacy

---

### 6️.) Financial Impact Assessment

Additional safety buffer required
for policy correction was converted into:

> Incremental working capital investment

based on SKU-level inventory price.

This quantifies:

> Capital required to align
> replenishment policy
> with operational variability

---

## Dashboard Overview

https://github.com/Neelaksh-Lohani/Inventory_Reorder_Policy_Optimization/blob/main/Project_Relevant_Photos/Dashboard.png

The Power BI dashboard provides:

* Reorder gap between current
  and variability-adjusted reorder levels
* SKU-level exposure to stockout risk
* Demand volatility segmentation
* Lead time variability segmentation
* Additional safety buffer required
* Working capital required
  for policy correction

---

## Data Model

https://github.com/Neelaksh-Lohani/Inventory_Reorder_Policy_Optimization/blob/main/Project_Relevant_Photos/Data_Model.png

The analytical model integrates:

* Demand variability
* Lead time variability
* Inventory policy parameters
  to assess SKU-level replenishment adequacy.

---

## Key Insights & Recommendations

---

### Insight 1

Current reorder thresholds underestimate demand variability during replenishment lead time across several SKUs.

**Recommendation:**
Recalibrate reorder points for SKUs exhibiting significant reorder gaps to ensure sufficient inventory availability during demand fluctuations.

---

### Insight 2

Moderate to volatile demand SKUs demonstrate higher exposure to inventory depletion under the current replenishment policy.

**Recommendation:**
Introduce variability-adjusted safety buffering for demand-volatile SKUs to reduce stockout risk caused by unpredictable weekly demand.

---

### Insight 3

Uniform Min–Max replenishment policy does not sufficiently reflect SKU-level variability in demand and lead time.

**Recommendation:**
Adopt differentiated reorder policies based on SKU-level demand variability to ensure buffering strategies align with underlying uncertainty.

---

### Insight 4

Inventory investment required to align reorder levels with service-level targets varies significantly across SKUs.

**Recommendation:**
Prioritize policy correction for SKUs with high reorder gaps and manageable capital impact for incremental service improvement.

---

### Insight 5

Stable demand SKUs contribute disproportionately to working capital requirements when reorder levels are adjusted for uncertainty.

**Recommendation:**
Evaluate reorder revisions for high-demand stable SKUs with consideration for capital implications.

---

### Insight 6

Certain SKUs require limited buffer additions but incur higher inventory investment due to elevated unit cost.

**Recommendation:**
Assess SKU-level capital intensity prior to implementing policy adjustments to avoid unnecessary working capital lock-in.

---

### Insight 7

Lead time variability contributes to differences in required safety buffering across SKUs.

**Recommendation:**
Incorporate supplier lead time variability into replenishment parameter settings for SKUs with unpredictable replenishment cycles.

---

### Insight 8

Reorder gap magnitude varies across demand-risk segments.

**Recommendation:**
Apply reorder revisions progressively across SKU segments beginning with those demonstrating higher reorder gaps.

---

## 🛠 Tools & Technologies

* PostgreSQL
* Power BI
* DAX
* Supply Chain Analytics

---

## Business Outcome

Revising reorder thresholds
to account for demand and lead time variability may:

* Improve inventory availability
* Reduce likelihood of stockouts
* Align replenishment policy
  with SKU-level uncertainty
* Enable targeted inventory investment
  across the SKU portfolio

Supporting:

> Risk-aware replenishment planning
> under operational variability

---

