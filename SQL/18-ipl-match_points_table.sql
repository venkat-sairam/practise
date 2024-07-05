use db;

with cte as 
(

select 

team_1
, case when Team_1 = Winner then 1 else 0 end as win_flag
from icc_world_cup
union all
SELECT
team_2
, case when Team_2 = Winner then 1 else 0 end as team2_win_flag
from icc_world_cup

)
select 
Team_1, COUNT(*) as total_matches_played
, sum(win_flag) as matched_won
, COUNT(*) - SUM(win_flag) AS matches_lost
from cte
GRoup by Team_1
;
