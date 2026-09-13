use project;
describe customers;
alter table  customers  modify signup_date date;
describe order_items;
alter table orders modify order_date date;
describe orders;
describe payments;
describe products;
select count(*) from customers;
select count(*) from order_items;
select count(*) from orders;
select count(*) from payments;
select count(*) from products;
alter table customers modify customer_id varchar(50) not null;
alter table customers add primary key (customer_id);
ALTER TABLE products
MODIFY product_id VARCHAR(50) NOT NULL;
ALTER TABLE products
ADD PRIMARY KEY (product_id);
ALTER TABLE orders
MODIFY order_id VARCHAR(50) NOT NULL,
MODIFY customer_id VARCHAR(50) NOT NULL;
ALTER TABLE orders
ADD PRIMARY KEY (order_id);
ALTER TABLE order_items
MODIFY order_item_id VARCHAR(50) NOT NULL,
MODIFY order_id VARCHAR(50) NOT NULL,
MODIFY product_id VARCHAR(50) NOT NULL;
ALTER TABLE order_items
ADD PRIMARY KEY (order_item_id);
ALTER TABLE payments
MODIFY payment_id VARCHAR(50) NOT NULL,
MODIFY order_id VARCHAR(50) NOT NULL;
ALTER TABLE payments
ADD PRIMARY KEY (payment_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);
ALTER TABLE order_items
ADD CONSTRAINT fk_items_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
ALTER TABLE order_items
ADD CONSTRAINT fk_items_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);
ALTER TABLE payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
