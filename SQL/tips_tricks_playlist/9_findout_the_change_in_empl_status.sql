
use tips_db;

create table emp_2020
(
    emp_id int,
    designation varchar(20)
);

create table emp_2021
(
    emp_id int,
    designation varchar(20)
)

insert into emp_2020
values
    (1, 'Trainee'),
    (2, 'Developer'),
    (3, 'Senior Developer'),
    (4, 'Manager');
insert into emp_2021
values
    (1, 'Developer'),
    (2, 'Developer'),
    (3, 'Manager'),
    (5, 'Trainee');

SELECT * from emp_2020;
SELECT * from emp_2021;

SELECT *
, COALESCE(e1.emp_id, e2.emp_id) as emp_id
, case when e1.emp_id = e2.emp_id AND e1.designation <> e2.designation then 'promoted'
        when e1.emp_id IS NULL then 'New Employee'
        when e2.emp_id IS NULL then 'Employee Left'
end as status
 from emp_2020 e1 FULL OUTER JOIN emp_2021 e2
on e1.emp_id = e2.emp_id 
WHERE e1.designation != e2.designation or e1.emp_id IS NULL or e2.emp_id IS NULL
;

