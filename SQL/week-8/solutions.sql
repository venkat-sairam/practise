

-- Write an SQL query to retrieve the total sales amount for each product category in the month of February 2022,
-- only including sales made on weekdays (Monday to Friday). Display the output in ascending order of total sales.

with feb_2022_cte as (
  select 
  *
  from sales
  WHERE year(order_date)=2022 AND MONTH(order_Date)=2
), 
feb_weekdays_cte as (
  select 
  *
  from feb_2022_cte
  where WEEKDAY(order_Date) NOT IN(5, 6)
  )
select 
category
, SUM(amount) as total_sales
from feb_weekdays_cte
GROUP BY category
ORDER BY total_sales
;

-- ==============
--  Question - 3
--  ==============
-- Write an SQL query to retrieve the total sales amount in each category. 
--Include all categories, if no products were sold in a category display as 0. Display the output in ascending order of total_sales.

WITH grouped_Sales_amount AS(

  select
      category_id 
      , SUM(amount) AS total_sales
  from sales
  group by category_id
)

select 
category_name
, CASE WHEN cat.total_sales is NOT NULL THEN cat.total_sales else 0 end as total_sales
from categories
LEFT JOIN grouped_Sales_amount as cat
ON categories.category_id = cat.category_id
order by total_sales
;
