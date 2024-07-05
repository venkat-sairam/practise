use db;

CREATE TABLE flights
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights
    (cid, fid, origin, Destination)
VALUES
    ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights
    (cid, fid, origin, Destination)
VALUES
    ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights
    (cid, fid, origin, Destination)
VALUES
    ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights
    (cid, fid, origin, Destination)
VALUES
    ('2', 'f4', 'Agra', 'Kol');

;

----------------------------------------------------------------
-- Problem-1: Find the source and destination
----------------------------------------------------------------

SELECT 
l.cid
, l.origin
, r.Destination
 from 
flights l INNER JOIN flights r
on l.cid = r.cid AND 
l.destination = r.origin

;

----------------------------------------------------------------
--
---------

CREATE TABLE sales
(
    order_date date,
    customer VARCHAR(512),
    qty INT
);

INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-01-01', 'C1', '20');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-01-01', 'C2', '30');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-02-01', 'C1', '10');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-02-01', 'C3', '15');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-03-01', 'C5', '19');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-03-01', 'C4', '10');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-04-01', 'C3', '13');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-04-01', 'C5', '15');
INSERT INTO sales
    (order_date, customer, qty)
VALUES
    ('2021-04-01', 'C6', '10');

SELECT 
order_date , COUNT(*) as new_customer_count
 from(
SELECT *
, ROW_NUMBER() OVER(partition by customer ORDER by order_date ) as rn
 from sales
) A
WHERE rn = 1
GROUP BY order_date