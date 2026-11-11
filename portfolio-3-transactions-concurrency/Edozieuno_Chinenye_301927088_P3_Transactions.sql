SELECT distributor_id, distributor_name, status FROM distributor WHERE distributor_id IN (101, 103);

BEGIN;

UPDATE distributor 
SET status = 'Active' 
WHERE distributor_id = 103 AND status = 'Inactive';

COMMIT;

-- Repeat Check: Running this update again safely affects 0 rows
UPDATE distributor 
SET status = 'Active' 
WHERE distributor_id = 103 AND status = 'Inactive';

BEGIN;

-- Valid change inside the transaction block
UPDATE distributor 
SET status = 'Inactive' 
WHERE distributor_id = 101;

-- Deliberate constraint violation: 'Pending' is not allowed by table rules
UPDATE distributor 
SET status = 'Pending' 
WHERE distributor_id = 102;

ROLLBACK;

-- Check that distributor 103 is permanently Active (from Transaction 1 commit)
SELECT distributor_id, distributor_name, status FROM distributor WHERE distributor_id = 103;

-- Check that distributor 101 is still Active (demonstrating Transaction 2 rollback worked)
SELECT distributor_id, distributor_name, status FROM distributor WHERE distributor_id = 101;