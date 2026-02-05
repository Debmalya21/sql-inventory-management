-- =========================================
-- INVENTORY MANAGEMENT SQL PROJECT
-- Author: Debmalya Roy
-- Database: SQL Server
-- =========================================


-- =========================================
-- DATABASE INITIALIZATION
-- =========================================


CREATE DATABASE INVENTORY;
USE INVENTORY;
GO

-- =========================================
-- SCHEMA DESIGN (TABLE CREATION)
-- =========================================
-- Tables:
-- 1. SUPPLIER
-- 2. PRODUCT
-- 3. CUSTOMER
-- 4. ORDERS
-- 5. ORDER_DETAILS
-- 6. STOCK


-- Creating SUPPLIER Table
CREATE TABLE SUPPLIER (
SID CHAR (5) PRIMARY KEY,   -- SUPPLIER ID
SNAME VARCHAR (25) NOT NULL  ,         -- SUPPLIER NAME
SADD VARCHAR (50)  NOT NULL ,        -- SUPPLIER ADDRESS
SCITY VARCHAR (15) DEFAULT 'DELHI',    --- SUPPLIER CITY
SPHONE CHAR(10) NOT NULL  UNIQUE ,              -- SUPPLIER PHONE NUMBER
SEMAIL VARCHAR (40)                      -- SUPPLIER EMAIL ID
)


-- Creating Product Table
CREATE TABLE PRODUCT (
    PID CHAR(5) PRIMARY KEY,
    PDESC VARCHAR(25) NOT NULL,
    PRICE DECIMAL(13,2) NOT NULL CHECK (PRICE > 0),
    CATEGORY CHAR(2) NOT NULL
        CHECK (CATEGORY IN ('IT', 'HA', 'HC')),
    SID CHAR(5) NOT NULL,
    CONSTRAINT FK_PRODUCT_SUPPLIER
        FOREIGN KEY (SID) REFERENCES SUPPLIER(SID)
);



-- Creating CUSTOMER Table
CREATE TABLE CUSTOMER (
    CID CHAR(5) PRIMARY KEY,          -- CUSTOMER ID
    CNAME VARCHAR(30) NOT NULL,        -- CUSTOMER NAME
    CADD VARCHAR(50) NOT NULL,         -- CUSTOMER ADDRESS
    CCITY VARCHAR(20),                 -- CUSTOMER CITY
    CPHONE CHAR(10) NOT NULL UNIQUE,   -- CUSTOMER PHONE
    CEMAIL VARCHAR(40),                -- CUSTOMER EMAIL
    DOB DATE NOT NULL,                 -- DATE OF BIRTH
    CONSTRAINT CHK_CUSTOMER_AGE
        CHECK (DOB <= DATEADD(YEAR, -18, GETDATE()))
);




-- Creating ORDERS Table
CREATE TABLE ORDERS (
    OID CHAR(6) PRIMARY KEY,           -- ORDER ID
    ODATE DATE NOT NULL DEFAULT GETDATE(), -- ORDER DATE
    CID CHAR(5) NOT NULL,              -- CUSTOMER ID
    CONSTRAINT FK_ORDERS_CUSTOMER
        FOREIGN KEY (CID) REFERENCES CUSTOMER(CID)
);




-- Creating ORDER_DETAILS Table
CREATE TABLE ORDER_DETAILS (
    OID CHAR(6) NOT NULL,              -- ORDER ID
    PID CHAR(5) NOT NULL,              -- PRODUCT ID
    OQTY INT NOT NULL CHECK (OQTY > 0),-- ORDER QUANTITY
    OPPRICE DECIMAL(13,2) NOT NULL CHECK (OPPRICE > 0), -- PRICE AT ORDER TIME
    CONSTRAINT PK_ORDER_DETAILS
        PRIMARY KEY (OID, PID),
    CONSTRAINT FK_OD_ORDERS
        FOREIGN KEY (OID) REFERENCES ORDERS(OID),
    CONSTRAINT FK_OD_PRODUCT
        FOREIGN KEY (PID) REFERENCES PRODUCT(PID)
);




-- Creating STOCK Table
CREATE TABLE STOCK (
    PID CHAR(5) PRIMARY KEY,           -- PRODUCT ID
    QTY INT NOT NULL CHECK (QTY >= 0),  -- AVAILABLE QUANTITY
    ROL INT NOT NULL CHECK (ROL > 0),   -- REORDER LEVEL
    MOQ INT NOT NULL CHECK (MOQ > 0),   -- MINIMUM ORDER QUANTITY
    CONSTRAINT FK_STOCK_PRODUCT
        FOREIGN KEY (PID) REFERENCES PRODUCT(PID)
);



