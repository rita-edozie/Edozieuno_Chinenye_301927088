Active distributor order

-- Retrieve all orders placed by active distributors, ordered chronologically
SELECT o.order_id, d.distributor_name, o.order_date, o.delivery_date
FROM distributor_order o
JOIN distributor d ON o.distributor_id = d.distributor_id
WHERE d.status = 'Active'
ORDER BY o.order_date, o.order_id;

Products lacking warehouse stock

-- Find products that currently have no registered warehouse stock entries
SELECT p.product_id, p.product_name
FROM product p
WHERE NOT EXISTS (
    SELECT 1 
    FROM warehouse_stock ws 
    WHERE ws.product_id = p.product_id
)
ORDER BY p.product_id;

Total ordered quantity per product (including zero stock/zero order items)

-- Calculate the total ordered quantity for each product, ensuring items with no orders are included with zero totals
SELECT p.product_id, p.product_name, 
    COALESCE(SUM(oi.quantity), 0) AS total_ordered_quantity
FROM product p
LEFT JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id;