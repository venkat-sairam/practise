USE db;

CREATE TABLE players_games
(
    player_name VARCHAR(50),
    game_date DATE,
    result CHAR(1)
);


INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Ganesh', '2024-01-01', 'W');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Prithvi', '2024-01-01', 'L');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Akshay', '2024-01-02', 'W');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Prithvi', '2024-01-02', 'W');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Shridhar', '2024-01-05', 'W');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Ganesh', '2024-01-06', 'W');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Akshay', '2024-01-06', 'L');
INSERT INTO players_games
    (player_name, game_date, result)
VALUES
    ('Prithvi', '2024-01-08', 'W');


with main_cte AS
(
SELECT *
, LAG(result) OVER(partition by player_name ORDER by game_date) AS prev_game_result
 FROM players_games
)
SELECT 
*

FROM main_cte
WHERE result = prev_game_result
 ;

