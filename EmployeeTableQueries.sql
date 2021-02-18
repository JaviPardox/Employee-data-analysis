
DROP TABLE employee_details;

CREATE TABLE employee_details AS
	SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
	FROM employees
	INNER JOIN salaries ON employees.emp_no=salaries.emp_no
	ORDER BY emp_no ASC;

DROP TABLE employee_1986;

CREATE TABLE employee_1986 AS 
	SELECT employees.first_name, employees.last_name, employees.hire_date
	FROM employees
	WHERE hire_date >= '1986-01-01'::date AND hire_date <= '1986-12-31'::date;

