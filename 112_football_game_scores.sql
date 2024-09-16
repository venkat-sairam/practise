use db;


CREATE TABLE team1
(
    id VARCHAR(10) PRIMARY KEY,
    teamname VARCHAR(50),
    coach VARCHAR(50)
);



CREATE TABLE game1
(
    id INT PRIMARY KEY,
    mdate DATE,
    stadium VARCHAR(50),
    team1 VARCHAR(10),
    team2 VARCHAR(10),
    
);

CREATE TABLE goal1
(
    matchid INT,
    teamid VARCHAR(10),
    player VARCHAR(10),
    goal_time INT,
);

-- Insert into 'team' table
INSERT INTO team1
    (id, teamname, coach)
VALUES
    ('A', 'Team A', 'Coach A'),
    ('B', 'Team B', 'Coach B'),
    ('C', 'Team C', 'Coach C'),
    ('D', 'Team D', 'Coach D');

-- Insert into 'game' table
INSERT INTO game1
    (id, mdate, stadium, team1, team2)
VALUES
    (101, '2019-01-04', 'stadium 1', 'A', 'B'),
    (102, '2019-01-04', 'stadium 3', 'D', 'E'),
    (103, '2019-01-10', 'stadium 1', 'A', 'C'),
    (104, '2019-01-13', 'stadium 2', 'B', 'E');

-- Insert into 'goal' table
INSERT INTO goal1
    (matchid, teamid, player, goal_time)
VALUES
    (101, 'A', 'A1', 17),
    (101, 'A', 'A9', 58),
    (101, 'B', 'B7', 89),
    (102, 'D', 'D10', 63);

    select * from team1;
    SELECT * from game1;
    SELECT * FROM goal1;


SELECT 

 mdate
, team1
, team2
, sum(case when team1 = teamid then 1 else 0 end ) as team1_win_Count
, SUM(case when team2 = teamid then 1 else 0 end ) as team2_win_count
 from 
game1 LEFT JOIN goal1
on game1.id = goal1.matchid
GROUP by mdate, team1, team2

    