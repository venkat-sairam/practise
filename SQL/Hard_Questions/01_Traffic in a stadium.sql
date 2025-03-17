-- find out the records which have 3 or more consecutive rows where the no_of_people >=3 in each day.
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

with cte1 as
(
	select *
  , row_number() over(order by visit_date) as rn
  ,id- row_number() over(order by visit_date) as diff
  	from stadium
  where no_of_people >=100
 )
 select * from cte1 where diff in (
 
  select 
  diff
  from cte1
  group by diff
  having count(*) >= 3
   )
;
