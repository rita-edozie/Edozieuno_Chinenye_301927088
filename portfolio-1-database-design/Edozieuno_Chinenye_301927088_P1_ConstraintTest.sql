=====================================================================                                                         -- Each statement is expected to trigger a constraint violation error.
-- Wrapped in BEGIN and ROLLBACK for safe testing.
-- =====================================================================

BEGIN;

-- 1. Test Foreign Key Constraint Violation (Inserting product with non-existent category_id)
INSERT INTO product (product_name, category_id)
VALUES ('Non-existent Category Product', 99999);

-- 2. Test NOT NULL Constraint Violation (Inserting product with NULL product_name)
INSERT INTO product (product_name, category_id) 
VALUES (NULL, (SELECT category_id FROM category WHERE category_name = 'Groceries'));

-- 3. Test Foreign Key Constraint Violation (Inserting order item with non-existent order_id)
INSERT INTO order_item (order_id, product_id, quantity) 
VALUES (99999, (SELECT product_id FROM product WHERE product_name = 'Cooking Oil 500ml'), 10);

-- 4. Test Check / Quantity Constraint Violation (Inserting negative or zero quantity)
INSERT INTO order_item (order_id, product_id, quantity) 
VALUES ((SELECT order_id FROM distributor_order LIMIT 1), (SELECT product_id FROM product WHERE product_name = 'Cooking Oil 500ml'), -5);

-- 5. Test Foreign Key Constraint Violation (Inserting order for a non-existent distributor)
INSERT INTO distributor_order (distributor_id, order_date, delivery_date) 
VALUES (99999, '2026-06-01', '2026-06-03');

ROLLBACK;