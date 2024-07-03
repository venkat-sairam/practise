

use db;
create table input
(
    id int,
    formula varchar(10),
    value int
)
insert into input
values
    (1, '1+4', 10),
    (2, '2+1', 5),
    (3, '3-2', 40),
    (4, '4-1', 20);

SELECT *
FROM input;


with
    cte
    AS
    (
        SELECT
            l.id as lid
            , SUBSTRING(l.formula, 2, 1) as op
            , r.id  as rid
            , r.[value] as rvalue
        from input l
            INNER JOIN [input]  r
            ON l.id = r.id AND
                (SUBSTRING (l.formula, 1, 1) = r.id )
                OR
                (SUBSTRING (l.formula, 3, 1)  = r.id)
    )
SELECT
    lid
    , op
    , case when op = '+' then MAX(rvalue) + MIN(rvalue)
        when op = '-' then MAX(rvalue) - MIN(rvalue)
    end
FROM cte
GROUP by lid, op
;


----------------------------------------------------------------
-- Approach:2
----------------------------------------------------------------
with cte AS
(
SELECT 
    ip.id
    , ip.formula
    , ip.[value]
    , LEFT(ip.formula, 1) as d1
    , RIGHT(ip.formula, 1) as d2
    , SUBSTRING(ip.formula, 2, 1) as op
from [input] ip
)
SELECT
ip.id
, ip.[value]
,ip.op
, ip.formula
, ip2.[value] as d1
, ip3.[value] as d2
, CASE when ip.op = '+' then ip2.value + ip3.value
 else ip2.value - ip3.value 
 END

 from cte as ip
INNER JOIN [input] ip2
on ip.d1 = ip2.id
INNER JOIN [input] ip3
on ip.d2 = ip3.id

;



