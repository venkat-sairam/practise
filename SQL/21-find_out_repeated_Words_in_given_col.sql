

use db;

create table namaste_python
(
    file_name varchar(25),
    content varchar(200)
);

delete from namaste_python;
insert into namaste_python
values
    ('python bootcamp1.txt', 'python for data analytics 0 to hero bootcamp starting on Jan 6th')
,
    ('python bootcamp2.txt', 'classes will be held on weekends from 11am to 1 pm for 5-6 weeks')
,
    ('python bootcamp3.txt', 'use code NY2024 to get 33 percent off. You can register from namaste sql website. Link in pinned comment')

with count_words_frequency_cte AS
(
SELECT 
file_name
, [value]
, count(value) OVER(partition by value) as sum_count
 FROM namaste_python
CROSS APPLY string_split(content, ' ')

)
SELECT 
distinct [value], sum_count
 FROM count_words_frequency_cte
 WHERE sum_count > 1
ORDER by sum_count DESC


;

