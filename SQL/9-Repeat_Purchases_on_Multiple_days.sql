
use db;

create  table purchases
(
    user_id int,
    product_id int,
    quantity int,
    purchase_date datetime
);

insert into purchases
values(536, 3223, 6, '01/11/2022 12:33:44');
insert into purchases
values(827, 3585, 35, '02/20/2022 14:05:26');
insert into purchases
values(536, 3223, 5, '03/02/2022 09:33:28');
insert into purchases
values(536, 1435, 10, '03/02/2022 08:40:00');
insert into purchases
values(827, 2452, 45, '04/09/2022 00:00:00');

insert into purchases
values(827, 2452, 45, '05/09/2022 00:00:00');
insert into purchases
values(827, 2452, 45, '05/09/2022 00:00:00');


SELECT * from purchases
ORDER BY user_id, product_id
;


-- Find the number of users who purchased the same product on multiple days.

----------------------------------------------------------------
-- Approach-1
----------------------------------------------------------------

with cte AS
(
SELECT 
user_id
, product_id
, COUNT(distinct CONVERT(date, purchase_date)) as distinct_date_count
From purchases
GROUP BY user_id, product_id
)
SELECT 
    cte.user_id
, cte.product_id
 from cte
WHERE distinct_date_count > 1
;

----------------------------------------------------------------
-- Approach-2
----------------------------------------------------------------

with purchases_cte AS
(
    select 
    user_id
    , product_id
    
    from purchases
    GROUP BY user_id, product_id
    HAVING COUNT(distinct CONVERT(date, purchase_date)) > 1
)
SELECT * from purchases_cte;


