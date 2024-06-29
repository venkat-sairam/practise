

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


-- write a sql query to find the employees who are inside the hospital


with cte_inside_hospital AS
(
	select 
	emp_id
	, action
	--, time
	, CASE 
		WHEN h.action = 'in' THEN lead(h.time, 1) over (partition by h.emp_id order by h.emp_id, h.time)
		when h.action = 'out' THEN h.time

	END as time_out
	from hospital h
)
select 
emp_id
 from cte_inside_hospital
where time_out IS NULL
;
