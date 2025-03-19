

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');
with cte as
(
select 
*
, row_number() over(partition by city order by name) as rn
from players_location
)
select 
MAX(CASE WHEN city = 'Bangalore' then name end) as 'Bangalore'
, MAX( CASE WHEN city = 'Mumbai' then name end )as 'Mumbai'
, MAX(CASE WHEN city = 'Delhi' then name end ) as 'Delhi'
from cte
group by rn;

