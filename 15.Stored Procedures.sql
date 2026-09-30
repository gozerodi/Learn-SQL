DELIMITER %%
DROP PROCEDURE IF EXISTS `Parks_and_Recreation`.`new_procedure`%%
/* Add or remove procedure IN/OUT/INOUT parameters as needed. */
CREATE PROCEDURE `Parks_and_Recreation`.`new_procedure`(IN arg1 INTEGER, OUT arg2 INTEGER)
SQL SECURITY DEFINER
NOT DETERMINISTIC
BEGIN
    /* Insert the procedure code here. */
    SELECT *
    FROM employee_salary
    WHERE salary>50000;
    SELECT *
    FROM employee_salary
    WHERE salary>10000;

END%%
DELIMITER ;

CALL `Parks_and_Recreation`.`new_procedure`(1, @arg2);
#SELECT @arg2;