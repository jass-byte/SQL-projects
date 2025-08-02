create database Job_project;
use project;


CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);
                         
CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);
                            
SELECT 
    *
FROM
    orders;
				
                
SELECT 
    *
FROM
    order_details;
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    pizzas;
SELECT 
    *
FROM
    pizza_types;

SELECT 
    COUNT(order_id)
FROM
    order_details;
SELECT 
    ROUND(SUM(o.quantity * p.price)) AS total_sales
FROM
    order_details AS o
        JOIN
    pizzas AS p ON p.pizza_id = o.pizza_id;
SELECT 
    pt.name, MAX(p.price) AS price
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY price DESC
LIMIT 1;
SELECT 
    p.size, COUNT(od.order_id) orders
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY orders DESC
LIMIT 1;
SELECT 
    pt.category, COUNT(od.order_id) orders
FROM
    order_details AS od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY orders DESC
LIMIT 5;
SELECT 
    pt.category, SUM(od.quantity) quantity
FROM
    order_details od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY quantity DESC;
SELECT 
    HOUR(order_time) hours, COUNT(order_id) orders
FROM
    orders
GROUP BY hours
ORDER BY orders DESC;
SELECT 
    o.order_date,
    ROUND(SUM(p.price * od.quantity)) AS dailysales
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
        JOIN
    orders o ON o.order_id = od.order_id
GROUP BY o.order_date
HAVING dailysales > (SELECT 
        AVG(dailysales1)
    FROM
        (SELECT 
            o1.order_date, SUM(p1.price * od1.quantity) AS dailysales1
        FROM
            order_details od1
        JOIN pizzas p1 ON p1.pizza_id = od1.pizza_id
        JOIN orders o1 ON o1.order_id = od1.order_id
        GROUP BY o1.order_date) AS avg_daily_sales);
  
SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price) * 100 / (SELECT 
                    SUM(od1.quantity * p1.price)
                FROM
                    order_details AS od1
                        JOIN
                    pizzas AS p1 ON p1.pizza_id = od1.pizza_id)) AS percentage
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;
 
 # TOP 3 PIZZA CATEGTORIES AS PER REVENUE
 SELECT *
FROM (
    SELECT 
        pt.category,
        pt.name AS pizza_type,
        ROUND(SUM(od.quantity * p.price), 2) AS revenue,
        ROW_NUMBER() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) rankS
    FROM order_details od
    JOIN pizzas p ON p.pizza_id = od.pizza_id
    JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked_pizzas
WHERE rankS <= 3
ORDER BY category, rankS;
