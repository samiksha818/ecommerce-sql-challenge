-- Step 1: Create Tables

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    stockQuantity INT
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    itemAmount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 2: Insert Products

INSERT INTO products VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

-- Step 3: Insert Customers

INSERT INTO customers VALUES
(1, 'John Doe', 'johndoe@example.com', 'pass1'),
(2, 'Jane Smith', 'janesmith@example.com', 'pass2'),
(3, 'Robert Johnson', 'robert@example.com', 'pass3'),
(4, 'Sarah Brown', 'sarah@example.com', 'pass4'),
(5, 'David Lee', 'david@example.com', 'pass5'),
(6, 'Laura Hall', 'laura@example.com', 'pass6'),
(7, 'Michael Davis', 'michael@example.com', 'pass7'),
(8, 'Emma Wilson', 'emma@example.com', 'pass8'),
(9, 'William Taylor', 'william@example.com', 'pass9'),
(10, 'Olivia Adams', 'olivia@example.com', 'pass10');

-- Step 4: Insert Orders

INSERT INTO orders VALUES
(1, 1, '2023-01-05', 1200.00, '123 Main St'),
(2, 2, '2023-02-10', 900.00, '456 Elm St'),
(3, 3, '2023-03-15', 300.00, '789 Oak St'),
(4, 4, '2023-04-20', 150.00, '101 Pine St'),
(5, 5, '2023-05-25', 1800.00, '234 Cedar St'),
(6, 6, '2023-06-30', 400.00, '567 Birch St'),
(7, 7, '2023-07-05', 700.00, '890 Maple St'),
(8, 8, '2023-08-10', 160.00, '321 Redwood St'),
(9, 9, '2023-09-15', 140.00, '432 Spruce St'),
(10, 10, '2023-10-20', 1400.00, '765 Fir St');

-- Step 5: Insert Order Items

INSERT INTO order_items VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

-- Step 6: Insert Cart Items

INSERT INTO cart VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

-- Step 7: Queries

-- 1. Update refrigerator product price to 800.
UPDATE products SET price = 800 WHERE name = 'Refrigerator';

-- 2. Remove all cart items for a specific customer (e.g., customer 5).
DELETE FROM cart WHERE customer_id = 5;

-- 3. Retrieve Products Priced Below $100.
SELECT * FROM products WHERE price < 100;

-- 4. Find Products with Stock Quantity Greater Than 5.
SELECT * FROM products WHERE stockQuantity > 5;

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.
SELECT * FROM orders WHERE total_price BETWEEN 500 AND 1000;

-- 6. Find Products which name end with letter ‘r’.
SELECT * FROM products WHERE name LIKE '%r';

-- 7. Retrieve Cart Items for Customer 5.
SELECT * FROM cart WHERE customer_id = 5;

-- 8. Find Customers Who Placed Orders in 2023.
SELECT DISTINCT c.* 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
WHERE YEAR(order_date) = 2023;

-- 9. Determine the Minimum Stock Quantity for Each Product.
SELECT name, MIN(stockQuantity) AS minStock FROM products GROUP BY name;

-- 10. Calculate the Total Amount Spent by Each Customer.
SELECT c.customer_id, c.name, SUM(o.total_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 11. Find the Average Order Amount for Each Customer.
SELECT c.customer_id, c.name, AVG(o.total_price) AS avg_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 12. Count the Number of Orders Placed by Each Customer.
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 13. Find the Maximum Order Amount for Each Customer.
SELECT c.customer_id, c.name, MAX(o.total_price) AS max_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 14. Get Customers Who Placed Orders Totaling Over $1000.
SELECT c.customer_id, c.name, SUM(o.total_price) AS total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_price) > 1000;

-- 15. Subquery to Find Products Not in the Cart.
SELECT * FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM cart);

-- 16. Subquery to Find Customers Who Haven't Placed Orders.
SELECT * FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product.
SELECT 
    product_id,
    SUM(itemAmount) AS product_total,
    (SUM(itemAmount) / (SELECT SUM(itemAmount) FROM order_items) * 100) AS revenue_percent
FROM order_items
GROUP BY product_id;

-- 18. Subquery to Find Products with Low Stock (e.g., stock < 10).
SELECT * FROM products WHERE stockQuantity < 10;

-- 19. Subquery to Find Customers Who Placed High-Value Orders (e.g., any order > $1000).
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price > 1000;
