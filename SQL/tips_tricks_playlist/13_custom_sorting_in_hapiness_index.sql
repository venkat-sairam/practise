

use tips_db;


with happiness_index_cte AS
(
select * from (
values
    (1, 'Finland', 7.842, 7.809, 5554960),
    (2, 'Denmark', 7.62, 7.646, 5834950),
    (3, 'Switzerland', 7.571, 7.56, 8773637),
    (4, 'Iceland', 7.554, 7.504, 345393),
    (5, 'Netherlands', 7.464, 7.449, 17211447),
    (6, 'Norway', 7.392, 7.488, 5511370),
    (7, 'Sweden', 7.363, 7.353, 10218971),
    (8, 'Luxembourg', 7.324, 7.238, 642371),
    (9, 'New Zealand', 7.277, 7.3, 4898203),
    (10, 'Austria', 7.268, 7.294, 9066710),
    (130, 'India', 5.268, 5.294, 9066710
)
) AS happiness_index
(rank, country, Happiness_2021, Happiness_2020, Population_2022)
)
SELECT * from happiness_index_cte  
order by  
    case when country = 'India' then 1 else 0 end DESC,
    Happiness_2021 DESC
