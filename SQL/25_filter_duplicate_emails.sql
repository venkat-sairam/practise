
use tips_db;

CREATE TABLE employees
(
    employee_id int,
    employee_name varchar(15),
    email_id varchar(15)
);
delete from employees;
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('101', 'Liam Alton', 'li.al@abc.com');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('102', 'Josh Day', 'jo.da@abc.com');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('103', 'Sean Mann', 'se.ma@abc.com');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('104', 'Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('105', 'Toby Scott', 'jo.da@abc.com');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('106', 'Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees
    (employee_id,employee_name, email_id)
VALUES
    ('107', 'Ankit Bansal', 'AN.BA@ABC.COM');

ALTER TABLE employees
ALTER COLUMN email_id VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS;

SELECT 
* FROM 
employees
;

----------------------------------------------------------------
--Approach-1 Using SubQuery
----------------------------------------------------------------

SELECT *
FROM
employees where email_id IN (SELECT
email_id
FROM 
employees
GROUP BY email_id having count(*) > 1 )
;

----------------------------------------------------------------
-- Approach:2 - Using CTE
----------------------------------------------------------------

WITH CTE AS
(
    SELECT
        *,
        CASE 
            WHEN COUNT(*) OVER (PARTITION BY email_id) > 1 THEN 0 ELSE 1 
        END AS IsDuplicate
        FROM
            Employees
)

SELECT employee_id, employee_name, email_id
FROM CTE
where isDuplicate = 0
ORDER BY employee_id