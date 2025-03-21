
-- total avg daily sales  year wise
-- source: https://www.youtube.com/watch?v=ewmEHQSQYRM&list=PLBTZqjSKn0IfULLRo9Tm4lESxYMAG7fUQ&index=6

with cte as
(
	select product_id, period_start, period_end, average_daily_sales
  	from sales
  	union all
  	select product_id, dateadd(day, 1, period_start), period_end, average_daily_sales
  	from cte
  	where dateadd(day, 1, period_start) <= period_end
), res_cte as
(
select
product_id
, year(period_Start) as start_year
, min(period_start) as start_date
, max(period_start) as end_date
--, year(period_end) as end_year
, min(average_Daily_sales) as avg_daily_sales
from
cte
group by product_id, year(period_Start)

)
select
product_id
, start_year
, (DATEDIFF(day, start_date, end_date) +1) * avg_daily_sales as total_amount

from res_cte
order by product_id
OPTION( MAXRECURSION 5000)
;
