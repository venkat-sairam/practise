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


SELECT 
l.cid
, l.origin
, r.Destination
 from 
flights l INNER JOIN flights r
on l.cid = r.cid AND 
l.destination = r.origin

;