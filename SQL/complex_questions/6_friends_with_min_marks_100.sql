use tips_db;

drop table friend
Create table friend
(
    pid int,
    fid int
)
insert into friend
    (pid , fid )
values
    ('1', '2');
insert into friend
    (pid , fid )
values
    ('1', '3');
insert into friend
    (pid , fid )
values
    ('2', '1');
insert into friend
    (pid , fid )
values
    ('2', '3');
insert into friend
    (pid , fid )
values
    ('3', '5');
insert into friend
    (pid , fid )
values
    ('4', '2');
insert into friend
    (pid , fid )
values
    ('4', '3');
insert into friend
    (pid , fid )
values
    ('4', '5');
drop table person
create table person
(
    PersonID int,
    Name varchar(50),
    Score int
)
insert into person
    (PersonID,Name ,Score)
values('1', 'Alice', '88')
insert into person
    (PersonID,Name ,Score)
values('2', 'Bob', '11')
insert into person
    (PersonID,Name ,Score)
values('3', 'Devis', '27')
insert into person
    (PersonID,Name ,Score)
values('4', 'Tara', '45')
insert into person
    (PersonID,Name ,Score)
values('5', 'John', '63')
select *
from person
select *
from friend
;

-- Write a query to find the person id, name
-- number of friends, sum of marks of a person
-- who have friends with total score > 100.

----------------------------------------------------------------
-- Joining 3 tables
----------------------------------------------------------------

with
    cte
    AS
    (
        SELECT
            person.PersonID
            , person.Name
            , person.Score
            , p2.Score as friends_Score
            , SUM(p2.Score) OVER(partition BY person.PersonID) as friends_total_score
        FROM person inner JOIN friend
            on person.PersonID = friend.pid
            INNER JOIN person p2
            on p2.PersonID = friend.fid
    )

    SELECT 
    cte.PersonID
    , cte.Name
    , COUNT(*) as total_friends
    , SUM(friends_Score) as friends_total_score
    from cte 
    WHERE friends_total_score > 100
    GROUP BY cte.PersonID, cte.Name

;
