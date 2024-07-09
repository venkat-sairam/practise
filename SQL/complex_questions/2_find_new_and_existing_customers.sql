use tips_db;

create table customer_orders
(
    order_id integer,
    customer_id integer,
    order_date date,
    order_amount integer
);
select *
from customer_orders
insert into customer_orders
values(1, 100, cast('2022-01-01' as date), 2000),
    (2, 200, cast('2022-01-01' as date), 2500),
    (3, 300, cast('2022-01-01' as date), 2100)
,
    (4, 100, cast('2022-01-02' as date), 2000),
    (5, 400, cast('2022-01-02' as date), 2200),
    (6, 500, cast('2022-01-02' as date), 2700)
,
    (7, 100, cast('2022-01-03' as date), 3000),
    (8, 400, cast('2022-01-03' as date), 1000),
    (9, 600, cast('2022-01-03' as date), 3000)
;

SELECT *
FROM
customer_orders
;

----------------------------------------------------------------
-- Find the count of new and old customers based on the order date
----------------------------------------------------------------

with cte AS
(
SELECT 
*
, DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date) as rn
FROM customer_orders
) 
SELECT
order_date
, SUM(case when rn =1 then 1 else 0 end) as new_customer_count
, COUNT(*) - SUM
(case when rn =1 then 1 else 0
end) as old_customers_count
FROM
cte
GROUP BY order_date
ORDER by order_date
;


----------------------------------------------------------------
-- Approach-2: Find the first visited date every customer and compare with 
-- the order date
----------------------------------------------------------------

with first_order_date_cte AS
(
SELECT
customer_id, MIN(order_date) as first_order_date
FROM
customer_orders
GROUP BY customer_id
)
SELECT 
l.order_date  as order_date
, SUM(case when l.order_date = r.first_order_date then 1  else 0 END) as new_customer_count
, SUM(case when l.order_date != r.first_order_date then 1  else 0 END) as old_customer_count
from customer_orders l INNER JOIN
first_order_date_cte  r
ON l.customer_id = r.customer_id
GROUP BY l.order_date














