with emp_cte as 
(
SELECT
e.name as ename
,d.department_name as dname
, e.salary as salary
, dense_rank() over( PARTITION BY d.department_name ORDER BY e.salary desc) as drn

FROM
employee e inner join department d 
on e.department_id = d.department_id
)
SELECT 
dname
, ename
, salary
from emp_cte
where drn<=3
order by dname, salary desc;
