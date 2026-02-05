# SQL Inventory Management & Sales Analysis Project

## Overview
This project demonstrates a complete **Inventory Management System** using **SQL Server**.  
It focuses on **sales analysis, supplier contribution, and inventory control** through real-world business questions.

The project is designed to reflect how SQL is used in real organizations for:
- Revenue analysis
- Supplier dependency assessment
- Stock replenishment decisions
- Operational risk identification

---

## Database Design
The system consists of the following tables:

- **SUPPLIER** – Supplier master information  
- **PRODUCT** – Product details linked to suppliers  
- **CUSTOMER** – Customer demographic data  
- **ORDERS** – Order-level transaction data  
- **ORDER_DETAILS** – Line-level sales data  
- **STOCK** – Inventory levels and reorder thresholds  

All tables are connected using **primary and foreign key constraints** to ensure data integrity.

---

## Key Business Questions Answered

### Revenue & Supplier Analysis
- Total revenue generated from all orders  
- Top revenue-generating products  
- Supplier-wise revenue contribution (%)  
- Pareto Analysis: Identifying suppliers contributing ~80% of revenue  

### Inventory Control & Operations
- Products below reorder level  
- Required reorder quantity per product  
- Supplier-wise inventory dependency and low-stock exposure  

---

## Key Insights
- A small number of suppliers contribute a majority of revenue, indicating **revenue concentration risk**.
- Several high-demand products are below reorder levels, requiring **immediate replenishment**.
- Certain suppliers supply multiple low-stock products, making them **critical to operations**.

---

## Skills Demonstrated
- Relational database design  
- SQL joins and aggregations  
- Window functions (cumulative revenue analysis)  
- Common Table Expressions (CTEs)  
- Business-oriented analytical thinking  

---

## How to Run the Project
1. Open **SQL Server Management Studio (SSMS)**
2. Execute the file `inventory_management.sql`
3. Run queries section-wise to view insights

---

## Author
**Debmalya Roy**