-- =========================
-- DATA INSERTION
-- =========================

INSERT INTO SUPPLIER (SID, SNAME, SADD, SCITY, SPHONE, SEMAIL)
VALUES
('S001', 'TechSource Pvt Ltd', 'Sector 5, Salt Lake', 'Kolkata', '9876543210', 'contact@techsource.com'),
('S002', 'HomeNeeds Ltd', 'MG Road', 'Delhi', '9123456789', 'sales@homeneeds.in'),
('S003', 'HealthPlus Corp', 'Banjara Hills', 'Hyderabad', '9988776655', 'info@healthplus.com'),
('S004', 'ElectroHub', 'Andheri East', 'Mumbai', '9090909090', 'support@electrohub.in'),
('S005', 'SmartWare Solutions', 'Whitefield', 'Bangalore', '9012345678', 'hello@smartware.com');


INSERT INTO PRODUCT (PID, PDESC, PRICE, CATEGORY, SID)
VALUES
-- IT Products
('P001', 'Laptop', 55000.00, 'IT', 'S001'),
('P002', 'Desktop', 42000.00, 'IT', 'S001'),
('P003', 'Router', 2500.00, 'IT', 'S002'),
('P004', 'Keyboard', 800.00, 'IT', 'S002'),
('P005', 'Mouse', 500.00, 'IT', 'S004'),
('P006', 'Monitor', 12000.00, 'IT', 'S004'),

-- Home Appliances
('P007', 'Refrigerator', 32000.00, 'HA', 'S002'),
('P008', 'Washing Machine', 28000.00, 'HA', 'S003'),
('P009', 'Microwave Oven', 15000.00, 'HA', 'S003'),
('P010', 'Air Conditioner', 40000.00, 'HA', 'S005'),
('P011', 'Water Purifier', 18000.00, 'HA', 'S005'),

-- Healthcare
('P012', 'BP Monitor', 2500.00, 'HC', 'S003'),
('P013', 'Thermometer', 500.00, 'HC', 'S003'),
('P014', 'Glucometer', 3000.00, 'HC', 'S005'),
('P015', 'Pulse Oximeter', 2200.00, 'HC', 'S005');

INSERT INTO SUPPLIER (SID, SNAME, SADD, SCITY, SPHONE, SEMAIL)
VALUES
('S001', 'TechSource Pvt Ltd', 'Sector 5, Salt Lake', 'Kolkata', '9876543210', 'contact@techsource.com'),
('S002', 'HomeNeeds Ltd', 'MG Road', 'Delhi', '9123456789', 'sales@homeneeds.in'),
('S003', 'HealthPlus Corp', 'Banjara Hills', 'Hyderabad', '9988776655', 'info@healthplus.com'),
('S004', 'ElectroHub', 'Andheri East', 'Mumbai', '9090909090', 'support@electrohub.in'),
('S005', 'SmartWare Solutions', 'Whitefield', 'Bangalore', '9012345678', 'hello@smartware.com');


INSERT INTO PRODUCT (PID, PDESC, PRICE, CATEGORY, SID)
VALUES
-- IT Products
('P001', 'Laptop', 55000.00, 'IT', 'S001'),
('P002', 'Desktop', 42000.00, 'IT', 'S001'),
('P003', 'Router', 2500.00, 'IT', 'S002'),
('P004', 'Keyboard', 800.00, 'IT', 'S002'),
('P005', 'Mouse', 500.00, 'IT', 'S004'),
('P006', 'Monitor', 12000.00, 'IT', 'S004'),

-- Home Appliances
('P007', 'Refrigerator', 32000.00, 'HA', 'S002'),
('P008', 'Washing Machine', 28000.00, 'HA', 'S003'),
('P009', 'Microwave Oven', 15000.00, 'HA', 'S003'),
('P010', 'Air Conditioner', 40000.00, 'HA', 'S005'),
('P011', 'Water Purifier', 18000.00, 'HA', 'S005'),

-- Healthcare
('P012', 'BP Monitor', 2500.00, 'HC', 'S003'),
('P013', 'Thermometer', 500.00, 'HC', 'S003'),
('P014', 'Glucometer', 3000.00, 'HC', 'S005'),
('P015', 'Pulse Oximeter', 2200.00, 'HC', 'S005');


