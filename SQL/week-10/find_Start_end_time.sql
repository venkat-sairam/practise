

WITH cte_end_logs AS 
(
    SELECT 
        t.phone_number,
        t.end_time,
        rank() OVER (PARTITION BY t.phone_number ORDER BY t.end_time) AS rnk
    FROM call_end_logs t
),
cte_start_logs AS
(
    SELECT 
        s.phone_number,
        s.start_time,
        rank() OVER (PARTITION BY s.phone_number ORDER BY s.start_time) AS rnk
    FROM call_start_logs s
)
SELECT 
    s.phone_number,
    s.start_time,
    t.end_time,
    DATEDIFF(minute, s.start_time, t.end_time) as duration_minutes
FROM 
    cte_start_logs s
JOIN 
    cte_end_logs t
ON 
    s.phone_number = t.phone_number
AND 
    s.rnk = t.rnk
ORDER BY 
    s.start_time;

