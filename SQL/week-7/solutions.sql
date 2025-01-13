
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

-- 1- write a query to produce below output from icc_world_cup table.
--team_name, no_of_matches_played , no_of_wins , no_of_losses

with combined_teams as(
select Team_1 as team_name, Winner as winning_team_name from icc_world_cup
union  all
select Team_2 as team_name, Winner as winning_team_name from icc_world_cup
)

select
team_name
, COUNT(1) as no_of_matches_played
, SUM(CASE WHEN team_name = winning_team_name THEN 1 ELSE 0 END) AS no_of_wins
, COUNT(1) - SUM(CASE WHEN team_name = winning_team_name THEN 1 ELSE 0 END) AS no_of_losses
from combined_teams 
group by team_name
;

-- 2- write a query to print first name and last name of a customer using orders table
--(everything after first space can be considered as last name)
-- customer_name, first_name,last_name

select
customer_name as full_name
, LEFT(customer_name,CHARINDEX(' ', customer_name) ) as first_name
, SUBSTRING(customer_name, CHARINDEX(' ', customer_name) +1 , len(customer_name)) as last_name

from 
orders
;

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


-- 3- write a query to print below output using drivers table.
--Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0

with profit_rides_cte as
(
select
* 
, LEAD(start_loc, 1) OVER(partition by id  order by start_loc) as next_ride_loc
, CASE WHEN end_loc =LEAD(start_loc, 1) OVER(partition by id  order by start_time) then 1 else 0 END as profit_rides
from drivers
)

select
id
, count(1) as total_rides
, sum(profit_rides) as profit_rides
from profit_rides_cte
group by id
;


-- 4- write a query to print customer name and no of occurence of character 'n' in the customer name.
-- customer_name , count_of_occurence_of_n

select
customer_name
, len(customer_name) - len(replace(lower(customer_name), 'n', '')) as count_of_occurence_of_n
from 
orders
;


-- 5-write a query to print below output from orders data. example output

hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 

select
'category' as category_name
, category
, sum(case when region = 'West' then sales else 0 end ) as total_sales_west
,sum(case when region='East' then sales end) as total_sales_in_east_region
from 
orders
group by category

union all

select 
'sub_category'
, sub_category
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from 
orders
group by sub_category

union all
select
'ship_mode'
,ship_mode
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region

from 
orders
group by ship_mode
;


-- 6- the first 2 characters of order_id represents the country of order placed .
--write a query to print total no of orders placed in each country
-- (an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

select

left(order_id, 2) as country_code
, COUNT(DISTINCT order_id) as order_count
from 
orders
--order by order_id, country_code
group by left(order_id, 2)
;



