#Case statement

SELECT first_name,
last_name,
age,
CASE
    WHEN age <=30 THEN "Young"
    WHEN age BETWEEN 31 AND 50 THEN "Old"
    WHEN age >= 50 THEN "On Death's Door"
END AS Age_bracker
FROM employee_demographics;

SELECT first_name,
last_name,
salary,
CASE
    WHEN salary < 50000 THEN salary * 1.05
    WHEN salary >= 50000 THEN salary * 1.07
END AS new_salary,
CASE    
    WHEN dept_id = 6 THEN salary * 0.10
END as bonus
FROM employee_salary;





