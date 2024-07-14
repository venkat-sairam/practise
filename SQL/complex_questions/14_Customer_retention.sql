with cte as
(
  SELECT *
  , LAG(ordered_date, 1) OVER(PARTITION BY order_id ORDER BY order_date) as last_month_date
)
SELECT 
MONTH(order_date) as month_name
  , SUM(
  CASE WHEN DATEDIFF(MONTH, last_month_date, order_date) =1 THEN 1 END
  ) AS Retention_count
from cte 
GROUP BY MONTH(order_date)
