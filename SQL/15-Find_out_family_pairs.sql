

USE db;

create table family
(
    person varchar(5),
    type varchar(10),
    age int
);
delete from family
;
insert into family
values
    ('A1', 'Adult', 54)
,
    ('A2', 'Adult', 53),
    ('A3', 'Adult', 52),
    ('A4', 'Adult', 58),
    ('A5', 'Adult', 54),
    ('C1', 'Child', 20),
    ('C2', 'Child', 19),
    ('C3', 'Child', 22),
    ('C4', 'Child', 15);
---------------------------------------------------------------------
-- Create a Pair (A1, C1...) incase they are adults without any pair
-- print them too..
---------------------------------------------------------------------
with
    adult_cte
    as
    (

        SELECT *
, ROW_NUMBER() OVER(partition by type order by person) as rnk
        FROM family
        WHERE [type] = 'Adult'
    ),
    child_cte
    as
    (
        SELECT *, ROW_NUMBER() OVER(partition by type order by person) as rnk
        FROM family
        where type = 'Child'
    )
select
    a.person
, c.person
from adult_cte a LEFT JOIN child_cte c
    on a.rnk = c.rnk


----------------------------------------------------------------
-- retrieve Eldest adult pair with youngest child
----------------------------------------------------------------


with
    adult_cte
    as
    (

        SELECT *
, ROW_NUMBER() OVER(partition by type order by age desc) as rnk
        FROM family
        WHERE [type] = 'Adult'
    ),
    child_cte
    as
    (
        SELECT *, ROW_NUMBER() OVER(partition by type order by age) as rnk
        FROM family
        where type = 'Child'
    )


select
    a.person
, c.person
from adult_cte a LEFT JOIN child_cte c
    on a.rnk = c.rnk

-- person	type	age
-- rnk
-- A4	Adult	58	1
-- A5	Adult	54	2
-- A1	Adult	54	3
-- A2	Adult	53	4
-- A3	Adult	52	5

-- person	type	age
-- rnk
-- C4	Child	15	1
-- C2	Child	19	2
-- C1	Child	20	3
-- C3	Child	22	4

-- person	person
-- A4
-- C4
-- A5	C2
-- A1	C1
-- A2	C3
-- A3	NULL