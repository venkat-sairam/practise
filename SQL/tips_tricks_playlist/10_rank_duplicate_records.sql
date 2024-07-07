use tips_db;

create table list
(
    id varchar(5)
);
insert into list
values
    ('a');
insert into list
values
    ('a');
insert into list
values
    ('b');
insert into list
values
    ('c');
insert into list
values
    ('c');
insert into list
values
    ('c');
insert into list
values
    ('d');
insert into list
values
    ('d');
insert into list
values
    ('e');

with rank_Cte as 
(
SELECT id 
, dense_RANK() OVER (ORDER BY id) as rnk
 from list
), grouped_data_Cte as (
SELECT
--  * FROM rank_Cte
id, COUNT(*) as freq
, case when COUNT(*) > 1 then 'DUP' else 'not' END as rnk
from rank_Cte
GROUP BY id
), final_data_cte AS (
SELECT id
, CONCAT(rnk, DENSE_RANK() OVER(order  by id)) as sec_rnk
 FROM grouped_data_Cte
WHERE rnk != 'not'
)
SELECT ISNULL(l.id, f.id), F.sec_rnk from list l LEFT JOIN final_data_cte f on l.id = f.id

;


----------------------------------------------------------------
-- Approach-2:
----------------------------------------------------------------


with freq_rank_cte as (
SELECT
id, ROW_NUMBER() OVER(order by id) as rn
From list
GROUP BY id
HAVING COUNT(*) > 1
)
SELECT 
l.id
, CASE when r.rn is NOT NULL then CONCAT('dup', r.rn)  end as flag
 from  list l LEFT JOIN freq_rank_cte r ON l.id = r.id
;




