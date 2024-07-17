use tips_db;
create table company_users
(
    company_id int,
    user_id int,
    language varchar(20)
);

insert into company_users
values
    (1, 1, 'English')
,
    (1, 1, 'German')
,
    (1, 2, 'English')
,
    (1, 3, 'German')
,
    (1, 3, 'English')
,
    (1, 4, 'English')
,
    (2, 5, 'English')
,
    (2, 5, 'German')
,
    (2, 5, 'Spanish')
,
    (2, 6, 'German')
,
    (2, 6, 'Spanish')
,
    (2, 7, 'English')

    ;

with cte as (
SELECT 
company_id
, user_id
FROM
company_users
WHERE [language] IN ('German', 'English')
GROUP BY company_id, user_id
HAVING COUNT(distinct [language]) = 2
-- ORDER BY company_id, [user_id]
)
SELECT 
company_id
from cte
GROUP BY company_id
HAVING COUNT(*) >=2
;

