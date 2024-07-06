
USE db;

create table emp_compensation
(
    emp_id int,
    salary_component_type varchar(20),
    val int
);
insert into emp_compensation
values
    (1, 'salary', 10000),
    (1, 'bonus', 5000),
    (1, 'hike_percent', 10)
,
    (2, 'salary', 15000),
    (2, 'bonus', 7000),
    (2, 'hike_percent', 8)
,
    (3, 'salary', 12000),
    (3, 'bonus', 6000),
    (3, 'hike_percent', 7);


SELECT * from emp_compensation
;

---------------------------------------------------------------------------
-- Pivot the given table and restore the original table from pivoted table
---------------------------------------------------------------------------

with pivoted_emp_data as 
(
select emp_id
, min(CASE when salary_component_type='bonus' then val END )as bonus
, min(CASE when salary_component_type='hike_percent' then val  END) as hike_percent
, min( case when salary_component_type='salary' then val  END ) as salary

from emp_compensation
GROUP BY emp_id
)

SELECT 
emp_id
, bonus
, 'bonus' as bonus_

FROM pivoted_emp_data

UNION all

SELECT
    emp_id
, hike_percent
, 'hike_percent' as hike_percent

FROM pivoted_emp_data
UNION ALL
SELECT
    emp_id
, salary
, 'salary' as salary

FROM pivoted_emp_data

