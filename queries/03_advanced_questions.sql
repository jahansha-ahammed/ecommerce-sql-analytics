-- E-Commerce Sales & Customer Analytics
-- Advanced SQL Questions

# Rank products by total revenue within each category

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.line_total) AS total_revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)

SELECT
    product_id,
    product_name,
    category,
    total_revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM product_revenue
ORDER BY category, revenue_rank; 

#Find customers who spent more than the average customer spend

SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.line_total) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.line_total) > (
    SELECT AVG(customer_spend)
    FROM (
        SELECT
            o.customer_id,
            SUM(oi.line_total) AS customer_spend
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) AS customer_totals
)
ORDER BY total_spent DESC;

#Identify repeat customers (more than 20 orders)

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 20
ORDER BY total_orders DESC;

#Create a view called monthly_sales_summary that a dashboard tool could read directly.

CREATE VIEW monthly_sales_summary AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.line_total) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

#Create a stored procedure get_customer_history(customer_id) that returns a customer's full order history

DELIMITER //

CREATE PROCEDURE get_customer_history(IN p_customer_id VARCHAR(50))
BEGIN

    SELECT
        o.order_id,
        o.order_date,
        o.status,
        oi.product_id,
        oi.quantity,
        oi.price,
        oi.line_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date DESC;

END //

DELIMITER ;

CALL get_customer_history('C00001');
