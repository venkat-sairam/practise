
use db;

create table company_revenue
(
    company varchar(100),
    year int,
    revenue int
)

insert into company_revenue
values
    ('ABC1', 2000, 100),
    ('ABC1', 2001, 110),
    ('ABC1', 2002, 120),
    ('ABC2', 2000, 100),
    ('ABC2', 2001, 90),
    ('ABC2', 2002, 120)
,
    ('ABC3', 2000, 500),
    ('ABC3', 2001, 400),
    ('ABC3', 2002, 600),
    ('ABC3', 2003, 800);

with cte as
(
        SELECT *,
            revenue - Lag(revenue, 1, 0) OVER(partition by company order by year)  as lead_revenue
            , COUNT(*) OVER(partition by company) as cnt
        from company_revenue
)
SELECT
    company
from cte
WHERE lead_revenue > 0
GROUP by company, cnt
HAVING COUNT(1) = cnt
;

----------------------------------------------------------------
-- Using subquery to get companies with positive revenue growth
----------------------------------------------------------------
with cte as
(

    SELECT *,
    revenue - Lag(revenue, 1, 0) OVER(partition by company order by year)  as lead_revenue
    , COUNT(*) OVER(partition by company) as cnt
    from company_revenue
)
SELECT
    distinct company
from cte
where company not in (SELECT company from cte where lead_revenue < 0)

 ;