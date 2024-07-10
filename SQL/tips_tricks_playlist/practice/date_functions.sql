USE tips_db;
-- Specify the database name

-- Drop table if it already exists (optional, to avoid errors if re-running)
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

-- Create the Employees table
CREATE TABLE Employees
(
    Name VARCHAR(50),
    DateOfBirth DATETIME
);

-- Insert data into the Employees table
INSERT INTO Employees
VALUES
    ('Tom', '2018-11-19 10:36:46.520'),
    ('Sara', '2018-11-18 11:36:26.400'),
    ('Bob', '2017-12-22 10:40:10.300'),
    ('Alex', '2017-12-30 09:30:20.100'),
    -- Corrected time format
    ('Charlie', '2017-11-25 07:25:14.700'),
    -- Corrected time format
    ('David', '2017-10-09 08:26:14.800'),
    -- Corrected time format
    ('Elsa', '2017-10-09 09:40:18.900'),
    -- Corrected time format
    ('George', '2018-11-15 10:35:17.600'),
    ('Mike', '2018-11-16 09:14:17.600'),
    -- Corrected time format
    ('Nancy', '2018-11-17 11:16:18.600');  -- Corrected time format


-- Query to find employees born on October 9th, 2017
SELECT * from Employees
WHERE CONVERT(date, DateOfBirth) = '2017-10-09'
ORDER BY DateOfBirth
;

--All people who are born between 2 given dates
--(For example, all people born between Nov 1, 2017 and Dec 31, 2017)

SELECT * FROM Employees
WHERE DateOfBirth BETWEEN '2017-11-01' and '2017-12-31'

-- All people who are born on the same day and month excluding the year
-- (For example, 9th October)

with cte AS
(
SELECT 

  DATEPART(DAY, DateOfBirth) as DAY
, DATEPART(MONTH, DateOfBirth) as month
, *
, ROW_NUMBER() OVER (PARTITION BY DATEPART (DAY, DateOfBirth),  DATEPART (MONTH, DateOfBirth) ORDER BY DateOfBirth) as rn
 FROM Employees
)
SELECT * FROM 
cte WHERE rn 
