USE pizzashop;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pt.category, SUM(o.quantity) AS total_quantity
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o
ON o.pizza_id = p.pizza_id
GROUP BY pt.category;

-- Determine the distribution of orders by hour of the day.-- 
SELECT COUNT(order_id) as order_count, hour(order_time) as hours_of_day
FROM orders
GROUP BY  hours_of_day;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(pizza_id) as pizza_count
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
GROUP BY category;

SELECT category, COUNT(name) FROM pizza_types GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(total_quantity)) as avg_pizzas_daily FROM 
(SELECT order_date, SUM(quantity) as total_quantity
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY order_date) AS order_quantity_details;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name, SUM(price*quantity) as revenue
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o
ON o.pizza_id = p.pizza_id
GROUP BY pt.name ORDER BY revenue DESC LIMIT 3;








