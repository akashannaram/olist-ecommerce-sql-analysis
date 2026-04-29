# 📊 E-Commerce Sales Analysis using SQL (Olist Dataset)

## 📌 Project Overview

This project analyzes a real-world Brazilian e-commerce dataset (Olist) using SQL to extract business insights related to customer behavior, sales performance, and delivery efficiency.

The goal of this project is to simulate real-world data analyst tasks by performing data cleaning, joining multiple tables, and generating actionable insights.

---

## 🧾 Dataset Description

The dataset consists of multiple relational tables:

* **customers** – customer details (city, state)
* **orders** – order-level information (timestamps, status)
* **order_items** – product-level details within each order
* **order_payments** – payment transactions
* **products** – product category information
* **sellers** – seller details

---

## 🛠️ Tools & Technologies

* PostgreSQL
* SQL (Joins, Aggregations, Window Functions)

---

## 📊 Key Performance Indicators (KPIs)

* **Total Revenue:** 16.01 Million
* **Total Orders:** 99,441
* **Average Order Value:** 154.10
* **Total Customers:** 99,441

---

## 🔍 Key Insights

* The platform generated approximately **16M in revenue**, indicating strong business activity.
* The **average order value (~154)** suggests moderate customer spending per purchase.
* The number of customers equals the number of orders, indicating:

  * Most customers are **one-time buyers**
  * There is **low customer retention**, highlighting an opportunity for improvement.
* **Credit cards are the most frequently used payment method**, showing customer preference for digital payments.
* Revenue is highly concentrated in a few states (e.g., **SP**), indicating geographic demand concentration.
* The majority of orders are successfully delivered, with relatively **few delays**, showing efficient logistics performance.

---

## 📈 SQL Analysis Performed

### 🔹 Basic Analysis

* Data exploration and filtering
* Handling NULL values
* Sorting and limiting results

### 🔹 Intermediate Analysis

* Aggregations using `GROUP BY`
* Multi-table joins
* Revenue and order analysis

### 🔹 Advanced Analysis

* Window functions (`RANK`, `SUM OVER`)
* Customer segmentation (High / Medium / Low value)
* Monthly revenue trends
* Delivery performance analysis

---

## 🚀 Business Impact

This project demonstrates the ability to:

* Work with real-world relational datasets
* Write optimized SQL queries for analysis
* Derive actionable business insights

---


## 🙋‍♂️ Author

**Akash Annaram**
 ( Data Analyast)
---

