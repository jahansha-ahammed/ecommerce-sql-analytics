-- E-Commerce Sales & Customer Analytics
-- Beginner SQL Questions

#List all customers from a specific city.
select * from customers where customer_city='kochi';

#Show all orders placed in the last 30 days.
select * from orders where order_date >= (select max(order_date) - interval 30 day);

#Find the 10 most expensive products.
select * from products order by price desc limit 10;

#List all orders with status = 'delivered'
select * from orders where status='delivered';

#Find customers who signed up in 2025.
select * from customers where signup_date >= '2025-01-01' and signup_date < '2026-01-01';
