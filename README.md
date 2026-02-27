# Inventory Reorder Policy Evaluation

### Replenishment Adequacy under Demand & Lead Time Variability

---

# Executive Summary

* **118 SKUs analyzed** across 180K+ transactional records
* **77% of SKUs classified as demand-volatile**
* **Avg reorder gap: 10.48 units** under current policy
* **$185.9K incremental working capital required** to align with 95% service target
* Capital exposure concentrated in high-variability SKUs

This project evaluates whether the current replenishment policy can sustain a **95% service level** under operational uncertainty — and quantifies the capital required to correct policy gaps.

---

# Business Context

Inventory replenishment decisions are commonly based on:

* Historical average demand
* Fixed supplier lead times
* Static Min–Max reorder policies

These assumptions imply stable demand and supply conditions.

In reality:

* Weekly demand fluctuates
* Lead times vary
* Shipment delays occur

This creates a mismatch between planning assumptions and operational variability, increasing stockout risk even when inventory exists.

---

# Business Objective

Assess whether the existing reorder policy:

> Maintains 95% service level
> under demand and lead time variability
> without excessive capital expansion

---

# Dataset Overview

The project uses the **DataCo Supply Chain Dataset**, containing 180K+ transactional order records.

Each row represents:

* SKU-level order
* Quantity purchased
* Order timestamp
* Shipping timestamp
* Product price

This structure enables:

* Weekly demand aggregation
* Lead time estimation
* Inventory policy modelling

---

# Key Variables Used

| Variable            | Description            |
| ------------------- | ---------------------- |
| product_card_id     | SKU identifier         |
| order_item_quantity | Units ordered          |
| order_date          | Order placement date   |
| shipping_date       | Shipment dispatch date |
| product_price       | Unit inventory cost    |

---

# Analytical Workflow

---

## 1️.) Demand Signal Engineering

Raw transactions were aggregated into:

> Weekly SKU-level demand time series

This transforms raw order data into planning-ready demand signals.

---

## 2️.) Demand Variability Modeling

For each SKU:

* Mean weekly demand
* Standard deviation
* Coefficient of variation

This quantifies demand uncertainty across the portfolio.

---

## 3️.) Lead Time Estimation

Lead time calculated as:

> Shipping Date − Order Date

Mean and variability of lead time were computed at SKU level to incorporate supply-side uncertainty.

---

## 4️.) Inventory Policy Modeling

Safety stock calculated using:

* Demand variability
* Lead time variability
* 95% service-level Z-score

Reorder Point (ROP):

> ROP = Mean Demand During Lead Time + Safety Stock

---

## 5️.) Policy Gap Assessment

Current reorder levels were compared against variability-adjusted ROP to compute:

* Reorder gap
* Under-buffered SKUs
* Policy inadequacy

---

## 6️.) Financial Impact Assessment

Additional safety stock required was converted into:

> Incremental working capital investment

Total capital required to achieve 95% service target:

> **$185,900**

---

# Dashboard Overview

![Dashboard Overview](https://github.com/Neelaksh-Lohani/Inventory_Reorder_Policy_Optimization/raw/main/Project_Relevant_Photos/Dashboard.png)

The Power BI dashboard provides:

* SKU-level reorder gap
* Demand volatility segmentation
* Lead time segmentation
* Capital impact by SKU
* Portfolio risk concentration

---

# Data Model

![Data Model](https://github.com/Neelaksh-Lohani/Inventory_Reorder_Policy_Optimization/raw/main/Project_Relevant_Photos/Data_Model.png)

The model integrates:

* Demand uncertainty
* Lead time uncertainty
* Inventory cost parameters

to evaluate replenishment adequacy.

---

# Key Insights

---

### 1.) 77% of SKUs exhibit demand volatility

Volatile SKUs drive majority of service risk under static Min–Max policy.

---

### 2.) Average reorder gap = 10.48 units

Current policy systematically underestimates variability-adjusted requirements.

---

### 3.) $185.9K capital required for full 95% alignment

Service-level compliance requires measurable capital expansion.

---

### 4.) Capital impact concentrated in high-variability SKUs

Not all SKUs contribute equally to working capital exposure.

---

### 5.) Uniform Min–Max logic insufficient

Demand heterogeneity requires differentiated buffering logic.

---

# Recommendations

---

### 1️.) Recalibrate ROP for Moderate & Volatile SKUs

Adjust reorder thresholds to absorb demand & lead time uncertainty.

---

### 2️.) Implement Risk-Based Segmentation

| Segment  | Policy Direction           |
| -------- | -------------------------- |
| Stable   | Lean buffer                |
| Moderate | Adjusted safety stock      |
| Volatile | Higher buffer / monitoring |

---

### 3️.) Prioritize High-Risk, Moderate-Capital SKUs

Address SKUs with high reorder gaps but manageable capital impact first.

---

### 4️.) Integrate Lead Time Variability into Planning Parameters

Avoid fixed lead-time assumptions in replenishment logic.

---

# Business Outcome

Revising reorder thresholds based on variability:

* Reduces stockout exposure
* Improves service reliability
* Enables targeted capital deployment
* Supports risk-aware replenishment planning

---

# Tools & Technologies

* PostgreSQL
* Power BI
* DAX
* SQL Aggregations

---

# What This Project Demonstrates

* Operational inventory planning knowledge
* Demand & lead time uncertainty modeling
* Financial impact quantification
* Policy gap diagnosis
* Decision-support dashboard design

---

# Final Assessment

This project demonstrates working-level specialization in:

> Inventory Planning & Supply Chain Analytics

without academic over-engineering or unnecessary complexity.

---

