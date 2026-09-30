# Limit & ALiasing

SELECT * 
FROM employee_demographics
LIMIT 2,1
;

SELECT gender, AVG(age) AS avg_age 
FROM Employee_demographics
GROUP BY gender
HAVING avg_age > 40
;