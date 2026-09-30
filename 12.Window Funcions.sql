#Window Functions

SELECT dem.first_name,
dem.last_name,
gender,
AVG(salary) OVER(PARTITION BY gender),
SUM(salary) OVER(PARTITION BY gender),
salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
;

SELECT 
dem.employee_id,
dem.first_name,
dem.last_name,
gender,
salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) as row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_rum, # same salary = same num
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num # not skipping number when same salary gettin same number
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
;
