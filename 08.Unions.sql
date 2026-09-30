# Unions

SELECT age,
gender
FROM employee_demographics
UNION #by default UNION DISTINCT which means only going to take unique values, UNION ALL for duplicates unique values for same selected columns 
SELECT first_name,
last_name 
FROM employee_salary;

SELECT first_name,
last_name,
" Old Man " AS label
FROM employee_demographics 
WHERE age > 40 AND gender = "Male"
UNION
SELECT first_name,
last_name,
" Old Lady" AS label
FROM employee_demographics
WHERE age > 40 AND gender = "Female"
UNION
SELECT first_name,
last_name,
"Highly Paid Employee" AS label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name
;

