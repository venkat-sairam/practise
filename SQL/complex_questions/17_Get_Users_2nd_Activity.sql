use tips_db;
create table UserActivity
(
    username varchar(20) ,
    activity varchar(20),
    startDate Date   ,
    endDate Date
);

insert into UserActivity
values
    ('Alice', 'Travel', '2020-02-12', '2020-02-20')
,
    ('Alice', 'Dancing', '2020-02-21', '2020-02-23')
,
    ('Alice', 'Travel', '2020-02-24', '2020-02-28')
,
    ('Bob', 'Travel', '2020-02-11', '2020-02-18');
;

with
    cte
    AS
    (
        SELECT 
            *
            , ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate) as rn 
            , COUNT(*) OVER(partition by username) as count_
        FROM UserActivity
    )
SELECT
    *
FROM cte
WHERE count_ = 1 OR rn = 2

----------------------------------------------------------------
-- Approach - 2: 
----------------------------------------------------------------
with cte AS
(
        SELECT *
        , ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate) as rn 
        , COUNT(*) OVER(partition by username) as count_
        FROM UserActivity
)
SELECT
    username 
    , MIN(case when (count_ > 1 and rn = 2 ) or (count_ = 1)then startDate end  ) as startDate
    , MIN( case when (count_> 1 and rn = 2) or (count_ = 1) then endDate end ) as endDate
    , MIN(CASE WHEN (count_>1 and rn = 2) or (count_ = 1) then activity end ) as activity
    
FROM cte
GROUP BY username
;


