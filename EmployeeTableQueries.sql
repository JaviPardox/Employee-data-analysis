
-- This section is to create a table that holds information about the employees, leaving the managers out	
DROP TABLE employee_details;

-- Table that holds all the employees information, including managers
CREATE TABLE employee_details AS
	SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
	FROM employees
	INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	INNER JOIN salaries ON employees.emp_no = salaries.emp_no
	ORDER BY emp_no ASC;

-- Proceed to delete all the rows with matching employee's numbers between managers and employees in order to delete all the manager's rows.
DELETE 
FROM employee_details 
USING dept_manager 
WHERE employee_details.emp_no = dept_manager.emp_no;

---------------------------

-- This section is to find all employees, leaving all managers out, that are hired in 1986
DROP TABLE employee_1986;

-- Find all employees hired in the year 1986
CREATE TABLE employee_1986 AS 
	SELECT employees.first_name, employees.last_name, employees.hire_date, employees.emp_no
	FROM employees
	WHERE hire_date >= '1986-01-01'::date AND hire_date <= '1986-12-31'::date
	ORDER BY hire_date ASC;

-- Delete all managers from the list by comparing emp_no
DELETE 
FROM employee_1986 
USING dept_manager 
WHERE employee_1986.emp_no = dept_manager.emp_no;

-- Drop emp_no column because it's not needed
ALTER TABLE employee_1986
DROP COLUMN emp_no;

---------------------------

-- This section is to find all manager's information
DROP TABLE managers;	

-- Find all managers information and store it into a table
CREATE TABLE managers AS
	SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name  
	FROM employees
	INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
	INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
	ORDER BY emp_no ASC;

---------------------------

-- This section shows the employee's department information, plus first and last name
DROP TABLE employee_department;

-- Create table with all the information
CREATE TABLE employee_department AS
	SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM employees
	INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
	ORDER BY emp_no ASC;

-- Delete all managers from the list by comparing emp_no
DELETE 
FROM employee_department 
USING dept_manager 
WHERE employee_department.emp_no = dept_manager.emp_no;
	
---------------------------	

-- This section shows employees which are named Hercules and their last name starts with a B
DROP TABLE employees_Hercules;

-- Create table with employees called Hercules and with their last name staring with B
CREATE TABLE employees_Hercules AS
	SELECT employees.first_name, employees.last_name, employees.sex, employees.emp_no
	FROM employees
	WHERE first_name = 'Hercules' AND last_name ~ '^B';
	
-- Delete all managers from the list by comparing emp_no
DELETE 
FROM employee_department 
USING dept_manager 
WHERE employee_department.emp_no = dept_manager.emp_no;

-- Drop emp_no column because it's not needed
ALTER TABLE employees_Hercules
DROP COLUMN emp_no;
	
---------------------------

-- This section shows employees that are in the Sales department 
DROP TABLE employees_sales;

-- Create table with all the employees that are in the Sales department
CREATE TABLE employees_sales AS
	SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
	INNER JOIN employees ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments ON departments.dept_name = 'Sales' AND departments.dept_no = dept_emp.dept_no;

-- Delete all managers from the list by comparing emp_no
DELETE 
FROM employees_sales
USING dept_manager 
WHERE employees_sales.emp_no = dept_manager.emp_no;

---------------------------
	
SELECT * FROM employees_sales;
