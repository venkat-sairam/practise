
USE tips_db;

CREATE TABLE STORES
(
    Store varchar(10),
    Quarter varchar(10),
    Amount int
);

INSERT INTO STORES
    (Store, Quarter, Amount)
VALUES
    ('S1', 'Q1', 200),
    ('S1', 'Q2', 300),
    ('S1', 'Q4', 400),
    ('S2', 'Q1', 500),
    ('S2', 'Q3', 600),
    ('S2', 'Q4', 700),
    ('S3', 'Q1', 800),
    ('S3', 'Q2', 750),
    ('S3', 'Q3', 900);
;

SELECT 
*
FROM STORES;

----------------------------------------------------------------
-- Find out the missing Quarter in Each Store
----------------------------------------------------------------



with cte AS
(
SELECT
    *,
    LEFT([Quarter], 1) AS FirstLetter,
    RIGHT([Quarter], 1) AS NumericPart,
    10- sum(CAST(RIGHT([Quarter], 1) AS INT)) OVER(partition by store) as missing_quarter
FROM STORES
)
SELECT 
Store, CONCAT('Q',missing_quarter) as missing_quarter
FROM cte
GROUP BY missing_quarter, Store
ORDER by Store
;
