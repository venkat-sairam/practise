use db;

-- ----------------------------------------------------------
-- Table Creation for Start and End Call Logs
----------------------------------------------------------------


create table call_start_logs
(
    phone_number varchar(10),
    start_time datetime
);
insert into call_start_logs
values
    ('PN1', '2022-01-01 10:20:00'),
    ('PN1', '2022-01-01 16:25:00'),
    ('PN2', '2022-01-01 12:30:00')
,
    ('PN3', '2022-01-02 10:00:00'),
    ('PN3', '2022-01-02 12:30:00'),
    ('PN3', '2022-01-03 09:20:00')
;
create table call_end_logs
(
    phone_number varchar(10),
    end_time datetime
);
insert into call_end_logs
values
    ('PN1', '2022-01-01 10:45:00'),
    ('PN1', '2022-01-01 17:05:00'),
    ('PN2', '2022-01-01 12:55:00')
,
    ('PN3', '2022-01-02 10:20:00'),
    ('PN3', '2022-01-02 12:50:00'),
    ('PN3', '2022-01-03 09:40:00')
;

select *
from call_start_logs;
SELECT *
from call_end_logs;

----------------------------------------------------------------
-- Find the start and end time of the given call logs.
----------------------------------------------------------------

with
    start_logs_cte
    as
    (
        SELECT *
, ROW_NUMBER() OVER(partition by phone_number ORDER by start_time) as rn
        from
            call_start_logs
    )
,
    end_logs_cte
    as
    (
        select * 
, ROW_NUMBER() OVER(partition by phone_number ORDER by end_time) as rn
        from call_end_logs
    )
SELECT
    s.phone_number
, s.start_time
, e.end_time
from start_logs_cte s INNER JOIN end_logs_cte e
    on s.phone_number = e.phone_number AND s.rn = e.rn
ORDER BY 
    s.phone_number, s.start_time;
;


----------------------------------------------------------------
-- Approach:2 -  Find the duration of each call.
----------------------------------------------------------------


with cte_union as
(
    SELECT 
    s.phone_number as ph1
    , s.start_time as start_time
    , ROW_NUMBER() OVER(partition by phone_number ORDER by start_time) as srn
    from call_start_logs s

    UNION ALL
    
    select 
    e.phone_number as eph1
    , e.end_time as end_time
    , ROW_NUMBER() OVER(partition by phone_number ORDER by end_time) as ern
    from call_end_logs e
)
SELECT 
ph1
,MIN(start_time) as start_time
, MAX(start_time) as end_time
, DATEDIFF(MINUTE, MIN(start_time), MAX(start_time)) as duration_in_minutes
 from cte_union
GROUP BY ph1, srn
ORDER BY ph1, start_time
;