INSERT INTO STOCK (PID, QTY, ROL, MOQ)
VALUES
-- IT Products
('P001', 20, 15, 10),
('P002', 8, 10, 5),
('P003', 50, 20, 10),
('P004', 100, 30, 15),
('P005', 12, 20, 10),
('P006', 5, 10, 5),

-- Home Appliances
('P007', 6, 10, 5),
('P008', 15, 10, 5),
('P009', 9, 12, 6),
('P010', 3, 8, 4),
('P011', 18, 15, 8),

-- Healthcare
('P012', 40, 20, 10),
('P013', 150, 50, 25),
('P014', 7, 10, 5),
('P015', 4, 10, 5);



INSERT INTO CUSTOMER (CID, CNAME, CADD, CCITY, CPHONE, CEMAIL, DOB)
VALUES
('C001', 'Amit Sharma', 'Lajpat Nagar', 'Delhi', '9810000001', 'amit@gmail.com', '1992-04-12'),
('C002', 'Neha Verma', 'Salt Lake', 'Kolkata', '9810000002', 'neha@gmail.com', '1995-08-22'),
('C003', 'Rahul Singh', 'Indiranagar', 'Bangalore', '9810000003', 'rahul@gmail.com', '1988-11-05'),
('C004', 'Pooja Iyer', 'Adyar', 'Chennai', '9810000004', 'pooja@gmail.com', '1990-02-18'),
('C005', 'Arjun Mehta', 'Bodakdev', 'Ahmedabad', '9810000005', 'arjun@gmail.com', '1985-06-30'),
('C006', 'Sneha Roy', 'Behala', 'Kolkata', '9810000006', 'sneha@gmail.com', '1997-09-10'),
('C007', 'Rohit Gupta', 'Karol Bagh', 'Delhi', '9810000007', 'rohit@gmail.com', '1993-01-25'),
('C008', 'Kavita Nair', 'Vashi', 'Mumbai', '9810000008', 'kavita@gmail.com', '1989-07-14'),
('C009', 'Suresh Kumar', 'Yelahanka', 'Bangalore', '9810000009', 'suresh@gmail.com', '1986-03-09'),
('C010', 'Ananya Das', 'New Town', 'Kolkata', '9810000010', 'ananya@gmail.com', '1998-12-01'),
('C011', 'Vikram Patel', 'Alkapuri', 'Vadodara', '9810000011', 'vikram@gmail.com', '1984-05-19'),
('C012', 'Riya Sen', 'Garia', 'Kolkata', '9810000012', 'riya@gmail.com', '1996-10-27'),
('C013', 'Kunal Shah', 'Andheri West', 'Mumbai', '9810000013', 'kunal@gmail.com', '1991-08-08'),
('C014', 'Meera Joshi', 'Kothrud', 'Pune', '9810000014', 'meera@gmail.com', '1987-02-02'),
('C015', 'Nitin Malhotra', 'Rajouri Garden', 'Delhi', '9810000015', 'nitin@gmail.com', '1994-11-11'),
('C016', 'Priya Kulkarni', 'Baner', 'Pune', '9810000016', 'priya@gmail.com', '1999-06-21'),
('C017', 'Manish Jain', 'Civil Lines', 'Jaipur', '9810000017', 'manish@gmail.com', '1983-09-30'),
('C018', 'Swati Mishra', 'Patia', 'Bhubaneswar', '9810000018', 'swati@gmail.com', '1995-01-16'),
('C019', 'Deepak Yadav', 'Gomti Nagar', 'Lucknow', '9810000019', 'deepak@gmail.com', '1989-04-07'),
('C020', 'Ayesha Khan', 'Malad East', 'Mumbai', '9810000020', 'ayesha@gmail.com', '1992-12-28');


