## Portfolio 5 Distributed and Cloud Database Exercise

## Current Setup
​The current implementation runs MongoDB version 8.0.34 locally inside an Ubuntu Codespace alongside PostgreSQL, using a local data directory (/workspaces/mongodb-data) bound to 127.0.0.1. The setup maintains the supply_chain_events collection containing fictional operational events for Pear-C Goods Distribution, such as distributor order placements (e.g., EVT-1001 for Lamdan Retailers) and warehouse stock receipts. The multi-node cluster topology and replication status are not verified in this standalone local environment.

## ​Proposed replication
​To provide high availability and fault tolerance for the event log, we propose deploying a three-member replica set. According to MongoDB Replication, a replica set consists of multiple data-holding and voting nodes that maintain identical copies of the dataset. This ensures that historical supply chain records, such as OrderPlaced events, remain accessible if a single node fails.

| Member | Starting role | Location |
|--------|---------------|----------|
| mongo-node-1 | Primary Availability | Zone A |
| mongo-node-2 | Secondary Availability | Zone B |
| mongo-node-3 | Secondary Availability | Zone C |

## Failure and consistency
If the primary node fails, the remaining nodes trigger an election following the MongoDB Replica Set Elections Guide to elect a new primary, causing a brief interruption in write operations. If a majority of voting nodes are unreachable, the replica set cannot elect a primary and becomes read-only. Utilizing MongoDB Write Concern with w: "majority" ensures writes are acknowledged only after successful replication to a majority of nodes, trading a small increase in latency for greater durability, while secondary replication lag is managed asynchronously. Relational rules, constraints, and operational business logic remain under the authority of PostgreSQL.

## Sharding and cloud deployment
Sharding distributes subsets of data across multiple database instances, which differs from replication that copies the identical dataset across nodes. Given the small scale of the current setup (four fictional events), Pear-C Goods Distribution does not require sharding. For a production cloud deployment, security requires authentication, encryption in transit and at rest, and restricted network access. Backups can be managed using MongoDB Atlas Backup and Restore. Cloud setups introduce additional financial costs and administrative overhead. Crucially, MongoDB replication or sharding does not replicate PostgreSQL or automatically synchronize data modifications between the two independent databases.

## References
MongoDB Replication Documentation
MongoDB Replica Set Elections Guide
MongoDB Write Concern Documentation
MongoDB Sharding Documentation
MongoDB Atlas Backup and Restore Documentation