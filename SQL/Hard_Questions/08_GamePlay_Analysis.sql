

create table activity (

 player_id     int     ,
 device_id     int     ,
 event_date    date    ,
 games_played  int
 );

 insert into activity values (1,2,'2016-03-01',5 ),(1,2,'2016-03-02',6 ),(2,3,'2017-06-25',1 )
 ,(3,1,'2016-03-02',0 ),(3,4,'2018-07-03',5 );

 select * from activity;

--questions:
--Game Play Analysis 

--q1: Write an SQL query that reports the first login date for each player
WITH CTE AS (
  SELECT 
  	player_id,
  	device_id,
  	event_date,
  	games_played, 
  	ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) as rn
  FROM activity
)
SELECT * FROM CTE WHERE rn = 1;
--q2: Write a SQL query that reports the device that is first logged in for each player
WITH CTE AS (
  SELECT 
  	player_id,
  	device_id,
  	event_date,
  	games_played, 
  	ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY device_id) as rn
  FROM activity
)
SELECT * FROM CTE WHERE rn = 1;
--q3: Write an SQL query that reports for each player and date, how many games played so far by the player. 
--That is, the total number of games played by the player until that date.
WITH CTE AS (
  SELECT 
  	player_id,
  	device_id,
  	event_date,
  	games_played, 
  	SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) as rn
  FROM activity
)
SELECT 
*

FROM CTE;
--q4: Write an SQL query that reports the fraction of players that logged in again  on the day after the day they first logged in, rounded to 2 decimal places
WITH CTE AS
(
  SELECT 
  player_id
  , MIN(event_date) as first_date
  FROM activity
  GROUP BY player_id
)
SELECT 
a.player_id
, AVG(DATEDIFF(DAY, c.first_date,a.event_date))
FROM activity a LEFT JOIN CTE c
ON a.player_id = c.player_id
WHERE DATEDIFF(DAY, c.first_date,a.event_date) = 1
GROUP BY a.player_id
