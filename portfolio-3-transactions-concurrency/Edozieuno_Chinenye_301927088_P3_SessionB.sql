INSERT INTO category (category_name) VALUES ('Snacks');

ROLLBACK;

SELECT * FROM category WHERE category_name = 'Snacks';
