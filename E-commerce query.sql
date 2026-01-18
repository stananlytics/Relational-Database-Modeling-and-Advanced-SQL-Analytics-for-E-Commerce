create database `E-commerce`;
use `E-commerce`;
create table customer(
customer_id int, Name varchar(45), `email adress` varchar(60),
primary key (customer_id));

create table product(
product_id int, product_description varchar(500), 
Amount int,  category varchar(45),
Qty_available int, 
customer_id int,
primary key (product_id),
foreign key (customer_id) REFERENCES customer(customer_id));


create table `Add to cart`(
cart_id int, 
quantity int,
status varchar(45),
period date,
product_id int,
primary key(Cart_id),
foreign key(product_id) REFERENCES product(product_id));


Alter table `Add to cart`
add column product_name varchar(45);


CREATE TABLE `order` (
    order_id INT,
    customer_id INT,
    cart_id INT UNIQUE, 
    order_date DATE,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (cart_id) REFERENCES `add to cart`(cart_id)
);


CREATE TABLE order_details(
    order_id INT,
    product_id INT,
    quantity INT,
    price INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


create table payment(
payment_id INT,
`amount paid` INT,
method varchar(45),
order_id int unique,
`Date purchaded` date,
primary key(payment_id),
 FOREIGN KEY (order_id) REFERENCES `order`(order_id));
 
 create table inventory(
 inventory_id int,
 `Qty in stock` int,
 product_id int,
 warehouse_id int,
 primary key(inventory_id),
 foreign key(product_id) references product(product_id),
 foreign key(warehouse_id) references warehouse(warehouse_id));
 
 
 create table warehouse(
 warehouse_id int,
 location varchar(45),
 capacity varchar(45),
 primary key(warehouse_id));
 
 create table shippment(
 shipment_id int,
 shipment_date date,
 delivery_date date,
 warehouse_id int,
 order_id int,
 product_id  int,
 primary key(shipment_id),
  FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    Foreign Key (warehouse_id) REFERENCES warehouse(warehouse_id)
);
 
 
create table rating(
rating_id int,
rating int,
`comment` varchar(45),
customer_id int,
`Date` date,
primary key(rating_id),
foreign key(customer_id) references customer(customer_id));

Alter table customer add column address varchar(45);




# Question 3; inserting our customer records

insert into customer values(
1001, "chevoiller Johnson", "chevoilerjohnson@gmail.com", "texas"),
(1004, "Stanley Agbam", "stanleyagbam@gmail.com", "San fransico"),
(1003, "conolly Taylor", "conollytaylor@gmail.com", "Texas"),
(1005, "Anderson samantha", "andersonsamantha@gmail.com", "Arizona"),
(1006, "heally michael", "heallymichael@gmail.com", "california"),
(1002, "Alexander Fiyock", "alexanderfiyock@gmail.com", "Montana"),
(1008, "Conners Georgery", "connersgeorgery@gmail.com", "Utah"),
(1009, "Willohby Nahomi", "willohbynahomi@gmail.com", "Washinthon DC");

insert into product values(
2001, "Ergonomic Office Chair", 60000, "Furniture", 600, 1004),
(2002, "Laptop (Dell XPS)", 500000, "Technology", 1800, 1002),
(2003, "Laptop (Dell XPS)", 500000, "Technology", 1800, 1001),
(2004, "Conference chairs",80000, "Furniture", 500, 1008),
(2005, "Macbook (2020)", 950000, "Technology", 8000, 1004),
(2006, "Printing paper", 4000, "Office supplies", 250, 1008),
(2007, "Router", 1500, "Technology", 400, 1002),
(2008, "Projectors", 280000, "Technology", 200, 1006);


INSERT INTO `add to cart`
(cart_id, product_name, quantity, `status`, period, product_id)
VALUES
(3001, 'Laptop (Dell XPS)', 1, 'Active',   '2024-05-08', 2002),
(3002, 'Macbook (2020)',   1, 'Ordered',  '2024-06-26', 2005),
(3003, 'Printing paper',   5, 'Ordered',  '2024-02-20', 2006),
(3004, 'Router',           1, 'Ordered',  '2024-08-20', 2007),
(3005, 'Conference chairs',1, 'Ordered',  '2024-08-29', 2004),
(3006, 'Laptop (Dell XPS)',1, 'Ordered',  '2024-06-24', 2003),
(3007, 'Ergonomic Office Chair', 1, 'Ordered', '2024-01-23', 2001),
(3008, 'Projectors',  1, 'Abandoned','2024-11-23', 2008);


UPDATE `add to cart`
SET `status` = 'Ordered'
WHERE cart_id = 3001;

UPDATE `add to cart`
SET `status` = 'Active '
WHERE cart_id = 3003;

ALTER TABLE `add to cart`
RENAME COLUMN product_name TO product_description;

# the column was renamed so a join can be created between products and add to cart


Insert into `order` values(
4001, 1001, 3006, '2024-06-24'),
(4002, 1004, 3007, '2024-01-23'),
(4003, 1004, 3002, '2024-06-26'),
(4004, 1002, 3001, '2024-05-08'),
(4005, 1002, 3004, '2024-08-20');


insert into order_details values(
4001, 2003,  1,  500000 ),
(4002, 2001, 1,  60000),
(4003, 2005, 1, 950000),
(4004, 2004, 1, 80000),
(4005, 2002, 1, 60000);

insert into payment values(
5001, 500000, "Transfer", 4001,'2024-06-24' ),
(5002, 60000, "Cash", 4002,  '2024-01-23'),
(5003, 950000, "Transfer", 4003,  '2024-06-26'),
(5004, 80000, "Cash", 4004, '2024-05-08'),
(5005, 500000, "Transfer", 4005, '2024-05-08');

INSERT INTO warehouse  VALUES
(6001, 'Dallas, Texas',       '120,000 sq ft'),
(6002, 'Los Angeles, California', '200,000 sq ft'),
(6003, 'Chicago, Illinois',   '150,000 sq ft'),
(6004, 'Atlanta, Georgia',    '100,000 sq ft'),
(6005, 'Newark, New Jersey',  '90,000 sq ft');


Insert into warehouse values(
6006,  'Houston, Texas',         '180,000 sq ft'),
(6007,  'Memphis, Tennessee',     '140,000 sq ft'),
(6008,  'Denver, Colorado',       '110,000 sq ft'),
(6009,  'Seattle, Washington',    '95,000 sq ft'),
(6010, 'Miami, Florida',         '130,000 sq ft'),
(6011, 'Phoenix, Arizona',       '85,000 sq ft'),
(6012, 'Philadelphia, Pennsylvania','125,000 sq ft'),
(6013, 'Columbus, Ohio',         '160,000 sq ft'),
(6014, 'Indianapolis, Indiana',  '105,000 sq ft'),
(6015, 'San Francisco, California','75,000 sq ft');


INSERT INTO inventory VALUES
(7001, 200, 2001, 6001),
(7002, 400, 2001, 6002),
(7003, 1000, 2002, 6003),
(7004, 800, 2002, 6004),
(7005, 900, 2003, 6005),
(7006, 900, 2003, 6006),
(7007, 300, 2004, 6007),
(7008, 200, 2004, 6008),
(7009, 3000, 2005, 6009),
(7010, 2500, 2005, 6010),
(7011, 2500, 2005, 6011),
(7012, 150, 2006, 6012),
(7013, 100, 2006, 6013),
(7014, 250, 2007, 6014),
(7015, 150, 2007, 6015),
(7016, 200, 2008, 6001);



 insert into shippment values(
 8001, '2024-06-27', '2024-06-30', 6009, 4001, 2003),
 (8002, '2024-01-26', '2024-01-29', 6012, 4002, 2001),
 (8003, '2024-06-30', '2024-07-02', 6008, 4003,2005 ),
 (8004, '2024-05-12', '2024-05-16', 6004, 4004, 2004),
 (8005, '2024-08-24', '2024-08-27', 6009, 4005, 2002);
 
 

 

 
# Aggregation summary( Amount by product category)-> Calculations based on the available products
 create view `Amount per category` as select category, sum(Amount) from product
group by category;



# Aggeration summary(Available quantity by product category)
create view `Quantity per category` as select category, sum(Qty_available) from product
group by category;

# Our most valid customer(joins)
SELECT c.customer_id, c.name, o.order_id, p.product_description, o.order_date
FROM customer c INNER JOIN `order` o  ON c.customer_id = o.customer_id
INNER JOIN order_details od  ON o.order_id = od.order_id
INNER JOIN product p  ON od.product_id = p.product_id;


# Customers who spent more than ₦500,000
SELECT c.customer_id, c.name, SUM(pay.`amount paid`) AS total_spent
FROM customer c JOIN `order` o ON c.customer_id = o.customer_id
JOIN payment pay ON o.order_id = pay.order_id
GROUP BY c.customer_id, c.name
HAVING SUM(pay.`amount paid`) > 500000;

# Cart Status Normalization
SELECT cart_id, product_description, quantity, status,
CASE WHEN status = 'Ordered' THEN 'Completed'
WHEN status = 'Active' OR status = 'Active ' THEN 'Pending'
WHEN status = 'Abandoned' THEN 'Cancelled'
ELSE 'Unknown'END AS normalized_status
FROM `add to cart`;

# Customers with Above-Average Spending
SELECT c.customer_id, c.name,  (SELECT SUM(pay.`amount paid`)  FROM `order` o 
JOIN payment pay ON o.order_id = pay.order_id WHERE o.customer_id = c.customer_id) AS total_spent
FROM customer c WHERE (SELECT SUM(pay.`amount paid`)  FROM `order` o JOIN payment pay ON o.order_id = pay.order_id
WHERE o.customer_id = c.customer_id) > (SELECT AVG(total) 
FROM (SELECT SUM(pay.`amount paid`) AS total FROM `order` o 
JOIN payment pay ON o.order_id = pay.order_id GROUP BY o.customer_id
       ) t);

# Monthly Sales Trend by Product
SELECT p.product_description,
       DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(pay.`amount paid`) AS monthly_sales,
       SUM(SUM(pay.`amount paid`)) OVER (PARTITION BY p.product_description 
       ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS running_total
FROM product p
JOIN order_details od ON p.product_id = od.product_id
JOIN `order` o ON od.order_id = o.order_id
JOIN payment pay ON o.order_id = pay.order_id
GROUP BY p.product_description, DATE_FORMAT(o.order_date, '%Y-%m');

 
 
 #Composite index on order_details (order_id, product_id)
CREATE INDEX idx_orderdetails_order_product 
ON order_details (order_id, product_id);

# index on payment (order_id)
CREATE INDEX idx_payment_order 
ON payment (order_id);

# Index on order (order_date)
CREATE INDEX idx_order_date 
ON `order` (order_date);

#CTE calculating the monthly totals by product
WITH monthly_totals AS (
    SELECT p.product_description,
           DATE_FORMAT(o.order_date, '%Y-%m') AS month,
           SUM(pay.`amount paid`) AS monthly_sales
    FROM product p
    JOIN order_details od ON p.product_id = od.product_id
    JOIN `order` o ON od.order_id = o.order_id
    JOIN payment pay ON o.order_id = pay.order_id
    GROUP BY p.product_description, DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT product_description,
       month,
       monthly_sales,
       SUM(monthly_sales) OVER (PARTITION BY product_description ORDER BY month) AS running_total
FROM monthly_totals;


#Demonization for faster trends
SELECT product_description, month, monthly_sales
FROM product_monthly_sales
ORDER BY product_description, month;





 
