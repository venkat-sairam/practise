
-- change odd ids to even and even ids to odd
-- if the table has odd number of ids, then leave the last id as is

CREATE TABLE seats (
    id INT,
    student VARCHAR(10)
);

INSERT INTO seats VALUES 
(1, 'Amit'),
(2, 'Deepa'),
(3, 'Rohit'),
(4, 'Anjali'),
(5, 'Neha'),
(6, 'Sanjay'),
(7, 'Priya');

-- works only for sequential ids. 1, 2, 3, 4, ......

select 
*
, case 
	when id = (select  MAX(id) from seats) and id % 2 = 1 then id
	when id %2 = 0 then id-1
    else id + 1 end as new_id
from seats
;

-- using lead/lag functions.
select 
*
, case 
	when id %2 = 0 then lag(id, 1) over(order by id)
    else  lead(id, 1, id) over(order by id)
    end as new_id
from seats
;

