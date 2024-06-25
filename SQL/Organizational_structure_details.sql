
select 
e.company_code, 
c.founder, 
  count( distinct e.lead_manager_code), 
  count( distinct e.senior_manager_code), 
  count(distinct manager_code),
  count(distinct employee_code)
from employee e
inner join company c on  e.company_code = c.company_code
group by e.company_code, c.founder
order by e.company_code;
