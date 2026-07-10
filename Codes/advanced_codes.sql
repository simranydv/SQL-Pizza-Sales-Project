USE pizzashop;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT category, 
ROUND(SUM(quantity*price) / (SELECT sum(quantity*price) from pizzas JOIN order_details ON order_details.pizza_id = pizzas.pizza_id) * 100,2) as contribution
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o
ON o.pizza_id = p.pizza_id
GROUP BY category;

-- Analyze the cumulative revenue generated over time.
SELECT order_date, SUM(revenue) OVER(order by order_date) as cumulative_revenue FROM
(SELECT o.order_date,
SUM(price*quantity) as revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN pizzas p
ON p.pizza_id = od.pizza_id
GROUP BY o.order_date) As revenue_details;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with cte as
(SELECT category, name, ROUND(SUM(quantity*price),2) as revenue 
FROM order_details o
JOIN pizzas p
ON o.pizza_id = p.pizza_id
JOIN pizza_types pt
ON pt.pizza_type_id = p.pizza_type_id
GROUP BY name,category)

SELECT category, name, revenue FROM 
(SELECT category, name, revenue,
rank() OVER(PARTITION BY category ORDER BY revenue desc) as rank_of_pizzatype FROM cte) AS all_info
WHERE rank_of_pizzatype <= 3;






