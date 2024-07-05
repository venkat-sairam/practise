use db;

create table source
(
    id int,
    name varchar(5)
)

create table target
(
    id int,
    name varchar(5)
)

insert into source
values(1, 'A'),
    (2, 'B'),
    (3, 'C'),
    (4, 'D')

insert into target
values(1, 'A'),
    (2, 'B'),
    (4, 'X'),
    (5, 'F');


--------------------------------------------------------------------------
-- Find out the records which are new/mistmatch in source/target tables.
--------------------------------------------------------------------------

with cte as 
(
    SELECT 
    s.id as source_id
    , s.name as source_name
    , t.id as target_id
    , t.name as target_name
    , case when s.id = t.id AND (s.name = t.name) then 'match'
        when s.id = t.id AND (S.name <> t.name) then 'mismatch'
        when s.id is NULL then 'new_target'
        else 'new_source'
    end as flag
    from source s FULL JOIN  [target] t on s.id = t.id
    
)
SELECT 
case when source_id IS NOT NULL THEN source_id
WHEN source_id is NULL then target_id
end as id
, flag
 from cte
where flag <> 'match';

;