# Sales Management Database — SQL Analysis Project

A relational database project built to practice and demonstrate core SQL skills — schema design, multi-table joins, aggregate functions, and window functions — using a simulated sales management system.

## Project Overview

This project models a sales management system with **7 interrelated tables**: offices, employees, product lines, products, customers, orders, order details, and payments. The database was built from scratch (schema + sample data), followed by a series of queries ranging from basic filtering to advanced window function analysis.

## Database Schema

The database consists of the following tables and relationships:

- **offices** → employees are assigned to offices
- **employee** → reports to other employees (self-referencing), tied to an office
- **productlines** → categorizes products
- **products** → belongs to a product line
- **customers** → assigned to a sales rep (employee)
- **orders** → placed by a customer
- **orderdetails** → line items linking orders to products (composite primary key)
- **payments** → payments made by a customer

## Tools Used

- MySQL
- MySQL Workbench

## Key Queries & Insights

### 1. Rank Customers by Total Payments (per State)
**Business question:** Who is the top-paying customer in each state?

Uses `RANK()` with `PARTITION BY` to rank customers within their state based on total payments made.

![Query 1 Output](Screenshot%202026-07-06%20134454.png)

---

### 2. Running Total of Payments Over Time
**Business question:** How does cumulative revenue build up over time?

Uses `SUM() OVER (ORDER BY paymentDate)` to calculate a running total — useful for tracking revenue trends.

![Query 2 Output](Screenshot%202026-07-06%20134653.png)

---

### 3. Compare Order Quantities Using LAG()
**Business question:** How does demand for a product change from one order to the next?

Uses `LAG()` to compare each order's quantity against the previous order of the same product.

![Query 3 Output](Screenshot%202026-07-06%20134737.png)

---

### 4. Total Sales by Employee (Multi-Table Join)
**Business question:** Which sales rep generates the most revenue through their customers?

Joins **4 tables** (employee → customers → orders → orderdetails) to calculate total sales per employee, ordered by revenue.

![Query 4 Output](Screenshot%202026-07-06%20134755.png)

---

## Additional SQL Concepts Covered

Beyond the queries above, the project also includes:
- Aggregate functions (`MAX`, `MIN`, `AVG`, `SUM`, `COUNT`)
- Filtering with `WHERE`, `LIKE`, and subqueries
- `GROUP BY` with multiple aggregates
- `UPDATE` and `DELETE` operations (including safe-mode handling)
- All major JOIN types across the schema

Full schema, sample data, and all queries are available in [`queries.sql`](queries.sql).

## What I'd Explore Next

- Add more sample data to test window functions across larger partitions
- Introduce CTEs (`WITH` clause) for more readable multi-step queries
- Build a small dashboard (Power BI / Tableau) on top of these queries

## Notes

This project was built while learning SQL through structured coursework, then extended with custom business questions and window function queries to go beyond the original course material.
