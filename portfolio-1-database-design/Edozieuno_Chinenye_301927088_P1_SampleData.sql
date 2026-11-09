SELECT 'category' AS table_name, count(0) AS row_count FROM public.category
UNION ALL SELECT 'product', count(0) FROM public.product
UNION ALL SELECT 'distributor', count(0) FROM public.distributor
UNION ALL SELECT 'distributor_order', count(0) FROM public.distributor_order;

BEGIN;

-- 1. Insert Categories
INSERT INTO category (category_id, category_name) 
VALUES ('5', 'Groceries'), ('6', 'Cosmetics'), ('7', 'Household Items');

-- 2. Insert Products (referencing category_id via subquery lookup)
INSERT INTO product (product_id, product_name, category_id) 
VALUES ('30010', 'Cooking Oil 500ml', (SELECT category_id FROM category WHERE category_name = 'Groceries')), ('30012', 'Wheat Flour 1Kg', (SELECT category_id FROM category WHERE category_name = 'Groceries')), ('30030', 'Lip balm 10gm', (SELECT category_id FROM category WHERE category_name = 'Cosmetics')), ('30075', 'Food Processor 2.5L', (SELECT category_id FROM category WHERE category_name = 'Household Items'));

-- 3. Insert Distributors (including both 'Active' and 'Inactive' states)
INSERT INTO distributor (distributor_id, distributor_name, status) 
VALUES ('101', 'Lamdan Retailers', 'Active'), ('102', 'Fore Supermarket', 'Active'), ('103', 'First Choice Ltd.', 'Inactive');

-- 4. Insert Distributor Orders (Added '1008' and '1020' to match order items below)
INSERT INTO distributor_order (order_id, distributor_id, order_date, delivery_date) 
VALUES ('1001', (SELECT distributor_id FROM distributor WHERE distributor_name = 'Lamdan Retailers'), '2026-06-01', '2026-06-03'), ('1003', (SELECT distributor_id FROM distributor WHERE distributor_name = 'Fore Supermarket'), '2026-06-02', '2026-06-02'), ('1008', (SELECT distributor_id FROM distributor WHERE distributor_name = 'Fore Supermarket'), '2026-06-04', '2026-06-05'), ('1020', (SELECT distributor_id FROM distributor WHERE distributor_name = 'Lamdan Retailers'), '2026-06-05', '2026-06-07');

-- 5. Insert Order Items
INSERT INTO order_item (order_id, product_id, quantity) 
VALUES ((SELECT order_id FROM distributor_order WHERE order_id = '1001'), (SELECT product_id FROM product WHERE product_name = 'Cooking Oil 500ml'), 50), ((SELECT order_id FROM distributor_order WHERE order_id = '1008'), (SELECT product_id FROM product WHERE product_name = 'Lip balm 10gm'), 30), ((SELECT order_id FROM distributor_order WHERE order_id = '1020'), (SELECT product_id FROM product WHERE product_name = 'Food Processor 2.5L'), 20);

-- 6. Insert Warehouse Stock
INSERT INTO warehouse_stock (warehouse_id, product_id, stock_quantity, receipt_date, expiry_date) 
VALUES (1, (SELECT product_id FROM product WHERE product_name = 'Cooking Oil 500ml'), 500, '2026-05-01', '2027-05-01'), (1, (SELECT product_id FROM product WHERE product_name = 'Lip balm 10gm'), 200, '2026-05-10', '2026-11-10'), (2, (SELECT product_id FROM product WHERE product_name = 'Food Processor 2.5L'), 150, '2026-05-15', '2026-07-15');

COMMIT;