
create DATABASE tips_db;
use tips_db;


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

create table colors
(
    color_id int,
    color varchar(50)
);
insert into colors
values
    (1, 'Blue'),
    (2, 'Green'),
    (3, 'Orange');

create table sizes
(
    size_id int,
    size varchar(10)
);

insert into sizes
values
    (1, 'M'),
    (2, 'L'),
    (3, 'XL');

create table transactions
(
    order_id int,
    product_name varchar(20),
    color varchar(10),
    size varchar(10),
    amount int
);
insert into transactions
values
    (1, 'A', 'Blue', 'L', 300),
    (2, 'B', 'Blue', 'XL', 150),
    (3, 'B', 'Green', 'L', 250),
    (4, 'C', 'Blue', 'L', 250),
    (5, 'E', 'Green', 'L', 270),
    (6, 'D', 'Orange', 'L', 200),
    (7, 'D', 'Green', 'M', 250);

with products_cte AS
(

SELECT 
product_name, color, size
, SUM(amount) as total_Sales
 from TRANSACTIONs
GROUP BY product_name,  size,  color
), master_data AS
(

SELECT 

 p.name as product_name
, c.color as color_name
, s.[size] as product_size

 from products p, colors c, sizes s 
)

SELECT 

m.product_name
, m.color_name
, m.product_size
, ISNULL(p.total_Sales, 0) as total_Sales
 from master_data m LEFT JOIN products_cte p 
on m.product_name = p.product_name and m.color_name = p.color and m.product_size= p.[size]

ORDER BY total_Sales
;


