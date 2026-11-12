SELECT * FROM category WHERE category_name = 'Snacks';

BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO category (category_name) VALUES ('Snacks');

COMMIT;