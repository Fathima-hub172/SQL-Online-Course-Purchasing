# 🛒 Online Purchasing Course – SQL Project

## 📌 Overview
This project demonstrates the design and implementation of a **SQL database system** for an online purchasing platform.  
It covers schema creation, relationships, queries, and reporting to simulate a real-world e‑commerce environment.

## 🎯 Objectives
- Build normalized tables for **Products, Customers, Orders, and Payments**
- Define **Primary Keys** and **Foreign Keys** for relational integrity
- Practice **SQL queries** for data retrieval, aggregation, and reporting
- Showcase **stored procedures, views, and joins** for business insights

## 🗂️ Database Schema
Key tables included:
- **Customers**: CustomerID, Name, Email, Phone, Address
- **Products**: ProductID, Name, Category, Price, Stock
- **Orders**: OrderID, CustomerID, ProductID, Quantity, OrderDate
- **Payments**: PaymentID, OrderID, Amount, PaymentDate, Method

## 🔑 Features
- **Data Retrieval**: View all customers, products, and orders
- **Business Queries**:
  - Top 3 highest-priced products
  - Total sales, average order value, and revenue reports
  - Departments with more than 10 employees (HR extension)
- **Advanced SQL**:
  - Stored procedures for fetching order details
  - Views for customer purchase history
  - Joins (INNER, LEFT, RIGHT) for multi-table analysis

## 🛠️ Tech Stack
- **SQL** (MySQL / PostgreSQL / SQL Server)
- Sample datasets with **Tamil names** for localization
