use db;

with
    grouped_sales_cte
    AS
    (
        SELECT
            product_id AS product_id
            , SUM(sales)  as prod_wise_total_sales
        FROM orders
        GROUP BY product_id
    ),
    running_sum_sales_cte
    AS
    (
        SELECT
            product_id
            , prod_wise_total_sales
            , SUM(prod_wise_total_sales) OVER(order by prod_wise_total_sales DESC rows between unbounded preceding and current row) AS running_sum
            , 0.8 * SUM(prod_wise_total_sales) OVER() as _80_percent_sum
        FROM
            grouped_sales_cte
    ),
    final_cte
    as
    (
        select
            product_id
        , prod_wise_total_sales
        , running_sum
        , _80_percent_sum
        FROM running_sum_sales_cte
    )
    select * FROM final_cte
    WHERE running_sum <= _80_percent_sum
;


