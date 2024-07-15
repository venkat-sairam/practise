use tips_db;
create table billings
(
    emp_name varchar(10),
    bill_date date,
    bill_rate int
);
delete from billings;
insert into billings
values
    ('Sachin', '01-JAN-1990', 25)
,
    ('Sehwag' , '01-JAN-1989', 15)
,
    ('Dhoni' , '01-JAN-1989', 20)
,
    ('Sachin' , '05-Feb-1991', 30)
;

create table HoursWorked
(
    emp_name varchar(20),
    work_date date,
    bill_hrs int
);
insert into HoursWorked
values
    ('Sachin', '01-JUL-1990' , 3)
,
    ('Sachin', '01-AUG-1990', 5)
,
    ('Sehwag', '01-JUL-1990', 2)
,
    ('Sachin', '01-JUL-1991', 4)

;

SELECT * FROM billings;


with cte as 
(
SELECT 
*
, LEAD(dateadd(day, -1, bill_date), 1, '9999-01-01') OVER(partition by emp_name ORDER by bill_date) as next_pay
 FROM billings

)

SELECT 
distinct l.emp_name
-- , l.work_date
-- , l.bill_hrs
-- , r.bill_date
-- , r.next_pay
-- , r.bill_rate
-- , l.bill_hrs * r.bill_rate
, SUM(l.bill_hrs* r.bill_rate) OVER(PARTITION BY l.emp_name)
 FROM 
HoursWorked l LEFT JOIN cte r
ON (l.emp_name = r.emp_name) and (l.work_date between r.bill_date and r.next_pay)

-- SELECT * FROM HoursWorked


