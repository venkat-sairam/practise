
use tips_db;

select GETDATE()

-- Retrieves the date from the given date.
SELECT DATEPART(DAY, GETDATE())


-- Retrieves the month from the given date
SELECT DATEPART(MONTH, GETDATE())

-- Retrieves the year from the given date
SELECT DATEPART(YEAR, GETDATE())

-- Retrieves the week from the given date
SELECT DATEPART(WEEK, GETDATE())

-- Retrieves the week day of the given date
-- Sunday - 1, Monday -2, Tuesday -3, Wednesday -4
SELECT DATEPART(WEEKDAY, GETDATE())

--  Retrieve the name of week day of the given date
-- 1-> Sunday 2-> Monday 3-> Tuesday 4-> Wednesday
SELECT DATENAME(WEEKDAY, GETDATE())

-- Add 1 day to the current date
SELECT DATEADD(DAY, 1, GETDATE())

-- Add 1 week to the current date
select DATEADD(WEEK, 1, GETDATE())

-- Add 1 month to the current date
select DATEADD(MONTH, 1, GETDATE())

-- Get previous date value
SELECT DATEADD(DAY, -1, GETDATE()) as prev_day_date

-- Get last weeks date from the current date
SELECT DATEADD(WEEK, -1, GETDATE()) as last_week_Date
-- Get last months date from the current date
select DATEADD(MONTH, -1, GETDATE()) as last_month_date

-- Get date difference between two dates
SELECT DATEDIFF(DAY,  DATEADD(DAY, -1, GETDATE()), GETDATE()) as date_diff

SELECT DATEDIFF(WEEK, DATEADD(WEEK, -1, GETDATE()), GETDATE())

