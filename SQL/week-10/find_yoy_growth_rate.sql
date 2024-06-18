
-- The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.
SELECT 
EXTRACT(YEAR FROM transaction_date) as year
, product_id
, spend as curr_year_spend
, LAG(spend, 1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) as prev_year_spend
, ROUND(((spend - LAG(spend, 1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) ) / (LAG(spend, 1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))) )* (100), 2) AS yoy_rate
FROM user_transactions
;
