
-- ================================================================================================
-- https://www.youtube.com/watch?v=FZ0GCcnIIWA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=2
-- ================================================================================================

WITH cte AS (
    SELECT 
        l.create_date AS cd, 
        l.resolved_date AS rd, 
        COUNT(r.holiday_date) AS t_h,
        DATEDIFF(day, l.create_date, l.resolved_date) 
        - (DATEDIFF(week, l.create_date, l.resolved_date) * 2) 
        - COUNT(r.holiday_date) AS business_Days 
    FROM 
        tickets l
    LEFT JOIN 
        holidays r
    ON 
        r.holiday_date BETWEEN l.create_date AND l.resolved_date
    GROUP BY 
        l.create_date, l.resolved_date
)
SELECT 
    cd,
    rd,
    t_h,
    business_Days,
    business_Days + t_h AS total_days
FROM 
    cte;


