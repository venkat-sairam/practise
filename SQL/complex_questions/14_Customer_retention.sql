with cte as
(
  SELECT *
  , LAG(ordered_date, 1) OVER(PARTITION BY order_id ORDER BY order_date) as last_month_date
  FROM transactions
)
SELECT 
MONTH(order_date) as month_name
  , SUM(
  CASE WHEN DATEDIFF(MONTH, last_month_date, order_date) =1 THEN 1 END
  ) AS Retention_count
from cte 
GROUP BY MONTH(order_date)


-- SOLUTION-2
SELECT 
MONTH(curr_month) AS MONTH_NAME
  , COUNT(DISTINCT curr_month.id) as retention_count
FROM transactions as curr_month LEFT JOIN transactions as last_month
ON curr_month.id = last_month.id AND DATEDIFF(MONTH, last_month.order_date, curr_month.order_date) = 1
GROUP BY MONTH(curr_month) 
