-- E-Commerce Sales & Customer Analytics
-- Intermediate SQL Questions

#Total revenue generated so far
select sum(line_total) as total_revenue from order_items;

#Which product category has sold the most units?
SELECT 
    p.category,
    SUM(oi.quantity) AS total_units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_units_sold DESC
LIMIT 1;

#List the top 5 customers by total amount spent.
select
c.customer_name,sum(oi.line_total) as total_spent
from customers c join orders o on c.customer_id=o.customer_id 
join order_items oi on o.order_id=oi.order_id 
group by c.customer_id,c.customer_name order by total_spent desc limit 5;

#Which customers have spent more than ₹50,000?

select c.customer_id,sum(line_total) as total_spent
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id,c.customer_name having total_spent > 50000
order by total_spent desc;

#  What is the average order value per city?

SELECT
    c.customer_city,
    AVG(order_total) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN (
    SELECT
        order_id,
        SUM(line_total) AS order_total
    FROM order_items
    GROUP BY order_id
) oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_city
ORDER BY average_order_value DESC;


# Orders and average payment value by payment type

SELECT
    payment_type,
    COUNT(*) AS order_count,
    AVG(payment_value) AS average_payment_value
FROM payments
GROUP BY payment_type
ORDER BY order_count DESC;
