use db;

create table people
(
    id int primary key not null,
    name varchar(20),
    gender char(2)
);

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people
    (id, name, gender)
values
    (107, 'Days', 'F'),
    (145, 'Hawbaker', 'M'),
    (155, 'Hansel', 'F'),
    (202, 'Blackston', 'M'),
    (227, 'Criss', 'F'),
    (278, 'Keffer', 'M'),
    (305, 'Canty', 'M'),
    (329, 'Mozingo', 'M'),
    (425, 'Nolf', 'M'),
    (534, 'Waugh', 'M'),
    (586, 'Tong', 'M'),
    (618, 'Dimartino', 'M'),
    (747, 'Beane', 'M'),
    (878, 'Chatmon', 'F'),
    (904, 'Hansard', 'F');

insert into relations
    (c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278, 305),
    (278, 155),
    (329, 425),
    (329, 227),
    (534, 586),
    (534, 878),
    (618, 747),
    (618, 904);

SELECT * from people;
SELECT * from relations;

-- --------------------------------------------------------------------
-- Creating separate male and female tables and finally joining them
-----------------------------------------------------------------------

with male_table AS 
(
    SELECT * from relations r INNER JOIN people p
    on r.p_id = p.id
    WHERE gender = 'M'
), female_table AS
(
SELECT *
from relations r INNER JOIN people p
    on r.p_id = p.id
WHERE gender = 'F'
)

SELECT 

    male_table.c_id as child_id
    , male_table.name as father_name
    , female_table.name as mother_name

from male_table INNER JOIN female_table
on male_table.c_id = female_table.c_id

;

----------------------------------------------------------------
-- Using Window Functions and Group BY
----------------------------------------------------------------
with combined_table_cte AS
(
    SELECT 
    r.c_id AS child_id
    , case when p.gender  = 'M' then p.name end as father_name
    , case when p.gender  = 'F' then p.name end as mother_name
    from relations r INNER JOIN people p
    on r.p_id = p.id
)
SELECT 
    child_id
    , MAX(father_name) as father_name
    , MAX(mother_name) as mother_name
FROM combined_table_cte
GROUP by child_id
;
