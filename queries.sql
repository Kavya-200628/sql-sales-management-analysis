-- ============================================================
-- SALES MANAGEMENT DATABASE - SQL PROJECT
-- ============================================================
-- This file contains:
-- 1. Database schema (tables, relationships)
-- 2. Sample data
-- 3. Basic queries (aggregate functions, filtering)
-- 4. Advanced queries (window functions, multi-table joins)
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SCHEMA
-- ============================================================

CREATE DATABASE salesmanagement;
USE salesmanagement;

CREATE TABLE offices (
  officeCode VARCHAR(50) PRIMARY KEY,
  city VARCHAR(50),
  addressLine1 VARCHAR(100),
  addressLine2 VARCHAR(100),
  phone VARCHAR(20),
  state VARCHAR(50),
  country VARCHAR(50),
  postalCode VARCHAR(50),
  territory VARCHAR(50)
);

CREATE TABLE employee (
  employeeNumber INT PRIMARY KEY,
  lastName VARCHAR(50),
  firstName VARCHAR(50),
  extension VARCHAR(50),
  email VARCHAR(50),
  officeCode VARCHAR(50),
  reportsTo INT,
  jobTitle VARCHAR(50),
  FOREIGN KEY (officeCode) REFERENCES offices(officeCode)
);

CREATE TABLE productlines (
  productLine VARCHAR(50) PRIMARY KEY,
  textDescription VARCHAR(255),
  htmlDescription MEDIUMTEXT,
  image LONGBLOB
);

