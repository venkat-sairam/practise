

USE tips_db;
DROP TABLE if EXISTS products;

create table products
(
    product_id varchar(20) ,
    cost int
);
insert into products
values
    ('P1', 200),
    ('P2', 300),
    ('P3', 500),
    ('P4', 800);

create table customer_budget
(
    customer_id int,
    budget int
);

insert into customer_budget
values
    (100, 400),
    (200, 800),
    (300, 1500);

SELECT * FROM customer_budget;
SELECT * FROM products;

with cte AS 
(
    SELECT 
    *
    , SUM(cost) OVER(PARTITION BY customer_id ORDER BY cost) as running_sum
    FROM
    customer_budget INNER JOIN products
    on products.cost <= customer_budget.budget
)
SELECT --* FROM cte
customer_id
, budget
, COUNT(*) as num_of_products
, STRING_AGG(product_id, ',')
 FROM cte
WHERE running_sum <= budget
GROUP BY customer_id, budget

;



