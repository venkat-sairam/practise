

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

--================================================================
--Approach
--================================================================
-- 1. Find the emp id and the latest timestamp
-- 2. Find the emp id and the latest in time.
-- 3. Check if the latest time and latest in-time are same
-- 4. If yes then add to output.
----------------------------------------------------------------


with cte_latest_time AS 
(
	select emp_id, max(time) as latest_time from hospital group by emp_id
), latest_in_time as
(
	select emp_id, max(time) as latest_in_time from hospital where action='in' group by emp_id
)
select * from 
cte_latest_time t inner join latest_in_time i
on t.emp_id=i.emp_id and t.latest_time = i.latest_in_time
;

