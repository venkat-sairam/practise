
-- --------------------------------
--Table creation Details:
-- --------------------------------

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

-- --------------------------------
-- Expected Output
-- --------------------------------
-- room_type         count

-- private room	        3
-- entire home	        2
-- shared room	        2

-- ----------------------------------------------------
-- Query to find the most frequently searched room types
-- ----------------------------------------------------

SELECT 
 
     value AS room_type
	 , count(*) as count
FROM 
    airbnb_searches
    CROSS APPLY STRING_SPLIT(filter_room_types, ',')
	group by value
	order by count desc, room_type
	;
