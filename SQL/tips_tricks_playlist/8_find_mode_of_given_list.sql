use tips_db;

create table mode
(
    id int
);

insert into mode
values
    (1),
    (2),
    (2),
    (3),
    (3),
    (3),
    (3),
    (4),
    (5);

with mode_cte AS
(

    SELECT id
    , COUNT(*) as freq
    from mode
    GROUP BY id
)
SELECT 
* FROM mode_cte
WHERE freq = (select max(freq) from mode_cte)


with mode_cte AS
(

    SELECT id
    , COUNT(*) as freq
    from mode
    GROUP BY id
), rank_cte as (
select *
, RANK() OVER(order by freq desc) as rnk
from mode_cte
) SELECT * FROM rank_cte WHERE rnk = 1

