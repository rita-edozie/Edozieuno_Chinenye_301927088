# Portfolio 3 Transactions and Concurrency

## ​Commit and rollback
​We used explicit transaction blocks (BEGIN, COMMIT, ROLLBACK) to manage changes to the distributor table. Successful updates like activating distributor 103 were saved permanently with COMMIT, while invalid changes—such as setting a status to 'Pending' which violated our check constraint—triggered an automatic error that allowed us to cleanly undo the entire transaction using ROLLBACK, protecting data integrity.

## ​Isolation and concurrency control
​Under the default READ COMMITTED isolation level, concurrent sessions safely handle data conflicts using row-level locks and unique constraints. When Session A inserted a new category ('Snacks'), a concurrent Session B attempting to insert the exact same name was blocked and forced to wait until Session A committed, after which Session B encountered a unique constraint violation and failed safely.

## Conclusion
​PostgreSQL's built-in transaction controls, check constraints, and unique indexes successfully maintained data consistency across our Pear-C Goods Distribution database operations. While isolation and locking protect against duplicate keys and conflicting modifications, database isolation alone does not enforce complex cross-table business rules, which still require triggers or application logic.

## ​Files
​sql/SessionA.sql — SQL Query for session A to insert into a category
​sql/SessionB.sql — SQL Query for session B to indicate constraint error
​sql/transactions_test.sql — SQL scripts for commit, rollback, and concurrency testing
​screenshots/SessionWaiting.png — Terminal capture showing Session B in a waiting state
​screenshots/ConcurrencyResult.png — Terminal capture showing the unique constraint error and final verified state

## ​References
​PostgreSQL Global Development Group. PostgreSQL Documentation: Chapter 13. Concurrency Control & Chapter 13.3. Isolation Levels.