-- You are given a products table where a new row is inserted every time the price of a product changes.
-- Additionally, there is a transaction table containing details such as order_date and product_id for each order.

-- Write an SQL query to calculate the total sales value for each product, 
-- considering the cost of the product at the time of the order date, display the output in ascending order of the product_id.

 -- https://www.namastesql.com/coding-problem/26-dynamic-pricing

Table: products
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| product_id  | int       |
| price       | int       |
| price_date  | date      |
+-------------+-----------+
Table: orders 
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| order_id    | int       |
| order_date  | date      |
| product_id  | int       |
+-------------+-----------+


with products_cte as
(
	select
	product_id
  	, price_date as start_date
  	, lead(price_date, 1, '2099-12-30') over(partition by product_id order by price_date) as last_date
  , price
  	from products
)
select 
p.product_id
, SUM(p.price) as total_sales
from orders o left join products_cte p
on (o.product_id = p.product_id) and ((p.start_date<= o.order_date) and (o.order_date < p.last_date))
group by p.product_id

