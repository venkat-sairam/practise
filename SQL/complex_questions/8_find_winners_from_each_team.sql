USE tips_db;


create table players
(
    player_id int,
    group_id int
)

insert into players
values
    (15, 1);
insert into players
values
    (25, 1);
insert into players
values
    (30, 1);
insert into players
values
    (45, 1);
insert into players
values
    (10, 2);
insert into players
values
    (35, 2);
insert into players
values
    (50, 2);
insert into players
values
    (20, 3);
insert into players
values
    (40, 3);

create table matches
(
    match_id int,
    first_player int,
    second_player int,
    first_score int,
    second_score int
)

insert into matches
values
    (1, 15, 45, 3, 0);
insert into matches
values
    (2, 30, 25, 1, 2);
insert into matches
values
    (3, 30, 15, 2, 0);
insert into matches
values
    (4, 40, 20, 5, 2);
insert into matches
values
    (5, 35, 50, 1, 1);


/*
    The winner in each group is the player who scored max total points
    within the group.
    In case of tie, the lowest player id wins.
*/

SELECT *
FROM matches;
SELECT *
from players;

with matches_cte as
(
    SELECT
        first_player as player_id,
        first_score as score
    FROM matches
    union all

    SELECT
        second_player
        , second_score
    FROM matches
),
max_points_by_player_cte  AS
(
    SELECT
        players.group_id
        , players.player_id    
        , score
        , MAX(matches_cte.score) OVER(partition by players.group_id) as max_score
    FROM matches_cte
        INNER JOIN players
        ON players.player_id = matches_cte.player_id
)
SELECT
    group_id
    , MIN(case when score = max_score then player_id end ) as winner
FROM max_points_by_player_cte
GROUP BY group_id



