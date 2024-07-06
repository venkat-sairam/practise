use db;
create table emp
(
    emp_id int,
    emp_name varchar(20),
    department_id int,
    salary int,
    manager_id int,
    emp_age int
);

insert into emp
values
    (1, 'Ankit', 100, 10000, 4, 39);
insert into emp
values
    (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values
    (3, 'Vikas', 100, 10000, 4, 37);
insert into emp
values
    (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values
    (5, 'Mudit', 200, 12000, 6, 55);
insert into emp
values
    (6, 'Agam', 200, 12000, 2, 14);
insert into emp
values
    (7, 'Sanjay', 200, 9000, 2, 13);
insert into emp
values
    (8, 'Ashish', 200, 5000, 2, 12);
insert into emp
values
    (9, 'Mukesh', 300, 6000, 6, 51);
insert into emp
values
    (10, 'Rakesh', 300, 7000, 6, 50);



SELECT * from emp;

-- Query1: Find all the duplicate records from employees table

SELECT * from emp WHERE emp_id IN
(
SELECT emp_id from emp e
GROUP by emp_id
HAVING COUNT(*) > 1
)

-- Query2: Remove duplicate records from employees table
with delete_duplicate_Records_Cte AS
(
SELECT 
*
, ROW_NUMBER() OVER (PARTITION by emp_id order by emp_id) as rn
from emp
)
delete from delete_duplicate_Records_Cte
 WHERE rn > 1
;

----------------------------------------------------------------
-- Query3: Difference between Union and Union All
----------------------------------------------------------------

SELECT emp_id, emp_name, emp_age From emp
UNION
SELECT manager_id, emp_name, emp_age from emp
ORDER BY emp_id, emp_name



----------------------------------------------------------------
-- Query-5: Filter the employees who are not present in any department
----------------------------------------------------------------

SELECT * from dept;

-- Using Sub Query
SELECT * FROM employee WHERE dept_id not in (select dep_id from dept)

-- Using Left Join
SELECT * from employee e left join dept d
on e.dept_id = d.dep_id
WHERE d.dep_id IS NULL
;



with cte as 
(
SELECT dept_id, MAX(salary) as highest_salary
from employee
GROUP BY dept_id
)
, filtered_employees_Cte AS
(
SELECT
    e.emp_id
, e
.emp_name
, e.dept_id
, e.salary

from employee e

EXCEPT

SELECT 
e.emp_id
, e.emp_name
, e.dept_id
, e.salary

from cte
INNER JOIN employee e on e.dept_id = cte.dept_id and e.salary = cte.highest_salary
), second_highest_salary_Cte as
(
SELECT 
f.dept_id, MAX(salary) as second_highest_salary
 from filtered_employees_Cte f
GROUP BY f.dept_id
)
SELECT * from second_highest_salary_Cte  s
INNER JOIN employee e 
on e.dept_id = s.dept_id and e.salary = s.second_highest_salary
;

--- Approach-2:

with drn_Cte as (

SELECT 
*, 
DENSE_RANK() OVER(PARTITION by dept_id order by salary desc) as drn
 FROM employee e
)
SELECT 
emp_id
, emp_name
, dept_id
, salary
, drn
 FROM drn_Cte

 WHERE drn = 2
;
