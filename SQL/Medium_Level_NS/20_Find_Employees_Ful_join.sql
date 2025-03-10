
----------------------------------------------------------------------------
-- Find out employees which are not present in the source and 
-- target and also flag them as
-- Only source then New in source
-- only target then new in target
-- id matches but not name then mismatch
----------------------------------------------------------------------------


create table source(id int, name varchar(5));

create table target(id int, name varchar(5));

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');
select * from source;
select * from target;

WITH Derived_cte
as
(
  select 
 	source.id as s_id
  	, source.name as s_name
  	, target.id as t_id
  	, target.name as t_name
  , case when source.id  = target.id AND source.name <> target.name then 'Mismatch'
      when source.id IS null then 'new in target'
      when target.id IS NULL then 'new in source'
  end as col_flag
  from 
  source full outer join target 
  on source.id = target.id
) 
select * from 
Derived_cte
where col_flag IS NOT NULL
;
