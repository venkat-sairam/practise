
-- Find out the second selling product for each seller and
-- check if its their favourite brand or not.
-- if a seller has <2 items on the list, return no

-- source https://www.youtube.com/watch?v=1ias-sP_XAY&list=PLBTZqjSKn0IfULLRo9Tm4lESxYMAG7fUQ&index=9


create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

select * from orders;
select * from users;
select * from items;

WITH second_oi AS
(
select 
*
, ROW_NUMBER() over(partition by seller_id order by order_date) as rn
from orders
)
, sellers_with_flag_Cte as
(
SELECT 
seller_id as seller_id
, CASE 
	WHEN i.item_brand = u.favorite_brand THEN 'yes'
		ELSE 'no'
END AS flag
FROM users u LEFT JOIN second_oi 
ON u.user_id = seller_id
LEFT JOIN items i
ON second_oi.item_id = i.item_id
WHERE rn = 2
)
SELECT 
u.user_id
, coalesce(s.flag, 'no') as flag
FROM  users u LEFT JOIN sellers_with_flag_Cte s
ON u.user_id = s.seller_id
