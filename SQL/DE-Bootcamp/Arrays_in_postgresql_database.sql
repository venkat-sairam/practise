-- Arrays in POSTGRESQL

-- This script creates a table with an array column.
-- The table is populated with data for countries and  colors.
-- Create a table with an array column
CREATE TABLE IF NOT EXISTS country_wise_colors (
    id SERIAL PRIMARY KEY,
    country_code VARCHAR(30),
    colors TEXT[]
);

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'country_wise_colors';


SELECT * FROM country_wise_colors;


-- Insert data into the table using the dictionary syntax

INSERT INTO country_wise_colors
VALUES(
80,'India','{"Orange", "white", "green"}'
)

-- Insert data into the table using the array constructor syntax
INSERT INTO country_wise_colors (country_code, colors) VALUES
('France', ARRAY['red', 'white', 'blue']),
('Germany', ARRAY['red', 'white', 'blue']),
('Italy', ARRAY['red', 'white', 'blue']),
('Spain', ARRAY['red', 'white', 'blue']),
('Portugal', ARRAY['red', 'white', 'blue']),
('Netherlands', ARRAY['red', 'white', 'blue']),
('Belgium', ARRAY['red', 'white', 'blue']),
('Luxembourg', ARRAY['red', 'white', 'blue']),
('Switzerland', ARRAY['red', 'white', 'blue']),
('Austria', ARRAY['red', 'white', 'blue']),
('Denmark', ARRAY['red', 'white', 'blue']),
('Sweden', ARRAY['red', 'white', 'blue']),
('Norway', ARRAY['red', 'white', 'blue']),
('Finland', ARRAY['red', 'white', 'blue']),
('Iceland', ARRAY['red', 'white', 'blue']),
('Ireland', ARRAY['red', 'white', 'blue']),
('Greece', ARRAY['red', 'white', 'blue']),
('Turkey', ARRAY['red', 'white', 'blue']),
('Russia', ARRAY['red', 'white', 'blue']),
('Canada', ARRAY['red', 'white', 'blue']),
('Mexico', ARRAY['red', 'white', 'green']),
('Brazil', ARRAY['green', 'yellow', 'blue']),
('Argentina', ARRAY['blue', 'white']),
('Chile', ARRAY['red', 'white', 'blue']),
('Australia', ARRAY['green', 'gold']),
('New Zealand', ARRAY['red', 'white', 'blue']),
('South Africa', ARRAY['black', 'green', 'gold']),
('India', ARRAY['orange', 'white', 'green']),
('China', ARRAY['red', 'yellow']),
('Japan', ARRAY['red', 'white']),
('South Korea', ARRAY['red', 'blue']),
('Indonesia', ARRAY['red', 'white']),
('Philippines', ARRAY['red', 'blue', 'white']),
('Vietnam', ARRAY['red', 'yellow']),
('Thailand', ARRAY['red', 'white', 'blue']),
('Malaysia', ARRAY['red', 'white', 'blue']),
('Singapore', ARRAY['red', 'white']),
('Cambodia', ARRAY['red', 'blue', 'white']),
('Myanmar', ARRAY['red', 'blue', 'white']),
('Laos', ARRAY['red', 'blue']),
('Brunei', ARRAY['red', 'yellow']),
('Timor-Leste', ARRAY['red', 'black', 'yellow']),
('Papua New Guinea', ARRAY['red', 'black', 'yellow']),
('Solomon Islands', ARRAY['blue', 'green', 'yellow']),
('Vanuatu', ARRAY['red', 'green', 'black', 'yellow']),
('Fiji', ARRAY['blue', 'white']),
('Tonga', ARRAY['red', 'white']),
('Samoa', ARRAY['red', 'blue', 'white']),
('Kiribati', ARRAY['red', 'blue', 'white']),
('Tuvalu', ARRAY['blue', 'yellow', 'white']),
('Nauru', ARRAY['blue', 'yellow', 'white']),
('Marshall Islands', ARRAY['blue', 'white']),
('Micronesia', ARRAY['blue', 'white']),
('Palau', ARRAY['blue', 'yellow']),
('Belize', ARRAY['red', 'blue', 'white']),
('Costa Rica', ARRAY['blue', 'white', 'red']),
('El Salvador', ARRAY['blue', 'white']),
('Guatemala', ARRAY['blue', 'white']),
('Honduras', ARRAY['blue', 'white']),
('Nicaragua', ARRAY['blue', 'white']),
('Panama', ARRAY['red', 'white', 'blue']),
('Cuba', ARRAY['red', 'white', 'blue']),
('Haiti', ARRAY['red', 'blue']),
('Dominican Republic', ARRAY['red', 'white', 'blue']),
('Jamaica', ARRAY['black', 'green', 'gold', 'yellow', 'red']),
('Trinidad and Tobago', ARRAY['red', 'black', 'white']),
('Barbados', ARRAY['blue', 'yellow', 'black', 'red']),
('Saint Lucia', ARRAY['blue', 'yellow', 'black', 'white']),
('Saint Vincent', ARRAY['blue', 'green', 'yellow', 'black', 'white']),
('Grenada', ARRAY['red', 'green', 'yellow', 'black', 'white']),
('Antigua', ARRAY['red', 'black', 'yellow']);

SELECT * FROM country_wise_colors;

-- Array index starts from 1 in PostgreSQL.
-- Access the first element of the colors array
select 
country_code,
colors[1]
from country_wise_colors;

-- Get the number of elements in the colors array
-- Return 0 if the array is empty.
-- otherwise return the number of elements in the array.
select
country_code
, cardinality(colors)
from country_wise_colors;


-- Explode the array into rows

select
country_code
, unnest(colors)
from country_wise_colors;

-- Array contains a specific element using contains operator
-- Check if the colors array contains the element 'red'
SELECT 
country_code
, colors
from country_wise_colors
where colors @> ARRAY['red'];

-- Check if the colors array contains the element 'red' and 'white'
SELECT 
country_code
, colors
from country_wise_colors
where colors @> '{"red", "white"}';


SELECT 
country_code
, colors
from country_wise_colors
where colors @> '{"red","white"}';


-- Update array values 

update country_wise_colors
set colors='{"Blue", "White","Red"}'
where id = 1;

-- remove a particular object from array

update country_wise_colors
set colors= array_remove(colors, '{"white"}')
where id = 1;
