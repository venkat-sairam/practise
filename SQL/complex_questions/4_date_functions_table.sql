
USE tips_db;

DROP
TABLE
IF EXISTS customer_orders;
create table customer_orders
(
    order_id integer,
    customer_id integer,
    order_date date,
    ship_date date
);

insert into customer_orders
values(1000, 1, cast('2022-01-05' as date), cast('2022-01-11' as date))
,
    (1001, 2, cast('2022-02-04' as date), cast('2022-02-16' as date))
,
    (1002, 3, cast('2022-01-01' as date), cast('2022-01-19' as date))
,
    (1003, 4, cast('2022-01-06' as date), cast('2022-01-30' as date))
,
    (1004, 1, cast('2022-02-07' as date), cast('2022-02-13' as date))
,
    (1005, 4, cast('2022-01-07' as date), cast('2022-01-31' as date))
,
    (1006, 3, cast('2022-02-08' as date), cast('2022-02-26' as date))
,
    (1007, 2, cast('2022-02-09' as date), cast('2022-02-21' as date))
,
    (1008, 4, cast('2022-02-10' as date), cast('2022-03-06' as date))
;

SELECT *
FROM customer_orders;

/*table 2*/

DROP TABLE IF EXISTS customer;
create table customer
(
    customer_id integer,
    customer_name VARCHAR(10),
    gender VARCHAR(1),
    dob date
);

insert into customer
values
    (1, 'Rahul', 'M', cast('2000-01-05' as date))
,
    (2, 'Shilpa', 'F', cast('2004-04-05' as date))
,
    (3, 'Ramesh', 'M', cast('2003-07-07' as date))
,
    (4, 'Katrina', 'F', cast('2005-02-05' as date))
,
    (5, 'Alia', 'F', cast('1992-01-01' as date))
;

SELECT *
FROM customer;

SELECT 
customer_id
, order_date
, ship_date
, DATEDIFF(day, order_date, ship_date) as days_to_ship
, DATEDIFF(WEEK, order_date, ship_date) as weeks_to_ship
, DATEDIFF
(day, order_date, ship_date) - 2 * DATEDIFF
(WEEK, order_date, ship_date) as business_Days
 from customer_orders;

