/*
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.

source: https://www.youtube.com/watch?v=4MLVfsQEGl0&list=PLBTZqjSKn0IfULLRo9Tm4lESxYMAG7fUQ&index=7
*/

with cte as
(
select 
spend_date
, user_id
, min(platform) as platform
, sum(amount) as total
from spending
group by spend_date, user_id having count( distinct platform) = 1

union all 

select 
spend_date
, user_id
, 'both' as platform
, sum(amount) as total
from spending
group by spend_date, user_id having count( distinct platform) = 2

union all
select 
distinct spend_date
, null as user_id
, 'both' as platform
, (0) as total
from spending
)
select 
spend_date
, platform 
, count(distinct user_id) as total_users
, sum(total) as total_spending
from 
cte
group by spend_date, platform
order by spend_date, platform
;



/*
What if there is no transaction record for both the platforms?  How to fix this usecase ?
-- my learning of the day.
*/
