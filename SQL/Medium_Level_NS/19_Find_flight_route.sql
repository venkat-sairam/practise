
--------------------------------------------------------------------------
-- From the iternary, find the source and destination of each flight
--------------------------------------------------------------------------

CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');



select * from flights
order by cid, fid
;

with o_Cte
as
(
	select 
	cid
	, fid
	, origin as source
	, ROW_NUMBER() over(partition by cid order by fid) as o_rn
	from flights
)
, d_cte 
as
(
	select 
	cid
	, fid
	, Destination  as target
	, ROW_NUMBER() over(partition by cid order by fid desc) as d_rn
	from flights
)
select 
o.cid
, o.fid
, source
, target
from o_Cte o inner join d_cte d
on o.cid = d.cid and d_rn=1 and o_rn = 1
;


-----------------------------------------------
-- Find the new customers in every month
-----------------------------------------------



with customer_visit_cte as
(

	select 
	month(order_date) as month_number
	, customer
	, ROW_NUMBER() over(partition by customer order by order_date) as first_visited_rn
	from sales
	r
)
select 
month_number
, count(*) as new_customer_count
from customer_visit_cte
where first_visited_rn = 1
group by month_number
;



