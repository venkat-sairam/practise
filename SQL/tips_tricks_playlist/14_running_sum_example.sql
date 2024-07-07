use tips_Db;


with products_cte AS(
select * FROM(
values
    ('P1', 200),
    ('P2', 300),
    ('P3', 300),
    ('P4', 500),
    ('P5', 800)

) AS products(product_id, cost) 
) 
SELECT 
*
-- issue as duplicate elements manupulate the running sum.
-- , SUM(cost) OVER(order by cost) as running_sum 
, SUM(cost) OVER(order by cost, product_id) AS running_sum
 from products_cte

;


----------------------------------------------------------------------
-- Approach-2: Using rows betwwen unbounded preceding and current row 
----------------------------------------------------------------------
with
    products_cte
    AS
    
    (
        select *
        FROM(
values
                ('P1', 200),
                ('P2', 300),
                ('P3', 300),
                ('P4', 500),
                ('P5', 800)

) AS products(product_id, cost)
    ) 
SELECT
*
, SUM(cost) OVER(order by cost rows between unbounded preceding and current row) as running_sum
from products_cte
