use tips_db;
drop table if EXISTS users;

create table users
(
    user_id int     ,
    join_date date    ,
    favorite_brand varchar(50)
);

create table orders
(
    order_id int     ,
    order_date date    ,
    item_id int     ,
    buyer_id int     ,
    seller_id int
);

create table items
(
    item_id int     ,
    item_brand varchar(50)
);


insert into users
values
    (1, '2019-01-01', 'Lenovo'),
    (2, '2019-02-09', 'Samsung'),
    (3, '2019-01-19', 'LG'),
    (4, '2019-05-21', 'HP');

insert into items
values
    (1, 'Samsung'),
    (2, 'Lenovo'),
    (3, 'LG'),
    (4, 'HP');

insert into orders
values
    (1, '2019-08-01', 4, 1, 2),
    (2, '2019-08-02', 2, 1, 3),
    (3, '2019-08-03', 3, 2, 3),
    (4, '2019-08-04', 1, 4, 2)
 ,
    (5, '2019-08-04', 1, 3, 4),
    (6, '2019-08-05', 2, 2, 4);
insert into orders
values
    (7, '2019-08-04', 5, 1, 5)
;
insert into items
values
    (5, 'Asus')
;

insert into users
values
    (5, '2019-01-01', 'Asus')

;
SELECT *
FROM orders;

SELECT *
FROM users
;

SELECT *
from items;

with market_analysis_cte AS
(
SELECT
    *
, DENSE_RANK() OVER (PARTITION BY o.seller_id order BY o.order_date) as rnk
FROM orders o
), main_cte as (
SELECT 
users.user_id
, users.favorite_brand
, i.*
, case when i.item_brand = users.favorite_brand then 'yes' else 'no' end as flag
from 
users LEFT JOIN market_analysis_cte o
on users.user_id = o.seller_id and rnk= 2
LEFT JOIN items i ON i.item_id = o.item_id
)
SELECT *
from 
main_cte
;