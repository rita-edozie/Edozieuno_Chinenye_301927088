## Portfolio 2 Query Processing and Optimisation

## Queries and results
This portfolio analyses three core relational queries and benchmarks performance modifications:
1. Active Distributor Orders: Joins distributor_order and distributor tables, filtering by active status and sorting chronologically with an explicit tie-breaker (order_date, order_id).
2. Unstocked Products: Identifies products currently lacking entries in the warehouse_stock table using a NOT EXISTS subquery.
3. Total Ordered Quantity: Aggregates order quantities per product using a LEFT JOIN and COALESCE to ensure un-ordered items report a total of zero.

## Index comparison
| Phase | Scan Type | Three Execution Times | Median Time | Shared Buffer Hits (Run 3) |
|-------|-----------|-----------------------|-------------|----------------------------|
| Before Index | Seq Scan | 18.552 ms, 20.076 ms, 13.111 ms 18.552 ms | shared hit=1274 |
| After Index | Seq Scan 18.210 ms, 15.030 ms, 8.111 ms 15.030 ms | shared hit=1274 |

## Performance analysis
The query planner continued executing a Sequential Scan (Seq Scan) after creating the composite index (idx_dist_order_hist_dist_date) because the estimated cost threshold for fetching that percentage of rows did not justify an index lookup over a full table read. Micro-benchmarks exhibit inherent timing variance due to OS cache states and CPU scheduler jitter rather than structural query alterations. Furthermore, maintaining indexes introduces real storage and write overhead during INSERT, UPDATE, and DELETE operations, highlighting that indexes are selective tools rather than absolute guarantees of improved performance.

## Files
Edozieuno_Chinenye_301927088_P2_Queries.sql — Core query definitions and test queries.
Optimisation.sql — Benchmark setup, table generation, and index creation scripts.
Screenshots/ — Execution plan and console output captures.

## Reference
PostgreSQL Global Development Group. PostgreSQL Documentation: Chapter 11. Indexes & EXPLAIN.