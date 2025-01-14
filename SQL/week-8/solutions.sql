

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
