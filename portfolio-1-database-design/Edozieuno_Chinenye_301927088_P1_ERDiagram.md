erDiagram
    direction LR
mermaid
   ... category {
        INT category_id PK
        VARCHAR category_name UK
    }

    ...product {
        INT product_id PK
        VARCHAR product_name
        INT category_id FK
    }

    ...distributor {
        INT distributor_id PK
        VARCHAR distributor_name
        VARCHAR status
    }

    ...distributor_order {
        INT order_id PK
        INT distributor_id FK
        DATE order_date
        DATE delivery_date
    }

    ...order_item {
        INT order_id PK, FK
        INT product_id PK, FK
        INT quantity
    }

    ...warehouse_stock {
        INT warehouse_id PK
        INT product_id PK, FK
        INT stock_quantity
        DATE receipt_date
        DATE expiry_date
    }

    category ||--o{ product : "classifies"
    distributor ||--o{ distributor_order : "places"
    distributor_order ||--|{ order_item : "contains"
    product ||--o{ order_item : "appears_in"
    product ||--o{ warehouse_stock : "stocked_in"