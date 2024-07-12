use tips_db;

DROP TABLE orders;
DROP table products;

create table orders
(
    order_id int,
    customer_id int,
    product_id int,
);

insert into orders VALUES
    (1, 1, 1),
    (1, 1, 2),
    (1, 1, 3),
    (2, 2, 1),
    (2, 2, 2),
    (2, 2, 4),
    (3, 1, 5);

create table products
(
    id int,
    name varchar(10)
);
insert into products
VALUES
    (1, 'A'),
    (2, 'B'),
    (3, 'C'),
    (4, 'D'),
    (5, 'E');


SELECT * FROM orders;

SELECT * FROM products;


with cte as (
SELECT 
 o1.product_id as p1
, o2.product_id as p2
-- , COUNT(1) as purchase_frequency
, p1.name as p1_name
, p2.name as p2_name
from
orders o1 INNER JOIN orders o2 on 
o1.order_id = o2.order_id
INNER JOIN products p1 on p1.id = o1.product_id
INNER JOIN products p2 on p2.id = o2.product_id
WHERE o1.product_id < o2.product_id

)

SELECT 
p1_name + ' ' + p2_name
, COUNT(*) as freq
from cte
GROUP BY p1_name, p2_name

