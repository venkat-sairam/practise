use tips_db;

create table spending
(
    user_id int,
    spend_date date,
    platform varchar(10),
    amount int
);

insert into spending
values(1, '2019-07-01', 'mobile', 100),
    (1, '2019-07-01', 'desktop', 100),
    (2, '2019-07-01', 'mobile', 100)
,
    (2, '2019-07-02', 'mobile', 100),
    (3, '2019-07-01', 'desktop', 100),
    (3, '2019-07-02', 'desktop', 100);


/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

SELECT *
FROM spending;

with
    combined_data_Cte
    AS
    (
                    SELECT
                spend_date
, user_id
, MAX(platform) as platform
, SUM(amount) as total
            FROM spending
            GROUP BY spend_date, user_id
            HAVING COUNT(distinct platform) = 1

        UNION ALL

            SELECT
                spend_date
, user_id
, 'both' as platform
, SUM(amount) as total
            FROM spending
            GROUP BY spend_date, user_id
            HAVING COUNT(distinct platform) = 2

    )

SELECT
    spend_date
, user_id
, MAX(platform) as platform
, SUM(total) as total_sum
, COUNT(distinct user_id) as total_users
from
    combined_data_Cte
GROUP BY spend_date, user_id
ORDER BY spend_date

;


----------------------------------------------------------------

with
    spend_cte
    as
    (
        select *, 
        COUNT(platform) OVER(partition by spend_date, user_id order by user_id) as cnt
        , CASE WHEN COUNT(platform) OVER(partition by spend_date, user_id order by user_id)=2 THEN 'both' ELSE platform END as platform_new
        from spending
    )


select 
user_id
, spend_date
, platform_new
, SUM(amount) as total_amt
, COUNT(DISTINCT(user_id)) as total_users

from spend_cte
group by user_id, spend_date, platform_new

;