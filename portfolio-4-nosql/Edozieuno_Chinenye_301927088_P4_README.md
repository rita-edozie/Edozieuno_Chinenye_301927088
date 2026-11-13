# Portfolio 4 NoSQL and Advanced Data Models

## ​Document model
​The pearc_goods_db database contains a supply_chain_events collection. Each document records one operational supply chain event (such as an order placement or warehouse stock receipt). Its fields are _id, eventType, timestamp, sourceLocation, and eventDetails.
​Distributor or warehouse identifiers and names are embedded in the sourceLocation sub-document. Order placement events contain an array of items with product IDs, names, and quantities; stock receipt events contain inventory metrics such as stock quantities, receipt dates, and expiry dates.
​Example order placement document:

{
  _id: "EVT-1001",
  eventType: "OrderPlaced",
  timestamp: ISODate("2026-06-01T08:30:00Z"),
  sourceLocation: {
    distributorId: 101,
    distributorName: "Lamdan Retailers"
  },
  eventDetails: {
    orderId: 1001,
    items: [
      { productId: 30010, productName: "Cooking Oil 500ml", quantity: 50 }
    ],
    deliveryDate: "2026-06-03"
  }
}

## Implementation and results
​Four fictional documents (EVT-1001, EVT-1008, EVT-2001, and EVT-2002) are inserted using mongosh via a single insertMany block, yielding acknowledgement with the corresponding inserted IDs. Running db.supply_chain_events.countDocuments() returns 4.
​The query filtering for Distributor 101 ({ "sourceLocation.distributorId": 101 }) sorted chronologically returns EVT-1001, showing Lamdan Retailers' order history. Nested-field queries successfully retrieve matching events across diverse event structures. These event logs are maintained separately; the core PostgreSQL relational database remains unchanged and operational.

## ​Why MongoDB fits
​An event log can keep its source location, timestamps, and event-specific details together in a self-contained document. Order placement events and stock receipt events have different structural attributes, which MongoDB accommodates without requiring rigid table schemas or sparse columns.
​A separate collection per event allows the historical event log to grow continuously over time without bloating core entity records. The embedded distributor and product names serve as point-in-time snapshots and do not automatically track subsequent relational updates in SQL. PostgreSQL continues to manage strict relational rules and stock constraint validation. This implementation does not enforce SQL foreign keys within MongoDB or synchronize data modifications between the two databases.

## Files
​Edozieuno_Chinenye_301927088_P4_MongoDB.js
MongoDBSource.list
​Setup.md
​screenshots/

## ​References
​MongoDB Documentation. Document Validation and Data Modeling Guidelines.
​MIT 8103 Database Design and Modelling Course Materials.