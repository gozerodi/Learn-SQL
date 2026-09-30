
SELECT * 
FROM Parks_and_Recreation.employee_demographics;

SELECT first_name,
last_name,
age,
(age + 10) * 10 + 10  

FROM Parks_and_Recreation.employee_demographics;

#pemdas (x+y) * z +,_,/ k

#DISTINCT select only unique values
SELECT DISTINCT gender

FROM Parks_and_Recreation.employee_demographics;

#groups name and gender so unique names listed
SELECT DISTINCT first_name,
gender

FROM Parks_and_Recreation.employee_demographics;




