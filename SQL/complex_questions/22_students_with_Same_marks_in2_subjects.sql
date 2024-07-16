use tips_db;

create table exams
(
    student_id int,
    subject varchar(20),
    marks int
);
delete from exams;
insert into exams
values
    (1, 'Chemistry', 91),
    (1, 'Physics', 91)
,
    (2, 'Chemistry', 80),
    (2, 'Physics', 90)
,
    (3, 'Chemistry', 80)
,
    (4, 'Chemistry', 71),
    (4, 'Physics', 54);

;

SELECT 
student_id, marks
FROM exams
GROUP by student_id, marks
HAVING COUNT(distinct subject ) = 2
;

