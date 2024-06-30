
--------------------------------------------------------------------------------
-- Write a query to print the users with same salary in all depeartments.
--------------------------------------------------------------------------------

CREATE TABLE [emp_salary]
(
    [emp_id] INTEGER NOT NULL,
    [name] NVARCHAR(20) NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);


INSERT INTO emp_salary
    (emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
    (102, 'rohan', '4000', '12'),
    (103, 'mohan', '5000', '13'),
    (104, 'cat', '3000', '11'),
    (105, 'suresh', '4000', '12'),
    (109, 'mahesh', '7000', '12'),
    (108, 'kamal', '8000', '11');

----------------------------------------------------------------
-- Expected OUTPUT
----------------------------------------------------------------
-- Emp_id   Emp_name    dept_id         salary
-- 101	    sohan           11          3000
-- 104      cat             11          3000
-- 105      suresh          12          4000
-- 102      rohan           12          4000
----------------------------------------------------------------

-- =============
-- Approach-1:
-- =============

with same_salary_in_dept_cte AS
(

  SELECT 
  dept_id
  , salary
  from 
  emp_salary
  GROUP BY dept_id, salary
  HAVING COUNT(*) >= 2

)
select 
r.emp_id
, r.name
, r.dept_id
, r.salary

from same_salary_in_dept_cte l
INNER JOIN emp_salary r
ON l.dept_id = r.dept_id AND l.salary = r.salary

;


-- =============
-- Approach-2:
-- =============


-- Filter out the departments that doesn't have more than one employee with the same salary.
-- Use these department details to exclude from the main employee table using left join.


with same_salary_in_dept_cte AS 
(
    SELECT
        dept_id
        , salary
    from
        emp_salary
    GROUP BY dept_id, salary
    HAVING COUNT(1) =1

    )
select
l.*, r.*
FROM 
emp_salary l
    LEFT JOIN 
same_salary_in_dept_cte r
    ON r.dept_id = l.dept_id AND r.salary = l.salary
    where r.dept_id IS NULL
;
