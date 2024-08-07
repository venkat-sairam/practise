
USE tips_db;

CREATE TABLE tickets
(
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);


INSERT INTO tickets
    (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);

with tickets_cte AS
(
select 
origin
, destination

, SUM(ticket_count) as ticket_count
from tickets
group by origin, destination
union all
SELECT

destination
, origin 
, sum(ticket_count)
from tickets
WHERE oneway_round='R'
group by origin, destination
)
select 
origin
, destination
, SUM(ticket_count) as ticket_count
 from tickets_cte
 group by origin, destination
 order by ticket_count desc
;
