USE pizzashop;
SELECT * FROM pizzas;
SELECT * FROM pizza_types;

CREATE TABLE orders(
order_id INT NOT NULL,
order_date DATE NOT NULL,
order_time TIME NOT NULL,
PRIMARY KEY(order_id));

CREATE TABLE order_details(
order_details_id INT NOT NULL PRIMARY KEY,
order_id INT NOT NULL,
pizza_id TEXT NOT NULL,
quantity INT NOT NULL);

SELECT * FROM orders;
SELECT * FROM order_details;

-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) as total_orders FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(quantity*price)) as total_revenue
FROM pizzas p
JOIN order_details o
ON p.pizza_id = o.pizza_id;

-- Identify the highest-priced pizza.
SELECT p2.name, p1.price FROM pizzas p1
JOIN pizza_types p2
ON p1.pizza_type_id = p2.pizza_type_id
ORDER BY price DESC limit 1;

-- Identify the most common pizza size ordered.
SELECT 
    p.size, COUNT(o.order_details_id) AS max_ordered
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.size
ORDER BY max_ordered DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, SUM(o.quantity) as quantity
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o
ON o.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC limit 5;


















