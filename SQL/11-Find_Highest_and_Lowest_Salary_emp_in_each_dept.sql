
use db;

----------------------------------------------------------------
-- SQL Query to find highest and lowest salaries for each department
----------------------------------------------------------------

SELECT *
FROM employee
ORDER BY dept_id, salary desc
;

----------------------------------------------------------------
-- Approach:1 using group by
----------------------------------------------------------------
with
    cte
    as
    (
        SELECT
            dept_id
    , MAX(salary) as max_salary
    , MIN(salary) as min_salary
        from employee
        GROUP BY dept_id
    )
select
    c.dept_id
, MAX( case WHEN e.salary = max_salary then e.emp_name end) as max_salaried_employee
, max(CASE WHEN e.salary = min_salary then e.emp_name end) as min_salaried_employee
from
    employee e INNER JOIN cte c
    on e.dept_id = c.dept_id
GROUP BY c.dept_id

;

on A.dept_id = e.dept_id and
(e.salary = max_salary or e.salary = min_salary)




----------------------------------------------------------------
-- Approach:2 using first_value() and last_value() functions.
----------------------------------------------------------------

with
    cte
    AS
    (
        SELECT
            dept_id
, salary
, FIRST_VALUE(emp_name) OVER(partition by dept_id ORDER by salary DESC) as highest_Salary
, LAST_VALUE(emp_name) OVER(partition by dept_id ORDER by salary DESC rows between unbounded preceding and unbounded following) as lowest_Salary
        from employee
    )
SELECT
    distinct dept_id, highest_Salary, lowest_Salary
from cte
;


----------------------------------------------------------------
-- Approach:3 using window functions.
----------------------------------------------------------------

with
    cte_window_function
    AS
    (
        SELECT
            *    
            , ROW_NUMBER() OVER (PARTITION by dept_id ORDER BY salary DESC) as max_Salary
            , ROW_NUMBER() OVER(partition by dept_id ORDER by salary) as min_salary
        from employee
    )
select
    dept_id
, max(case when max_Salary = 1 then emp_name end) as max_Salaried_employee
, MIN(case when min_salary = 1 then emp_name end )as min_salaried_employee
from cte_window_function
GROUP BY dept_id
    ;