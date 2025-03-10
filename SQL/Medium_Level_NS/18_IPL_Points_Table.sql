
-----------------------------------------
-- Generate a points table from the given data.
-- Team name, total_win, total_lost
-----------------------------------------

create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');




with team_Cte as
(

	select match_no
	, Team_1 as team__name
	, Winner as win
	from icc_world_cup
	UNION ALL
	select match_no
	, Team_2 as team__name
	, Winner as win
	from icc_world_cup
	
)
select 
team__name
, COUNT(*) as total_points
, sum(case when team__name = win then 1 else 0  end) as winner_flag
, count(*) - sum(case when team__name = win then 1 else 0  end) as loser_flag
from team_Cte
group by team__name
