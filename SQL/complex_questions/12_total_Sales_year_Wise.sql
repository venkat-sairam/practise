use tips_db;

create table sales
(
    product_id int,
    period_start date,
    period_end date,
    average_daily_sales int
);

insert into sales
values(1, '2019-01-25', '2019-02-28', 100),
    (2, '2018-12-01', '2020-01-01', 10),
    (3, '2019-12-01', '2020-01-31', 1);


SELECT
    *
FROM sales;


with
    rec_cte
    AS
    (
        SELECT MIN(period_start) as start_date, max(period_end) as end_date
        FROM sales

        UNION ALL

            SELECT
                DATEADD(DAY, 1, start_date) as start_date, end_date
            from rec_cte
            WHERE start_date <= end_date
    )

select
    sales.product_id
    ,YEAR(rec_cte.start_date) as year
    , SUM(sales.average_daily_sales) as amount
from rec_cte INNER JOIN sales on rec_cte.start_date BETWEEN sales.period_start and sales.period_end
GROUP BY sales.product_id, YEAR(rec_cte.start_date)
ORDER BY sales.product_id, YEAR(rec_cte.start_date)
OPTION(MAXRECURSION 2050)

;

