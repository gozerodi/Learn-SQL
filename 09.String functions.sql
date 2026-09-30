# String functions

SELECT first_name,
LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;

SELECT first_name, 
UPPER(first_name)
FROM employee_demographics
;

SELECT first_name,
LEFT(first_name,4),
RIGHT(first_name,4),
SUBSTRING(first_name,1,4),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics
;

SELECT first_name,
REPLACE(first_name, "a","z")
FROM employee_demographics
;

SELECT first_name,
LOCATE("an",first_name)
FROM employee_demographics
;

#CONCAT
SELECT first_name,
last_name,
CONCAT(first_name," ", last_name) AS full_name
FROM employee_demographics;






