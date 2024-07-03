


create table Ameriprise_LLC
(
    teamID varchar(2),
    memberID varchar(10),
    Criteria1 varchar(1),
    Criteria2 varchar(1)
);
insert into Ameriprise_LLC
values
    ('T1', 'T1_mbr1', 'Y', 'Y'),
    ('T1', 'T1_mbr2', 'Y', 'Y'),
    ('T1', 'T1_mbr3', 'Y', 'Y'),
    ('T1', 'T1_mbr4', 'Y', 'Y'),
    ('T1', 'T1_mbr5', 'Y', 'N'),
    ('T2', 'T2_mbr1', 'Y', 'Y'),
    ('T2', 'T2_mbr2', 'Y', 'N'),
    ('T2', 'T2_mbr3', 'N', 'Y'),
    ('T2', 'T2_mbr4', 'N', 'N'),
    ('T2', 'T2_mbr5', 'N', 'N'),
    ('T3', 'T3_mbr1', 'Y', 'Y'),
    ('T3', 'T3_mbr2', 'Y', 'Y'),
    ('T3', 'T3_mbr3', 'N', 'Y'),
    ('T3', 'T3_mbr4', 'N', 'Y'),
    ('T3', 'T3_mbr5', 'Y', 'N');

SELECT *
FROM Ameriprise_LLC;

----------------------------------------------------------------
-- Approach:1 using Common Table Expressions (CTE) and JOINS
----------------------------------------------------------------

with
    cte
    AS
    (
        SELECT
            teamID
    , COUNT(*) as total_members

        FROM Ameriprise_LLC
        WHERE Criteria1='Y' and Criteria2='Y'
        GROUP BY teamID
        HAVING COUNT(*) > 1
    )
select
    a.*
, case when a.Criteria1 = a.Criteria2 AND qualified_team.total_members is not null then 'y' else 'N' end as is_team_Qualified
from
    Ameriprise_LLC a
    LEFT JOIN cte as qualified_team
    on qualified_team.teamID = a.teamID
;

----------------------------------------------------------------
-- Approach:2 using window function
----------------------------------------------------------------

SELECT
    * 
, case when Criteria1 = 'Y' and Criteria2 = 'Y' and SUM
(case when Criteria1= 'Y' and Criteria2 = 'Y' then 1 else 0
end) OVER
(PARTITION BY teamID) >1 then 'y' else 'N' end as is_team_Qualified
FROM Ameriprise_LLC
;
