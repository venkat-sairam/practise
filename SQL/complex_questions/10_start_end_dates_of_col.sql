
use tips_db;

create table tasks
(
    date_value date,
    state varchar(10)
);

insert into tasks
values
    ('2019-01-01', 'success'),
    ('2019-01-02', 'success'),
    ('2019-01-03', 'success'),
    ('2019-01-04', 'fail')
,
    ('2019-01-05', 'fail'),
    ('2019-01-06', 'success')
    ;


with date_Cte as (
SELECT 
*
, ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value) as rn
FROM tasks
)
SELECT 
MIN(date_value) as start_date
, MAX(date_value) as end_date
, state
from date_Cte
GROUP by DATEADD(DAY, -1 * rn, date_Value), [state]
