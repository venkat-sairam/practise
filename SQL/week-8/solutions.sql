

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

-- https://www.namastesql.com/coding-problem/71-department-average-salary
-- You are provided with two tables: Employees and Departments. 
-- The Employees table contains information about employees, including their IDs, names, salaries, and department IDs.
--The Departments table contains information about departments, including their IDs and names.
-- Your task is to write a SQL query to find the average salary of employees in each department, but only include departments that have more than 2 employees . 
-- Display department name and average salary round to 2 decimal places. Sort the result by average salary in descending order.

 

Tables: Employees
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| employee_id   | int         |
| employee_name | varchar(20) |
| salary        | int         |
| department_id | int         |
+---------------+-------------+
Tables: Departments
+-----------------+-------------+
| COLUMN_NAME     | DATA_TYPE   |
+-----------------+-------------+
| department_id   | int         |
| department_name | varchar(10) |
+-----------------+-------------+

with grouped_emp_avg_salary_cte as
(
	select 
    department_id
    , ROUND(AVG(salary), 2) as average_salary
    , COUNT(1) AS emp_count
    from employees
    GROUP BY department_id
)
, filtered_emp_cte AS (
SELECT 
 *
FROM grouped_emp_avg_salary_cte
WHERE emp_count > 2
)

SELECT 
l.department_name
, r.average_salary
FROM
departments l inner join
filtered_emp_cte r
on l.department_id = r.department_id
order by  r.average_salary desc
;

