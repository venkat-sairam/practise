USE db;


CREATE TABLE sales_data
(
    customer_id INT,
    product_name VARCHAR(50),
    total_sales INT
);



INSERT INTO sales_data
VALUES
    (101, 'iPhone 13 Pro', 1200),
    (101, 'iPad Air', 800),
    (101, 'AirPods Pro', 250),
    (202, 'MacBook Pro', 2500),
    (202, 'iPad Mini', 500),
    (303, 'Apple Watch Series 7', 400),
    (404, 'iPhone SE', 600),
    (404, 'Mac Mini', 1100),
    (404, 'HomePod Mini', 100),
    (505, 'iPad Air', 800),
    (505, 'Apple TV 4K', 200),
    (606, 'AirTag', 30),
    (606, 'Magic Keyboard', 300),
    (707, 'iPad Pro', 1000),
    (707, 'Beats Studio Buds', 150),
    (808, 'iPhone 12', 900),
    (808, 'Apple Pencil', 120),
    (909, 'MacBook Air', 1200),
    (909, 'AirPods Max', 550),
    (909, 'HomePod', 300);



SELECT *
from sales_data
WHERE customer_id IN 
(

    SELECT customer_id
from sales_data
WHERE product_name = 'iPad Air'
)

SELECT 
    customer_id
    , SUM(total_sales) as total_without_ipad_air
 from sales_data
WHERE customer_id IN 
(

    SELECT customer_id
    from sales_data
    WHERE product_name = 'iPad Air'
)
AND product_name NOT IN ('iPad Air')
GROUP BY customer_id
ORDER BY customer_id
;



----------------------------------------------------------------
-- Approach-2 :
-- 1. Find the total sales for each customer
-- 2. Remove the ipad air price from the total.
----------------------------------------------------------------

with cte AS
(
    SELECT
        customer_id
, SUM(total_sales) - SUM(case WHEN product_name = 'iPad Air' then total_sales end) as total_sales_without_iPad_Air
    from sales_data
    GROUP BY customer_id
)
SELECT *
from cte
WHERE total_sales_without_iPad_Air IS NOT NULL 

;

