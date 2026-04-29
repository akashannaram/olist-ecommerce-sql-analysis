-- Olist E-Commerce Data Base Table Creation 

-- 1.Customers Table

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
		customer_id VARCHAR(100) PRIMARY KEY,
		customer_unqie_id VARCHAR(100),
		customer_zip_code NUMERIC(100),
		customer_city VARCHAR(100),
		customer_state VARCHAR(50)
);

SELECT * FROM customers;

-- 2.Products Table 

DROP TABLE IF EXISTS products;
CREATE TABLE products(
		product_id VARCHAR(100) PRIMARY KEY,
		product_category_name VARCHAR(100),
		product_name_length INT,
		product_discription_length INT,
		procuct_photos_qty INT,
		product_weight_grm INT,
		product_length_cm INT,
		product_height_cm INT,
		product_width_cm INT
);

SELECT * FROM products;

-- 3.Sellers Table 

DROP TABLE IF EXISTS sellers;
CREATE TABLE sellers(
		seller_id VARCHAR(100) PRIMARY KEY,
		seller_zipcode VARCHAR(50),
		seller_city VARCHAR(100),
		seller_state VARCHAR(100)
);

SELECT * FROM sellers;

-- 4.Orders Table

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
		order_id VARCHAR(100) PRIMARY KEY,
		customer_id VARCHAR(100)REFERENCES customers (customer_id),
		order_status VARCHAR(50),
		order_purchase_timestamp TIMESTAMP,
		order_approved_at TIMESTAMP,
		order_delivered_carrier_date TIMESTAMP,
		order_delivered_customer_date TIMESTAMP,
		order_estimated_delivery_time TIMESTAMP
);

SELECT * FROM orders;

-- 5.Order Items Table

DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items(
		order_id VARCHAR(100)REFERENCES orders (order_id),
		order_item INT,
		product_id VARCHAR(100)REFERENCES products (product_id),
		seller_id VARCHAR(100) REFERENCES sellers (seller_id),
		shipping_limit_date TIMESTAMP,
		price DECIMAL(10,2),
		freight_value DECIMAL(10,2)
);

SELECT * FROM order_items;

-- 6.Orders Payments Table 

DROP TABLE IF EXISTS order_payments;
CREATE TABLE order_payments(
		order_id VARCHAR(100) REFERENCES orders (order_id),
		payment_sequential INT,
		payment_type VARCHAR(50),
		payment_installments INT,
		payment_value DECIMAL(10,2)
);

SELECT * FROM order_payments;

-- Row Counts In All Tables 

SELECT 'customers' AS table_name,
COUNT(*) AS ROW_COUNT FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL 
SELECT 'orders', COUNT(*) FROM orders
UNION ALL 
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL 
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT (*) FROM order_payments;

-- Preview Of Each Table

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sellers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM order_payments;

-- 1) Show all customers from orders?
SELECT orders.customer_id FROM orders;

-- 2) Show only customer_id and customer_city from customers?
SELECT customer_id, customer_city 
FROM customers;

-- 3) Show first 20 rows from products 
SELECT * FROM products
LIMIT 20;

-- 4) Show orders placed after 2017-01-01
SELECT * FROM orders
WHERE order_purchase_timestamp > '2017-01-01';

-- 5) Show cutomers from state sp
SELECT * FROM customers
WHERE customer_state='SP';

-- 6) Show products where catogey is null 
SELECT * FROM products
WHERE product_category_name IS NULL;

-- 7) show top 10 higherst priced products
SELECT * FROM order_items
ORDER BY price DESC
LIMIT 10;

-- 8) show lowest 10 freight values 
SELECT * FROM order_items
ORDER BY freight_value ASC
LIMIT 10;

-- 9) Show number of unique customer cities
SELECT COUNT(DISTINCT customer_city)
FROM customers;

-- 10) Show number of unique product categories
SELECT COUNT(DISTINCT product_category_name)
FROM products;

-- 11) show total number of orders
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- 12) Number of customers per state 
SELECT customer_state, COUNT(customer_id)
AS customers_per_state
FROM customers 
GROUP BY customer_state
ORDER BY customers_per_state DESC;

-- 13) Number of orders per status 
SELECT order_status, COUNT(order_id) 
AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 14) Total revenue per payment type
SELECT payment_type, SUM(payment_value)
AS total_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- 15) Average payment value per payment type 
SELECT payment_type, AVG(payment_value)
AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment_value DESC;

-- 16) Total orders per customer
SELECT customer_id, COUNT(order_id)
AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- 17) From which cities and states our orders are coming?
SELECT o.order_id, c.customer_city, c.customer_state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 18) How are customers paying for there orders?
SELECT o.order_id, p.payment_type, p.payment_value
FROM orders o 
JOIN order_payments p ON o.order_id = p.order_id;

-- 19) What products are customers buying and how much they are paying?
SELECT o.order_id, c.customer_state, product_id, price
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id;

-- 20) Are there any orders where payment is missing?
SELECT o.order_id, p.payment_type, p.payment_value
FROM orders o 
LEFT JOIN order_payments p ON o.order_id = p.order_id
WHERE p.order_id IS NULL;

-- 21) Which sellers are fulfilling the most orders?
SELECT seller_id, , COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC;

-- 22) Which products are being ordered the most?
SELECT product_id, COUNT(*) AS total_orders
FROM order_items
GROUP BY product_id
ORDER BY total_orders DESC;

-- 23) Which states generate the highest revenue?
SELECT c.customer_state, SUM(p.payment_value) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- 24) Give a full view of each order including:
   -- customer location, products purchased, payment amount
SELECT o.order_id, c.customer_state, c.customer_city, oi.product_id, oi.price, p.payment_type, p.payment_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN order_payments p ON o.order_id = p.order_id;

-- 25) Top 10 customers by spending 
SELECT o.customer_id, SUM(p.payment_value) AS total_revenue 
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id 
GROUP BY o.customer_id
ORDER BY total_revenue DESC LIMIT 10;

-- 26) Monthly revenue trend
SELECT DATE_TRUNC('month', o.order_purchase_timestamp) AS month, SUM(p.payment_value) AS revenue
FROM orders o
JOIN order_payments p 
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- 27) Running revenue
SELECT DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS monthly_revenue,
    SUM(SUM(p.payment_value)) OVER (ORDER BY DATE_TRUNC('month', o.order_purchase_timestamp)) AS running_revenue
FROM orders o
JOIN order_payments p 
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- 28) Delivery delay analysis
SELECT COUNT(*) AS delayed_orders
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_time;

-- 29) Top 5 states by revenue
SELECT c.customer_state, SUM(p.payment_value) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 5;

-- 30) Customer segmentation
SELECT customer_id, total_spent,
CASE 
    WHEN total_spent > 1000 THEN 'High Value'
    WHEN total_spent > 500 THEN 'Medium Value'
    ELSE 'Low Value'
    END AS customer_segment
FROM (SELECT o.customer_id, SUM(p.payment_value) AS total_spent
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY o.customer_id
);


-- KPI QUERIES

-- Total Revenue
SELECT SUM(payment_value) AS total_revenue
FROM order_payments;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Average Order Value
SELECT AVG(payment_value) AS avg_order_value
FROM order_payments;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;


























 


