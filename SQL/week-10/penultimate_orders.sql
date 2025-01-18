--You are a data analyst working for an e-commerce company, responsible for analysing customer orders to gain insights into their purchasing behaviour.
--Your task is to write a SQL query to retrieve the details of the penultimate order for each customer.
--However, if a customer has placed only one order, you need to retrieve the details of that order instead, display the output in ascending order of customer name.

-- https://www.namastesql.com/coding-problem/64-penultimate-order

with cust_cte as
 (
  select 
  *
  , dense_rank() over(partition by customer_name order by order_date desc) as rnk
   , COUNT(1) over(partition by customer_name) as order_count
  from orders
)
select
order_id
, order_date
, customer_name
, product_name
, sales
from cust_cte
where rnk = 2 or (order_count =1)
order by customer_name
;
