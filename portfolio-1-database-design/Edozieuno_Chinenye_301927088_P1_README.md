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

This assessment scope includes category, products, varieties, warehouses, distributors, and orders using fictional data for a single regional center. It excludes retail point-of-sale transactions, payroll processing, and third-party logistics vehicle tracking.


## Design and implementation files

| File | Contents|
|------|---------|
| [Design] (Edozieuno_Chinenye_301927088_P1_Design.md) | System design specifications, case study details, and business rules |
| [ERDiagram] (Edozieuno_Chinenye_301927088_P1_ERDiagram.md) | Entity-Relationship diagram illustrating table entities and relationships |
| [Normalisation] (Edozieuno_Chinenye_301927088_P1_Normalisation.md) | Normalisation analysis up to Third Normal Form (3NF) |
| [Schema] (Edozieuno_Chinenye_301927088_P1_Schema.sql) | PostgreSQL DDL script creating tables, primary keys, foreign keys, and check constraints |
| [Sample_records] (Edozieuno_Chinenye_301927088_P1_SampleData.sql) | Sample data insertion script populating baseline records across all tables |
| [Constraint_tests] (Edozieuno_Chinenye_301927088_P1_Constraints.sql) | Test script verifying foreign key and check constraint violations |
| [Screenshots] (screenshots/) | Captured screenshots documenting test executions and final row-count verifications |

## Implementation

​The database was implemented under the database name pearc_goods_db running on a local PostgreSQL instance (PostgreSQL 16). The DDL schema (Edozieuno_Chinenye_301927088_P1_Schema.sql) was executed to create six core relational tables: category, product, distributor, distributor_order, order_item, and warehouse_stock. Each table was structured with appropriate primary keys, foreign key constraints utilizing RESTRICT and CASCADE deletion rules, and explicit declarative CHECK constraints to enforce data validity, such as permitted distributor status values (Active, Inactive), positive order and stock quantities, and future-dated inventory expiry checks.
​Sample data (Edozieuno_Chinenye_301927088_P1_SampleData.sql) was successfully populated into the database to establish operational records for categories, products, distributors, orders, order items, and warehouse inventory. Constraint tests (Edozieuno_Chinenye_301927088_P1_Constraints.sql) were executed within transactional blocks (BEGIN / ROLLBACK) to verify that the database correctly rejects invalid inputs. Visual evidence of the query execution and final table states was captured and stored in the screenshots/ directory.

## Test results

​All negative test cases defined in Edozieuno_Chinenye_301927088_P1_Constraints.sql executed successfully and behaved as expected. Specifically, PostgreSQL correctly intercepted and rejected attempts to insert products with non-existent category IDs, insert products with NULL names, reference non-existent order or distributor IDs in foreign keys, and submit non-positive quantities. Because these test blocks were wrapped in explicit transactions, all constraint violation errors correctly triggered rollbacks preserving data integrity.
​The positive sample data insertion script ran without errors, successfully inserting valid categories, products, active/inactive distributors, orders, order items, and multi-warehouse stock entries. Final row-count verification queries confirmed that all tables contain the expected initial data volume corresponding to the operational scope.
​Certain complex business rules—such as validating that order quantities do not exceed available warehouse stock (Rule 3), ensuring distributor deletion restrictions based on active order statuses (Rule 6), and enforcing a minimum of one order item per distributor order (Rule 2)—cannot be fully enforced via standard declarative table constraints alone. These rules were documented as requiring supplementary database triggers or application-level validation logic.
Reference: [PostgreSQL Global Development Group., PostgreSQL Documentation (Versions 15–16)](https://www.postgresql.org/docs/)