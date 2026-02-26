### Dataset Overview — DataCo Supply Chain Dataset

This project utilizes the **DataCo Supply Chain Dataset**, which contains transactional-level order and fulfillment data from a multi-regional retail supply chain environment.

The dataset captures end-to-end information related to:

* Customer orders
* Product-level demand
* Shipment timelines
* Delivery status
* Supplier lead times
* Inventory pricing
* Geographic order distribution

---

### Data Granularity

Each row in the dataset represents:

> A product-level order transaction

This includes:

* Order placement date
* Product ordered (SKU)
* Quantity purchased
* Shipping method used
* Scheduled shipment timeline
* Actual delivery date

This transactional structure enables:

* Demand aggregation at SKU level
* Weekly demand signal construction
* Lead time estimation between order and shipment
* Replenishment policy evaluation

---

### Key Variables Used in This Project

The following fields were used for analytical modelling:

| Variable                    | Description                             |
| --------------------------- | --------------------------------------- |
| product_card_id             | Unique identifier for each SKU          |
| order_item_quantity         | Quantity of SKU ordered                 |
| order_date                  | Date on which customer order was placed |
| shipping_date               | Actual shipment dispatch date           |
| days_for_shipment_scheduled | Planned shipment lead time              |
| product_price               | Unit cost of inventory                  |
| shipping_mode               | Shipment method used                    |
| delivery_status             | Shipment completion status              |

---

### Analytical Relevance

These variables were used to:

* Construct weekly SKU-level demand signals
* Estimate demand variability across SKUs
* Measure supply lead time variability
* Compute safety stock requirements
* Recalibrate reorder points for service-level targets
* Simulate reorder gap under current policy
* Quantify working capital required for policy correction

---

The dataset provides sufficient operational visibility to assess:

> Inventory replenishment adequacy
> under demand and lead time variability.

