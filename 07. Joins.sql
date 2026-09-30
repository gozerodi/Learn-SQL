#JOINTS

#only gets same rows 
SELECT * 
FROM employee_demographics
INNER JOIN employee_salary
    ON employee_demographics.employee_id = employee_salary.employee_id
    #it is too long needs alising(AS) 
;

SELECT * 
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, #dem. id because it needs to know which id dem or sal ? 
age,
occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
;

#OUTER JOINS
#left join everything on the left table(demographics) and match with right TABLE
#right join everythng on the right table(salary (there is id 2 )) then match with the right table (nulls because there is no id 2 for dem table)  
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
;

# SELF JOIN
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_santa,
emp2.first_name AS first_name_santa,
emp2.last_name AS last_name_santa
FROM employee_salary emp1   
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id
;

#Joining multiple tables together

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
    ON sal.dept_id = pd.department_id #cant match dem because there is no same column with dem and pd
;    