CREATE TABLE products (
  productCode INT PRIMARY KEY,
  productName VARCHAR(50),
  productLine VARCHAR(50),
  productScale INT,
  productVendor VARCHAR(50),
  productDescription VARCHAR(100),
  quantityInStock INT,
  buyPrice DECIMAL(10,2),
  MSRP DECIMAL(10,2),
  FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

CREATE TABLE customers (
  customerNumber INT PRIMARY KEY,
  customerName VARCHAR(50),
  contactLastName VARCHAR(50),
  contactFirstName VARCHAR(50),
  phone VARCHAR(20),
  addressLine1 VARCHAR(100),
  addressLine2 VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(50),
  postalCode VARCHAR(50),
  country VARCHAR(50),
  salesRepEmployeeNumber INT,
  creditLimit DECIMAL(10,2)
);

CREATE TABLE orders (
  orderNumber INT PRIMARY KEY,
  orderDate DATE,
  requiredDate DATE,
  shippedDate DATE,
  status VARCHAR(50),
  comments VARCHAR(100),
  customerNumber INT,
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber INT,
  productCode INT,
  quantityOrdered INT,
  priceEach DECIMAL(10,2),
  orderLineNumber INT,
  PRIMARY KEY (orderNumber, productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
  FOREIGN KEY (productCode) REFERENCES products(productCode)
);

CREATE TABLE payments (
  checkNumber INT PRIMARY KEY,
  customerNumber INT,
  paymentDate DATE,
  amount DECIMAL(10,2),
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);


-- ============================================================
-- SECTION 2: SAMPLE DATA
-- ============================================================

-- offices
INSERT INTO offices (officeCode, city, addressLine1, addressLine2, phone, state, country, postalCode, territory)
VALUES
('FHEC-HI', 'SALEM', 'ABCD', 'EFGH', '2536456', 'TN', 'INDIA', 'CODE', 'HGFD'),
('FHEC-HIII', 'HARUR', 'RFCD', 'EFJH', '25358966', 'KERALA', 'INDIA', 'HUYR', 'NMNBCV'),
('FHEC-HELL', 'SALEM', 'EDCD', 'MKLOP', '12478963', 'TN', 'INDIA', 'CUYT', 'QWEFD');

-- employee
INSERT INTO employee (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES
(1, 'Kumar', 'Raj', 'x101', 'raj@company.com', 'FHEC-HI', NULL, 'Manager'),
(2, 'Priya', 'Sharma', 'x102', 'priya@company.com', 'FHEC-HIII', 1, 'Analyst'),
(3, 'Arun', 'Selvan', 'x103', 'arun@company.com', 'FHEC-HELL', 1, 'Analyst');

-- productlines
INSERT INTO productlines (productLine, textDescription, htmlDescription, image)
VALUES
('Classic Cars', 'Detailed models of classic cars', NULL, NULL),
('Motorcycles', 'Detailed models of motorcycles', NULL, NULL),
('Trucks', 'Detailed models of trucks', NULL, NULL);

-- products
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES
(1, 'Toyota Corolla', 'Classic Cars', 10, 'Toyota', 'Classic model car', 100, 50.00, 95.00),
(2, 'Harley Davidson', 'Motorcycles', 12, 'Harley', 'Classic motorcycle', 50, 75.00, 150.00),
(3, 'Ford Truck', 'Trucks', 8, 'Ford', 'Heavy duty truck', 30, 120.00, 250.00);

-- customers
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES
(1, 'Raj Stores', 'Kumar', 'Raj', '+91-9876543210', '12 Main St', NULL, 'Chennai', 'TN', '600001', 'India', 1, 50000.00),
(2, 'Priya Traders', 'Sharma', 'Priya', '+91-9876543211', '34 Park Ave', NULL, 'Bangalore', 'KA', '560001', 'India', 2, 75000.00),
(3, 'Arun Enterprises', 'Selvan', 'Arun', '+91-9876543212', '56 Lake Rd', NULL, 'Salem', 'TN', '636001', 'India', 3, 30000.00);

-- orders
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES
(101, '2024-01-15', '2024-01-20', '2024-01-18', 'Shipped', 'Deliver fast', 1),
(102, '2024-02-10', '2024-02-15', '2024-02-13', 'Shipped', NULL, 2),
(103, '2024-03-05', '2024-03-10', NULL, 'Pending', 'Urgent order', 3);

-- orderdetails
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES
(101, 1, 5, 95.00, 1),
(101, 2, 2, 150.00, 2),
(102, 3, 1, 250.00, 1),
(103, 1, 3, 95.00, 1);

-- payments
INSERT INTO payments (checkNumber, customerNumber, paymentDate, amount)
VALUES
(5001, 1, '2024-01-20', 475.00),
(5002, 2, '2024-02-15', 250.00),
(5003, 3, '2024-03-10', 285.00);


-- ============================================================
-- SECTION 3: DATA VERIFICATION
-- ============================================================

SELECT * FROM offices;
SELECT * FROM employee;
SELECT * FROM productlines;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;


-- ============================================================
-- SECTION 4: BASIC QUERIES (Filtering & Aggregate Functions)
-- ============================================================

SELECT MAX(priceEach) FROM orderdetails;

SELECT customerName FROM customers WHERE creditLimit < 50000;

SELECT COUNT(orderNumber) FROM orders WHERE status = 'Shipped';

SELECT MAX(quantityOrdered) FROM orderdetails;

SELECT COUNT(jobTitle) FROM employee;

SELECT MAX(amount) FROM payments;

SELECT email FROM employee WHERE email LIKE 'Raj%';

SELECT productName FROM products WHERE quantityInStock < 100;

-- Note: this UPDATE affects 0 rows since no product is named 'Food Truck'
-- (actual product name in the table is 'Ford Truck')
UPDATE products SET quantityInStock = 150 WHERE productName = 'Food Truck';

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- Note: this DELETE affects 0 rows due to a leading space in ' pending'
-- (actual status value in the table is 'Pending')
DELETE FROM orders WHERE status = ' pending';

DESCRIBE orders;

SELECT jobTitle, COUNT(jobTitle) FROM employee GROUP BY jobTitle;

SELECT COUNT(*) FROM customers WHERE state = 'TN';

SELECT AVG(buyPrice) FROM products;

SELECT MIN(creditLimit) FROM customers;

SELECT AVG(creditLimit) FROM customers WHERE state = 'TN';

SELECT AVG(buyPrice) FROM products WHERE productDescription LIKE 'classic%';

SELECT SUM(creditLimit) FROM customers WHERE creditLimit < 50000;

SELECT SUM(amount) FROM payments GROUP BY customerNumber;

SELECT COUNT(*) FROM orders GROUP BY status;

SELECT AVG(buyPrice) FROM products GROUP BY productLine;

-- Subquery: customers with credit limit above the average
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > (SELECT AVG(creditLimit) FROM customers);


-- ============================================================
-- SECTION 5: ADVANCED QUERIES (Window Functions & Multi-Joins)
-- ============================================================

-- Query 1: Rank customers by total payment within each state
-- Business question: Who is the top-paying customer in each state?
SELECT customerName, state,
       SUM(amount) AS totalPaid,
       RANK() OVER (PARTITION BY state ORDER BY SUM(amount) DESC) AS rankInState
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY customerName, state;


-- Query 2: Running total of payments over time
-- Business question: How does cumulative revenue build up over time?
SELECT paymentDate, amount,
       SUM(amount) OVER (ORDER BY paymentDate) AS runningTotal
FROM payments;


-- Query 3: Compare each order's quantity to the previous order of the same product
-- Business question: How does demand for a product change order-over-order?
SELECT o.orderNumber, p.productName, od.quantityOrdered,
       LAG(od.quantityOrdered) OVER (PARTITION BY od.productCode ORDER BY o.orderDate) AS previousOrderQty
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN products p ON od.productCode = p.productCode;


-- Query 4: Total sales generated by each employee through their customers
-- Business question: Which sales rep generates the most revenue?
SELECT e.firstName, e.lastName, c.customerName,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM employee e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.firstName, e.lastName, c.customerName
ORDER BY totalSales DESC;
