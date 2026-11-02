# FMCG Distribution & Inventory Management System Normalisation

Normalisation separates information into related tables to reduce repeated details and avoid inconsistent updates.

## Starting order and inventory list
An unnormalised data structure places multiple items ordered within a single record and mixes inventory location details directly into product order records.

| distributor_id | distributor_name | status | order_id | order_date | delivery_date | Ordered items & Warehouse details |
|---|---|---|---|---|---|---|
| 10 | Lamdan Retailers | Active | 1001 | 2026-10-01 | 2026-10-03 | Product 101 (Rice, Category 5 - Groceries, Qty: 50, Warehouse 1, Stock: 200, Rec: 2026-09-01, Exp: 2027-09-01); Product 102 (Cooking oil, Category 5 - Groceries, Qty: 30, Warehouse 1, Stock: 150, Rec: 2026-09-01, Exp: 2027-09-01) |
| 20 | Fore Supermarket | Active | 1002 | 2026-10-02 | 2026-10-04 | Product 101 (Rice, Category 5 - Groceries, Qty: 20, Warehouse 1, Stock: 200, Rec: 2026-09-01, Exp: 2027-09-01) |

The first row contains two separate product orders inside a single cell. Searching for a specific product's sales or updating ordered quantities is difficult because data is bundled together.

## 1NF: One value per cell
First Normal Form (1NF) requires that every column cell contains only single, atomic (indivisible) values and that repeating groups are removed into individual rows.
| order_id | product_id | distributor_id | distributor_name | status | order_date | delivery_date | product_name | category_id | category_name | quantity | warehouse_id | stock_quantity | receipt_date | expiry_date |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1001 | 101 | 10 | Lamdan Retailers | Active | 2026-10-01 | 2026-10-03 | Rice | 5 | Groceries | 50 | 1 | 200 | 2026-09-01 | 2027-09-01 |
| 1001 | 102 | 10 | Lamdan Retailers | Active | 2026-10-01 | 2026-10-03 | Cooking oil | 5 | Groceries | 30 | 1 | 150 | 2026-09-01 | 2027-09-01 |
| 1002 | 101 | 20 | Fore Supermarket | Active | 2026-10-02 | 2026-10-04 | Rice | 5 | Groceries | 20 | 1 | 200 | 2026-09-01 | 2027-09-01 |

For this unseparated table, the primary key (the unique identifier for each row) is (order_id, product_id, warehouse_id).

## 2NF: Details depend on the whole key
Second Normal Form (2NF) includes 1NF and requires that every non-key field depends on the entire primary key, not just a portion of a composite key. A partial dependency occurs when an attribute relies on only one part of a multi-column primary key.

To achieve 2NF, tables are split so that every non-key attribute fully depends on its key.
distributor_order_unseparated
Key: order_id.
| order_id | distributor_id | distributor_name | status | order_date | delivery_date |
|---|---|---|---|---|---|
| 1001 | 10 | Lamdan Retailers | Active | 2026-10-01 | 2026-10-03 |
| 1002 | 20 | Fore Supermarket | Active | 2026-10-02 | 2026-10-04 |

product_unseparated
Key: product_id.
| product_id | product_name | category_id | category_name |
|---|---|---|---|
| 101 | Rice | 5 | Groceries |
| 102 | Cooking oil | 5 | Groceries |

warehouse_stock
Key: (warehouse_id, product_id). product_id links to product information.
| warehouse_id | product_id | stock_quantity | receipt_date | expiry_date |
|---|---|---|---|---|
| 1 | 101 | 200 | 2026-09-01 | 2027-09-01 |
| 1 | 102 | 150 | 2026-09-01 | 2027-09-01 |

order_item
Key: (order_id, product_id). order_id links to order details, and product_id links to product details.
| order_id | product_id | quantity |
|---|---|---|
| 1001 | 101 | 50 |
| 1001 | 102 | 30 |
| 1002 | 101 | 20 |

## 3NF: Keep details with the thing they describe
Third Normal Form (3NF) includes 2NF and requires that no non-key attribute depends on another non-key attribute (eliminating transitive dependencies).

category
Key: category_id.
| category_id | category_name |
|---|---|
| 5 | Groceries |

product
Key: product_id. category_id is a foreign key (a reference column pointing to a primary key in another table) linking to category.
| product_id | product_name | category_id |
|---|---|---|
| 101 | Rice | 5 |
| 102 | Cooking oil | 5 |

distributor
Key: distributor_id.
| distributor_id | distributor_name | status |
|---|---|---|
| 10 | Lamdan Retailers | Active |
| 20 | Fore Supermarket | Active |

distributor_order
Key: order_id. distributor_id is a foreign key linking to distributor.
| order_id | distributor_id | order_date | delivery_date |
|---|---|---|---|
| 1001 | 10 | 2026-10-01 | 2026-10-03 |
| 1002 | 20 | 2026-10-02 | 2026-10-04 |

order_item
Key: (order_id, product_id). Foreign keys: order_id references distributor_order, product_id references product.
| order_id | product_id | quantity |
|---|---|---|
| 1001 | 101 | 50 |
| 1001 | 102 | 30 |
| 1002 | 101 | 20 |

warehouse_stock
Key: (warehouse_id, product_id). Foreign key: product_id references product.
| warehouse_id | product_id | stock_quantity | receipt_date | expiry_date |
|---|---|---|---|---|
| 1 | 101 | 200 | 2026-09-01 | 2027-09-01 |
| 1 | 102 | 150 | 2026-09-01 | 2027-09-01 |