INSERT INTO ORDERS (OID, ODATE, CID)
VALUES
('O001', '2025-01-05', 'C001'),
('O002', '2025-01-06', 'C002'),
('O003', '2025-01-06', 'C003'),
('O004', '2025-01-07', 'C001'),
('O005', '2025-01-08', 'C004'),
('O006', '2025-01-09', 'C005'),
('O007', '2025-01-10', 'C006'),
('O008', '2025-01-10', 'C002'),
('O009', '2025-01-11', 'C007'),
('O010', '2025-01-12', 'C008'),
('O011', '2025-01-12', 'C009'),
('O012', '2025-01-13', 'C010'),
('O013', '2025-01-14', 'C003'),
('O014', '2025-01-15', 'C011'),
('O015', '2025-01-16', 'C012'),
('O016', '2025-01-17', 'C013'),
('O017', '2025-01-18', 'C014'),
('O018', '2025-01-18', 'C001'),
('O019', '2025-01-19', 'C015'),
('O020', '2025-01-20', 'C016'),
('O021', '2025-01-21', 'C017'),
('O022', '2025-01-22', 'C018'),
('O023', '2025-01-23', 'C019'),
('O024', '2025-01-24', 'C020'),
('O025', '2025-01-25', 'C002');

INSERT INTO ORDER_DETAILS (OID, PID, OQTY, OPPRICE)
VALUES
('O001', 'P001', 1, 55000),
('O001', 'P004', 2, 800),
('O002', 'P007', 1, 32000),
('O003', 'P003', 2, 2500),
('O003', 'P005', 1, 500),
('O004', 'P002', 1, 42000),
('O005', 'P009', 1, 15000),
('O005', 'P013', 2, 500),
('O006', 'P010', 1, 40000),
('O007', 'P006', 1, 12000),
('O007', 'P004', 1, 800),
('O008', 'P001', 1, 55000),
('O009', 'P011', 1, 18000),
('O010', 'P012', 2, 2500),
('O011', 'P008', 1, 28000),
('O012', 'P014', 1, 3000),
('O013', 'P002', 1, 42000),
('O013', 'P005', 2, 500),
('O014', 'P007', 1, 32000),
('O015', 'P003', 1, 2500),
('O015', 'P004', 1, 800),
('O016', 'P010', 1, 40000),
('O017', 'P015', 2, 2200),
('O018', 'P001', 1, 55000),
('O018', 'P006', 1, 12000),
('O019', 'P009', 1, 15000),
('O020', 'P003', 3, 2500),
('O021', 'P011', 1, 18000),
('O022', 'P012', 1, 2500),
('O023', 'P008', 1, 28000),
('O024', 'P014', 2, 3000),
('O025', 'P005', 3, 500);

-- =========================
-- BUSINESS QUESTIONS
-- =========================
 -----------------------------------------------------------------------------------------------------
                     -------------------------------------Revenue & Supplier Analysis-------------------------------------
                     -----------------------------------------------------------------------------------------------------

--  Business Question 1
--  What is the total revenue generated from all orders?

CREATE VIEW VW_ORDER_LINE_REVENUE
AS 
SELECT OID,
       PID,
	   OQTY,
	   OPPRICE, 
	   OQTY*OPPRICE AS LINE_REVENUE
	   FROM ORDER_DETAILS;

SELECT SUM(LINE_REVENUE) AS TOTAL_REVENUE_GENERATED FROM VW_ORDER_LINE_REVENUE;



-- Business Question 2
-- What are the top 5 products by total revenue?



SELECT TOP 5
       P.PID,
       P.PDESC, 
	   SUM(O.OQTY*O.OPPRICE) AS  TOTAL_REVENUE 
FROM ORDER_DETAILS O
INNER JOIN PRODUCT P
ON O.PID= P.PID
GROUP BY 
    P.PID,
    P.PDESC
ORDER BY TOTAL_REVENUE DESC;


-- Business Question 3
-- Which supplier has generated the highest total revenue?

SELECT TOP 1
       P.SID, 
	   SUM(O.OQTY*O.OPPRICE) AS TOTAL_REVENUE
FROM ORDER_DETAILS O
INNER JOIN PRODUCT P
ON O.PID=P.PID
GROUP BY
        P.SID		
ORDER BY TOTAL_REVENUE DESC;


-- Business Question 4
-- What percentage of total revenue does each supplier contribute?

WITH SUPPLIER_REVENUE AS (
       SELECT S.SID,
	          S.SNAME,
			  SUM(O.OQTY*O.OPPRICE) AS SUPPLIER_REVENUE
			  FROM ORDER_DETAILS O
			  INNER JOIN PRODUCT P ON P.PID=O.PID
			  INNER JOIN SUPPLIER S ON P.SID=S.SID
              GROUP BY 
              S.SID,S.SNAME
),
TOTAL_REVENUE AS (
              SELECT SUM(SUPPLIER_REVENUE) AS GRAND_TOTAL
			  FROM SUPPLIER_REVENUE )

