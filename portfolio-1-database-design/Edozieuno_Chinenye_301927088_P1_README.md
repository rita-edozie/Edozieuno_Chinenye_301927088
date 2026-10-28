# Portfolio 1 Database Design and Modelling

## Case study

Pear-C Goods Distribution runs a regional supply chain network that manages fast-moving consumer goods across multiple warehouses and retail partners. The Organisation’s database tracks product catalogs, warehouse stock levels, supplier loads of goods, and distributor orders, ensuring smooth daily operations. This system enables real-time transparency of inventory turnover to prevent stockouts.

## Users

Warehouse managers check stock receipts, sales representatives record distributor orders, and system administrators manage user accounts and product categories.

## Main operations

The database lets users record new supplier deliveries, add products to the catalog, place distributor orders, update warehouse inventory, get low-stock alerts, process returns, and pull monthly sales reports.

## Business rules

1. Each product must have a unique Product ID and belong to one valid category.
2. Every distributor order must be associated with a registered distributor ID and reference at least one order item.
3. Order quantities must be positive integers and cannot exceed available warehouse stock.
4. Warehouse stock levels are identified by a composite key of WarehouseID and ProductID.
5. Expiry dates for inventory items must be set to a future date relative to receipt. 
6. A product cannot be deleted if it is referenced in any active distributor order.
7. Loads of goods delivery dates must occur on or after the corresponding order placement date.
8. Each distributor must maintain a status value of either Active or Inactive.

## Scope

This assessment scope includes products, varieties, warehouses, distributors, orders, and loads using fictional data for a single regional center. It excludes retail point-of-sale transactions, payroll processing, and third-party logistics vehicle tracking.