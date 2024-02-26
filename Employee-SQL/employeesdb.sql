-- create titles table
CREATE TABLE titles (
title_id VARCHAR(30) PRIMARY KEY NOT NULL,
title VARCHAR NOT NULL
);

-- create employees table next
CREATE TABLE employees (
emp_no INT PRIMARY KEY NOT NULL,
emp_title VARCHAR(30) NOT NULL,
birth_date DATE,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
sex VARCHAR (3),
hire_date DATE NOT NULL,
FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

--departments table created
CREATE TABLE departments (
dept_no VARCHAR(30) PRIMARY KEY NOT NULL,
dept_name VARCHAR(30) NOT NULL
);

--create dept_emp transitionary table
CREATE TABLE dept_emp (
emp_no INT NOT NULL,
dept_no VARCHAR(30) NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- first attempt to import failed - I removed the PRIMARY KEY coding
-- perhaps there are duplicates in the emp_no column?
-- set the primary key
ALTER TABLE dept_emp
ADD PRIMARY KEY (emp_no,dept_no);
-- emp_no 10010 is duplicated! perhaps there are others
-- I'm using a composite primary key - employees may switch departments

--create dept_manager table
CREATE TABLE dept_manager (
dept_no VARCHAR(30) NOT NULL,
emp_no INT NOT NULL,
PRIMARY KEY (dept_no,emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
--- duplicate managers - used a composite primary key

--create salaries table
CREATE TABLE salaries (
emp_no INT PRIMARY KEY NOT NULL,
salary INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
--imported data successfully to all tables

--Analysis
--list employee number, last name, first name, sex, and salary for each
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees INNER JOIN salaries ON salaries.emp_no = employees.emp_no;

--all employees hired in 1986
CREATE TABLE eightysix AS
SELECT first_name, last_name, hire_date FROM employees
where hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
order by hire_date;

--managers

--create a table with manager emp_nos, and names
CREATE TABLE mgr_names AS 
(SELECT emp_no, last_name, first_name FROM employees
where emp_no IN
(
Select emp_no FROM dept_manager));

--join with dept_manager to get department number
CREATE TABLE mgr_names2 AS
SELECT dept_manager.dept_no, dept_manager.emp_no, mgr_names.last_name, mgr_names.first_name
FROM dept_manager INNER JOIN mgr_names ON dept_manager.emp_no = mgr_names.emp_no;

--join with departments to get names of departments
CREATE TABLE mgr_details AS
SELECT mgr_names2.dept_no, departments.dept_name, mgr_names2.emp_no, mgr_names2.last_name, mgr_names2.first_name
FROM departments INNER JOIN mgr_names2 ON departments.dept_no = mgr_names2.dept_no;

SELECT * from mgr_details;


-- dept employee info

--first join dept_emp and emp_no
CREATE TABLE emp_names_dept AS
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name,employees.first_name
FROM dept_emp INNER JOIN employees ON dept_emp.emp_no = employees.emp_no;

--join in department names from departments
CREATE TABLE emp_by_dept_name AS
SELECT emp_names_dept.dept_no, emp_names_dept.emp_no, emp_names_dept.last_name, emp_names_dept.first_name, departments.dept_name
FROM emp_names_dept INNER JOIN departments ON emp_names_dept.dept_no = departments.dept_no
order by dept_no;

--Hercules B.
CREATE TABLE hercules AS
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

--Sales department employees
CREATE TABLE sales AS
SELECT * FROM emp_by_dept_name
WHERE dept_name = 'Sales'
order by last_name;

SELECT * from sales;

--Sales and Development
SELECT * FROM emp_by_dept_name
WHERE dept_name = 'Sales' OR dept_name = 'Development'
order by dept_name, last_name;

-- get frequency counts of last names
CREATE TABLE name_frequency AS
SELECT last_name, COUNT(*) AS frequency
-- COUNT(*) is used to count frequency of each last name
FROM employees
GROUP BY last_name
order by frequency DESC;
--DESC is for descending order - I got help from the Xpert Learning Assistant for this
