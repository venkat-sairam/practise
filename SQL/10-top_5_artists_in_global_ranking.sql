use db;
CREATE TABLE artists
(
    artist_id INTEGER PRIMARY KEY,
    artist_name VARCHAR(100),
    label_owner VARCHAR(100)
);


CREATE TABLE songs
(
    song_id INTEGER PRIMARY KEY,
    artist_id INTEGER,
    name VARCHAR(100),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE global_song_rank
(
    day INTEGER,
    song_id INTEGER,
    rank INTEGER,
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);


INSERT INTO artists
    (artist_id, artist_name, label_owner)
VALUES
    (101, 'Ed Sheeran', 'Warner Music Group'),
    (120, 'Drake', 'Warner Music Group'),
    (125, 'Bad Bunny', 'Rimas Entertainment');


INSERT INTO songs
    (song_id, artist_id, name)
VALUES
    (55511, 101, 'Perfect'),
    (45202, 101, 'Shape of You'),
    (22222, 120, 'One Dance'),
    (19960, 120, 'Hotline Bling');


INSERT INTO global_song_rank
    (day, song_id, rank)
VALUES
    (1, 45202, 5),
    (3, 45202, 2),
    (1, 19960, 3),
    (9, 19960, 15);





with cte_frequency AS
(
        SELECT
            artist_id
  , COUNT(1) as freq
        FROM global_song_rank g inner JOIN songs s
            ON s.song_id = g.song_id
        WHERE rank <=10
        GROUP BY s.artist_id
), final_cte AS
(
    SELECT ar.artist_name as name
    ,dense_rank() OVER(ORDER BY freq DESC) drn
    from cte_frequency c inner JOIN artists ar
    on ar.artist_id = c.artist_id
)

SELECT
    name, drn as rank
from final_cte
where drn <=5
ORDER BY drn, name
;