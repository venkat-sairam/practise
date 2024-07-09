USE tips_db;

create table entries
(
    name varchar(20),
    address varchar(20),
    email varchar(20),
    floor int,
    resources varchar(10)
);

insert into entries
values
    ('A', 'Bangalore', 'A@gmail.com', 1, 'CPU'),
    ('A', 'Bangalore', 'A1@gmail.com', 1, 'CPU'),
    ('A', 'Bangalore', 'A2@gmail.com', 2, 'DESKTOP')
,
    ('B', 'Bangalore', 'B@gmail.com', 2, 'DESKTOP'),
    ('B', 'Bangalore', 'B1@gmail.com', 2, 'DESKTOP'),
    ('B', 'Bangalore', 'B2@gmail.com', 1, 'MONITOR')

with max_floor_visited_Cte AS
(
SELECT 
name, floor, COUNT(*) as floor_visited_count
, DENSE_RANK() OVER (PARTITION BY name ORDER by COUNT(*) DESC) as rnk
 FROM
entries
GROUP BY name, [floor]
), most_visited_Cte AS (
select name 
, [floor] as most_visited_floor_name
, floor_visited_count
 from max_floor_visited_Cte
where rnk = 1
), distinct_resources_Cte AS
(
    SELECT DISTINCT name, resources
    FROM entries
)

SELECT 

e.name as customer_name
, m.most_visited_floor_name as most_visited_floor_name
, STRING_AGG(e.resources, ',') as resources_Accessed
FROM distinct_resources_Cte e inner JOIN
most_visited_Cte m 
on e.name = m.name
GROUP BY e.name, m.most_visited_floor_name

;

