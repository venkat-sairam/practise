
use tips_db;

DECLARE @target_date DATE
DECLARE @n INT

set @target_date = '2024-07-08'
SET @n = 4

SELECT dateadd(week, @n-1, dateadd(day, (7 - DATEPART(WEEKDAY, @target_date)+1), @target_date))
