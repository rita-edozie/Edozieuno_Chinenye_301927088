# Portfolio 1 Database Design and Modelling

## Case study
Apex Goods Distribution operates a regional supply chain network managing fast-moving consumer goods across multiple warehouses and retail partners. The database tracks product catalogs, supplier shipments, warehouse stock levels, and distributor orders to streamline daily fulfillment. This system ensures real-time visibility into inventory turnover and prevents stockouts.

## Users
Warehouse managers oversee stock receipts, sales representatives record distributor orders, and system administrators manage user accounts and product categories across regional hubs.

## Main operations
The database supports recording new supplier shipments, adding catalog products, placing distributor orders, updating warehouse inventory levels, generating low-stock alerts, processing returns, and retrieving monthly sales summaries.

## Business rules
1. Each product must have a unique ProductID and belong to one valid category.
2. Every distributor order must be associated with a registered distributor ID and reference at least one order item.
3. Order quantities must be positive integers and cannot exceed available warehouse stock.
4. Warehouse stock levels are identified by a composite key of WarehouseID and ProductID.
5. Expiry dates for inventory items must be set to a future date relative to receipt.
6. A product cannot be deleted if it is referenced in any active distributor order.
7. Shipment delivery dates must occur on or after the corresponding order placement date.
8. Each distributor must maintain a status value of either Active or Suspended.

## Scope
This assessment scope includes products, categories, warehouses, distributors, orders, and shipments using fictional data for a single regional hub. It excludes retail point-of-sale transactions, payroll processing, and third-party logistics vehicle tracking.
