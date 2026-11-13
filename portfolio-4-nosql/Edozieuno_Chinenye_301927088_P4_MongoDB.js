// ==========================================
// Portfolio 4: MongoDB Event Log Implementation
// Case: Pear-C Goods Distribution
// Filename: Edozieuno_Chinenye_301927088_P4_MongoDB.js
// ==========================================

// 1. Select the Database
pearc_goods_db;

// 2. Check if the collection is empty
db.supply_chain_events.countDocuments();

// 3. Insert Four Fictional Event Documents in one insertMany block
db.supply_chain_events.insertMany([
  {
    "_id": "EVT-1001",
    "eventType": "OrderPlaced",
    "timestamp": ISODate("2026-06-01T08:30:00Z"),
    "sourceLocation": {
      "distributorId": 101,
      "distributorName": "Lamdan Retailers"
    },
    "eventDetails": {
      "orderId": 1001,
      "items": [
        { "productId": 30010, "productName": "Cooking Oil 500ml", "quantity": 50 }
      ],
      "deliveryDate": "2026-06-03"
    }
  },
  {
    "_id": "EVT-1008",
    "eventType": "OrderPlaced",
    "timestamp": ISODate("2026-06-04T10:15:00Z"),
    "sourceLocation": {
      "distributorId": 102,
      "distributorName": "Fore Supermarket"
    },
    "eventDetails": {
      "orderId": 1008,
      "items": [
        { "productId": 30030, "productName": "Lip balm 10gm", "quantity": 30 }
      ],
      "deliveryDate": "2026-06-05"
    }
  },
  {
    "_id": "EVT-2001",
    "eventType": "StockReceived",
    "timestamp": ISODate("2026-05-01T11:00:00Z"),
    "sourceLocation": {
      "warehouseId": 1,
      "locationName": "Regional Central Warehouse"
    },
    "eventDetails": {
      "productId": 30010,
      "productName": "Cooking Oil 500ml",
      "stockQuantity": 500,
      "receiptDate": "2026-05-01",
      "expiryDate": "2027-05-01"
    }
  },
  {
    "_id": "EVT-2002",
    "eventType": "StockReceived",
    "timestamp": ISODate("2026-05-15T14:20:00Z"),
    "sourceLocation": {
      "warehouseId": 2,
      "locationName": "North Hub Storage"
    },
    "eventDetails": {
      "productId": 30075,
      "productName": "Food Processor 2.5L",
      "stockQuantity": 150,
      "receiptDate": "2026-05-15",
      "expiryDate": "2026-07-15"
    }
  }
]);
// ==========================================
// 4. Queries & Expected Results
// ==========================================

// Query 1: Total Event Count
print("--- Query 1: Total Count ---");
db.supply_chain_events.countDocuments({});

// Query 2: Entity's Ordered Event History (Distributor 101)
print("--- Query 2: Distributor 101 Event History ---");
db.supply_chain_events.find({ "sourceLocation.distributorId": 101 }).sort({ timestamp: 1 }).toArray();

// Query 3: Nested-Field Filter (Find events involving Product ID 30010)
print("--- Query 3: Nested-Field Filter (Product ID 30010) ---");
db.supply_chain_events.find({
  $or: [
    { "eventDetails.items.productId": 30010 },
    { "eventDetails.productId": 30010 }
  ]
}).toArray();