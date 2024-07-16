use tips_db;

create table bms
(
    seat_no int ,
    is_empty varchar(10)
);
insert into bms
values
    (1, 'N')
,
    (2, 'Y')
,
    (3, 'N')
,
    (4, 'Y')
,
    (5, 'Y')
,
    (6, 'Y')
,
    (7, 'N')
,
    (8, 'Y')
,
    (9, 'Y')
,
    (10, 'Y')
,
    (11, 'Y')
,
    (12, 'N')
,
    (13, 'Y')
,
    (14, 'Y');


with cte as (
SELECT 
* 
, LAG(is_empty, 1) OVER(order by seat_no) as prev_1
, LAG(is_empty, 2) OVER(order by seat_no) as prev_2
, LEAD(is_empty, 1) OVER(order by seat_no) as next_1
, LEAD(is_empty, 2) OVER(order by seat_no) as next_2

 FROM bms
)
SELECT 
*
FROM
cte
WHERE (is_empty = 'Y' AND prev_1= 'Y' and prev_2 = 'Y')
OR (is_empty= 'Y' AND prev_1= 'Y' and next_1 = 'Y')
OR (is_empty= 'Y' AND next_1 = 'Y' and next_2 = 'Y')
;

----------------------------------------------------------------
-- Filter more than 3 consecutive empty records from bms table
----------------------------------------------------------------


with main_cte AS (

SELECT
*
, seat_no - ROW_NUMBER() OVER(order by seat_no) as rn 
FROM bms
WHERE is_empty = 'Y' 
)

SELECT * FROM main_cte WHERE
rn IN (
SELECT --* from main_cte
rn
from main_cte
GROUP BY rn
HAVING COUNT(*) >= 3
)


----------------------------------------------------------------
-- Approach- 3
----------------------------------------------------------------


with cte as (
SELECT
*
, SUM(case when is_empty= 'Y' then 1 else 0 end) OVER(order by seat_no rows between 2 preceding and current row) as prev_2
, SUM(case when is_empty= 'Y' then 1 else 0 end) OVER(order by seat_no rows between 1 preceding and 1 following) as curr_prev_1
, SUM(case when is_empty= 'Y' then 1 else 0 end) OVER(order by seat_no rows between current row and 2 following) as next_2
from bms 
)
SELECT
*
FROM
cte WHERE prev_2= 3 or curr_prev_1 = 3 or next_2 = 3