SELECT 
       SR.SID,
       SR.SNAME,
       SR.SUPPLIER_REVENUE,
       ROUND((SR.SUPPLIER_REVENUE * 100.0) / TR.GRAND_TOTAL, 2) AS REVENUE_CONTRIBUTION_PERCENT
FROM SUPPLIER_REVENUE SR
CROSS JOIN TOTAL_REVENUE TR
ORDER BY
       REVENUE_CONTRIBUTION_PERCENT DESC;


--   Business Question 5
---  Which suppliers together contribute to ~80% of total revenue?

WITH SUPPLIER_REVENUE AS (
       SELECT S.SID,
	          S.SNAME,
			  SUM(O.OQTY*O.OPPRICE) AS SUPPLIER_REVENUE
			  FROM ORDER_DETAILS O
			  INNER JOIN PRODUCT P ON P.PID=O.PID
			  INNER JOIN SUPPLIER S ON P.SID=S.SID
              GROUP BY 
              S.SID,S.SNAME
),
PARETO_BASE AS (
        SELECT SID,
		       SNAME,
			   SUPPLIER_REVENUE,
			   SUM(SUPPLIER_REVENUE) OVER() AS TOTAL_REVENUE,
			   SUM(SUPPLIER_REVENUE) OVER (ORDER BY SUPPLIER_REVENUE DESC) AS CUMULATIVE_REVENUE
			   FROM SUPPLIER_REVENUE
			   )

SELECT SID,
       SNAME,
	   SUPPLIER_REVENUE,
	   ROUND((CUMULATIVE_REVENUE*100.0)/TOTAL_REVENUE,2) 
	   AS CUMULATIVE_REVENUE_PERCENTAGE
	   FROM PARETO_BASE
	   WHERE (CUMULATIVE_REVENUE*100.0)/ TOTAL_REVENUE <= 80.0
	   ORDER BY SUPPLIER_REVENUE DESC;


-- Only two suppliers (S001 and S005) together contribute ~65% of total revenue, confirming a strong revenue concentration.




                     -----------------------------------------------------------------------------------------------------
                     -------------------------------------Inventory Control & Operations-------------------------------------
                     -----------------------------------------------------------------------------------------------------
-- Business Question 6 
-- Which products currently have stock below their reorder level and require immediate replenishment?

WITH REORDER_CHECK AS (
SELECT 
      P.PID,
	  P.PDESC,
	  S.QTY AS CURRENT_STOCK,
	  S.ROL AS REORDER_LEVEL
	  FROM PRODUCT P
	  JOIN STOCK S
	  ON P.PID=S.PID
	  WHERE S.QTY<=S.ROL
)
	  SELECT * FROM REORDER_CHECK
	  ORDER BY (REORDER_LEVEL-CURRENT_STOCK) DESC;

-- Business Question 7 
-- How much quantity should be reordered for each product to reach the reorder level?

WITH REQUIRED_QUANTITY_REORDER AS(
SELECT 
       P.PID,
	   P.PDESC,
	   S.QTY AS CURRENT_STOCK,
	   S.ROL AS REORDER_LEVEL,
	   (S.ROL-S.QTY ) AS REORDER_QUANTITY_REQUIRED
	   FROM PRODUCT P
	   JOIN STOCK S
	       ON P.PID=S.PID
       WHERE S.QTY<S.ROL )
	   SELECT * FROM REQUIRED_QUANTITY_REORDER
	   ORDER BY REORDER_QUANTITY_REQUIRED DESC;
	   


-- Business Question 8
-- Which suppliers are most critical based on inventory dependency and low-stock exposure?
-- (Critical Supply Chain Risk)

WITH SUPPLYCHAINRISK AS (
SELECT 
    SUP.SID,
    SUP.SNAME,
    COUNT(P.PID) AS TOTAL_PRODUCTS_SUPPLIED,
    SUM(CASE 
            WHEN S.QTY < S.ROL THEN 1 
            ELSE 0 
        END) AS LOW_STOCK_PRODUCTS
FROM SUPPLIER SUP
JOIN PRODUCT P
    ON SUP.SID = P.SID
JOIN STOCK S
    ON P.PID = S.PID
GROUP BY SUP.SID, SUP.SNAME)
SELECT * FROM SUPPLYCHAINRISK
ORDER BY LOW_STOCK_PRODUCTS DESC;


