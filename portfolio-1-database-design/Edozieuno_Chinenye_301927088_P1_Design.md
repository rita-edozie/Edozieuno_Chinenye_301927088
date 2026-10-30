# FMCG System Database Design

# Entities
I chose six entities to cover my FMCG (Fast-Moving Comodity Goods) system operations
                  
Entity	Information stored
category	Keeps records of valid product classifications.
product	Keeps records of FMCG items, each linked to one category.
distributor	Keeps records of registered customers, including their operational status.
distributor_order	Keeps records of orders placed by distributors, including placement and delivery dates.
order_item	Keeps records of individual products and quantities ordered within each distributor order.
warehouse_stock	Tracks inventory quantities, receipt dates, and expiry dates per warehouse.

# Attributes and keys

I use an automatically generated ID for each record. In the tables below, unique means no duplicate values.

Entity	Fields & PostgreSQL Types	PK / FK / Unique	Required / Optional
category	category_id (INT), category_name (VARCHAR)	PK: category_id, Unique: category_name	All Required
Product 	product_id (INT), product_name (VARCHAR), category_id (INT)	PK: product_id, FK: category_id references category	All Required
distributor	distributor_id (INT), distributor_name (VARCHAR), status (VARCHAR)	PK: distributor_id, Check: status in ('Active', 'Inactive')	All Required
distributor_order 	order_id (INT), distributor_id (INT), order_date (DATE), delivery_date (DATE)	PK: order_id, FK: distributor_id references distributor	All Required
order_item 	order_id (INT), product_id (INT), quantity (INT)	PK: (order_id, product_id), FKs: order_id, product_id	All Required
warehouse_stock  	warehouse_id (INT), product_id (INT), stock_quantity (INT), receipt_date (DATE), expiry_date (DATE)	PK: (warehouse_id, product_id), FK: product_id references product	All Required

Example: A product with product_id 101 belongs to category_id 5 (Groceries)

# Relationships

Tables linked	Relationship	Meaning
category to product	One (1) to Many	Each category can classify one or many products. Each product must belong to exactly one valid category.
distributor to distributor_order	One (1) to Many	Each distributor can place one or many orders over time. Each order must be associated with exactly one registered distributor.
distributor_order to order_item	One (1) to Many	Each order must reference at least one order item. Each order item belongs to exactly one order.
product to order_item	One (1) to Many	A product can appear in one or many order items. Each order item references exactly one product.
product to warehouse_stock	One (1) to Many	Each product can be stocked in one or across many warehouses. Each warehouse stock record references one product.

# Business rules and constraints

* Rule 1 (Unique product ID and valid category): Enforced via the primary key on product and a foreign key to category.
* Rule 2 (Registered distributor and at least one item): Enforced by the foreign key to distributor on orders and by application logic/triggers which will not allow an order to exist without at least one associated order_item record. A key alone won't be sufficient to enforce the minimum number of child items.
* Rule 3 (Positive quantities and stock limits): Positive integers are enforced via a CHECK constraint (quantity > 0). Stock limits require a trigger or application validation to check that ordered quantities do not exceed available levels in warehouse_stock.
* Rule 4 (Composite key for stock levels): Enforced by defining a composite primary key of (warehouse_id, product_id) on the warehouse_stock table.
* Rule 5 (Future expiry dates): Enforced via a CHECK constraint ensuring expiry_date > receipt_date. A key cannot validate logical date comparisons.
* Rule 6 (No product deletion if referenced in active orders): Enforced via foreign key RESTRICT rules or a trigger that blocks product deletion if active distributor orders reference it. Keys cannot check business operational states like "active".
* Rule 7 (Delivery date >= order date): Enforced via a CHECK constraint on distributor_order (delivery_date >= order_date).
* Rule 8 (Distributor status Active or Inactive): Enforced via a CHECK constraint on the status column.
