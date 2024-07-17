use tips_db;

create table covid
(
    city varchar(50),
    days date,
    cases int
);
delete from covid;
insert into covid
values('DELHI', '2022-01-01', 100);
insert into covid
values('DELHI', '2022-01-02', 200);
insert into covid
values('DELHI', '2022-01-03', 300);

insert into covid
values('MUMBAI', '2022-01-01', 100);
insert into covid
values('MUMBAI', '2022-01-02', 100);
insert into covid
values('MUMBAI', '2022-01-03', 300);

insert into covid
values('CHENNAI', '2022-01-01', 100);
insert into covid
values('CHENNAI', '2022-01-02', 200);
insert into covid
values('CHENNAI', '2022-01-03', 150);

insert into covid
values('BANGALORE', '2022-01-01', 100);
insert into covid
values('BANGALORE', '2022-01-02', 300);
insert into covid
values('BANGALORE', '2022-01-03', 200);
insert into covid
values('BANGALORE', '2022-01-04', 400);

with cte AS (
    SELECT
        *
        , LAG(cases, 1, cases) OVER(partition by city ORDER by days) as prev_Cases
        , cases - LAG(cases, 1) OVER(partition by city ORDER by days) as diff_cases
        , RANK() OVER(partition by city order by cases ) as rnk
    FROM
    covid
)
SELECT --* from cte
city
, SUM(case when diff_cases < 0 then 1 else 0 end ) as neg_count
, MAX(rnk) as max_val
, COUNT(1) as total_cnt
FROM 
cte 
GROUP BY city
HAVING SUM(case when diff_cases < 0 then 1 else 0 end ) = 0 AND COUNT(distinct rnk) = COUNT(1)


---------------------------------------------------------------------
--  Find the cities where the covid cases were increasing continuously
---------------------------------------------------------------------

with cte2 AS
(
    SELECT 
    *
    , RANK() OVER(partition by city order by days) as r1
    , RANK() OVER(partition by city order by cases ) as r2
    , RANK() OVER(partition by city order by days ) - RANK() OVER(partition by city order by cases ) as diff
    FROM
    covid

)
SELECT 
city
 FROM cte2
GROUP BY city
HAVING COUNT(distinct diff) = 1 and MAX(diff) = 0

;


