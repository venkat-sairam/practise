use tips_db;

CREATE table activity
(
    user_id varchar(20),
    event_name varchar(20),
    event_date date,
    country varchar(20)
);
delete from activity;
insert into activity
values
    (1, 'app-installed', '2022-01-01', 'India')
,
    (1, 'app-purchase', '2022-01-02', 'India')
,
    (2, 'app-installed', '2022-01-01', 'USA')
,
    (3, 'app-installed', '2022-01-01', 'USA')
,
    (3, 'app-purchase', '2022-01-03', 'USA')
,
    (4, 'app-installed', '2022-01-03', 'India')
,
    (4, 'app-purchase', '2022-01-03', 'India')
,
    (5, 'app-installed', '2022-01-03', 'SL')
,
    (5, 'app-purchase', '2022-01-03', 'SL')
,
    (6, 'app-installed', '2022-01-04', 'Pakistan')
,
    (6, 'app-purchase', '2022-01-04', 'Pakistan');


SELECT * 
FROM
activity
ORDER BY event_date
;


/*
Find total active users on each day. Active users can  purchase or install the application.

*/

SELECT
event_date
, COUNT(distinct user_id) as active_users_count
from
activity
GROUP BY event_date
;


/*
Find active users on each weekday.
Sunday - ?
Monday - ?
----
*/


SELECT
DATENAME(WEEKDAY, event_date) as wk_num
, COUNT(distinct USER_ID) as active_users_count
FROM
activity
GROUP BY DATENAME(WEEKDAY, event_date)
;

/*
Find active users on each week.
week_1: ??
week_2: ??
----
*/


SELECT

    DATEPART(WEEK, event_date) as wk_num
, COUNT(distinct USER_ID) as active_users_count
FROM
    activity
GROUP BY DATEPART(week, event_date)
;

----------------------------------------------------------------

----------------------------------------------------------------

with installed_Cte AS (
SELECT *
FROM
activity
WHERE event_name = 'app-installed'
)
, purchase_Cte AS (
SELECT *
FROM
    activity
WHERE event_name = 'app-purchase'
)
, purchase_sign_upcte AS (
SELECT 
 
    installed_Cte.event_date
    , COUNT(distinct installed_Cte.user_id) as active_users_count
    
 FROM installed_Cte INNER JOIN purchase_Cte
on installed_Cte.event_date = purchase_Cte.event_date
GROUP BY installed_Cte.event_date
)
SELECT 
*
-- activity.event_date
-- , COUNT(distinct purchase_sign_upcte.active_users_count)
 FROM 
activity LEFT JOIN purchase_sign_upcte
on activity.event_date = purchase_sign_upcte.event_date
GROUP BY activity.event_date

;


----------------------------------------------------------------
-- P3 Apporach-2
----------------------------------------------------------------

-- with new_cte AS (
-- SELECT 
--     user_id, event_date, COUNT(distinct event_name) as event_count
--     , case when COUNT(distinct event_name) = 2 then user_id else null end as new_user
-- FROM
--     activity
-- group BY user_id, event_date
-- )
-- select 
-- event_date

-- ,COUNT(new_user) as count
-- from new_cte
-- GROUP BY event_date;



----------------------------------------------------------------
-- P4 Country wise purchasal percentage
----------------------------------------------------------------


with cte as (
SELECT 
    *
    , case 
        when country IN ('India' , 'USA' )then country else 'Others'
    end as country_code
    , COUNT(1) OVER() as total_cnt

FROM activity WHERE event_name= 'app-purchase'
)
SELECT 
country_code
, (COUNT(*) *1.0 / (total_cnt) )* (100) as total_cnt
 FROM cte 
 GROUP BY country_code, total_cnt
;

----------------------------------------------------------------
--  P5: 
----------------------------------------------------------------

