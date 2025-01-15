

-- write a query to find premium customers from orders data. 
--Premium customers are those who have done more orders than average no of orders per customer.

with customers_orders_cte as (
	select
	customer_id
	, customer_name
	--, order_id
	,COUNT(1) as num_of_orders_per_customer
	from orders
	group by customer_id, customer_name
), avg_customer_orders_cte as 
(
	select
	AVG(num_of_orders_per_customer
	) as avg_orders
	from 
	customers_orders_cte
)
select 
customer_id
, customer_name
from 
orders
group by customer_id, customer_name
having COUNT(1) > 
(
select 
avg_orders
from 
avg_customer_orders_cte
)
;


-- write a query to find employees whose salary is more than average salary of employees in their department
with dept_wise_avg_emp_salaries_cte as 
(
	select 
	dept_id
	, AVG(salary) as avg_sal_dept_wise
	from 
	employee
	group by dept_id
)

select
*
from
dept_wise_avg_emp_salaries_cte

;

with dept_wise_premium_employees_cte as (

	select
	*
	, AVG(salary) over(partition by dept_id) as dept_wise_avg
	, case when salary > AVG(salary) over(partition by dept_id) then emp_name end as premium_employee
	from employee
)
select
*
from dept_wise_premium_employees_cte
where premium_employee IS NOT NULL
order by dept_id, dept_wise_avg desc
;


-- write a query to find employees whose age is more than average age of all the employees.
with avg_emp_age_cte as(

	select
	*
	, avg(emp_age) over() as avg_emp_age
	from 
	employee
)
select
*
from 
avg_emp_age_cte
where emp_age > avg_emp_age
;


--  write a query to print emp name, salary and dep id of highest salaried employee in each department 
with max_salary_emp_cte as
(
	select
	*
	, MAX(salary) over(partition by dept_id) as max_salary
	from
	employee
)

select
*
from 
max_salary_emp_cte
where salary = max_salary

;



-- write a query to print emp name, salary and dep id of highest salaried overall
with max_salary_emp_cte as
(

	select
	*
	, max(salary) over() as highest_salary
	from 
	employee
)
select
*
from 
max_salary_emp_cte 
where salary = highest_salary
;

--  write a query to print product id and total sales of highest selling products (by no of units sold) in each category
with max_quantity_cte as
(
	select
	category
	, quantity
	, sales
	, product_id
	, product_name
	, max(quantity) over(partition by category) as max_quantity
	from 
	orders
) , highest_selling_products_cte as
(

	select
	*
	, max(sales) over(partition by category) as max_sales_value
	from max_quantity_cte
	where quantity = max_quantity

)
select
*

from 
highest_selling_products_cte
where sales = max_sales_value
order by category, sales desc, max_sales_value desc
;



-- https://www.namastesql.com/coding-problem/8-library-borrowing-habits

select 
l.BorrowerName
, STRING_AGG(BookName, ',') WITHIN GROUP(order by BookName)
from Borrowers l
inner join books r
on l.BookID = r.BookID
group by l.BorrowerName    
order by l.BorrowerName    
;


with loans_aggregated_cte as
(
select
loan_id
, sum(amount_paid) as amount_paid
 , max(payment_date) as last_payment_date
from payments
group by loan_id
)

select
l.loan_id
, l.loan_amount
, l.due_date
, case when amount_paid = loan_amount then 1 else 0 end as fully_paid_flag 
, case when last_payment_date <= due_date then 1 else 0 end as on_time_flag
from loans l inner join loans_aggregated_cte r
on l.loan_id = r.loan_id
;


select
category
, coalesce(min(case when r.stars is not null then price end), 0) as lowesr_price
from products l left join purchases r
on l.id = r.product_id and r.stars>=4
group by category
order by category




