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


-- set the primary key  I'm using a composite primary key 
-- employees may switch departments
ALTER TABLE dept_emp
ADD PRIMARY KEY (emp_no,dept_no);

--create dept_manager table
--- duplicate managers - used a composite primary key
CREATE TABLE dept_manager (
dept_no VARCHAR(30) NOT NULL,
emp_no INT NOT NULL,
PRIMARY KEY (dept_no,emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


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

SELECT first_name, last_name, hire_date FROM employees
where hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
order by hire_date;

--managers

SELECT dm.dept_no, 
dm.emp_no, 
ds.dept_name, 
ee.last_name, 
ee.first_name
from dept_manager AS dm
INNER JOIN departments AS ds
  ON (dm.dept_no = ds.dept_no)
INNER JOIN employees AS ee
  ON (dm.emp_no = ee.emp_no);

-- dept employee info

SELECT 
de.dept_no,
ee.emp_no,
ee.last_name,
ee.first_name,
ds.dept_name
FROM employees AS ee
INNER JOIN dept_emp AS de
ON ee.emp_no = de.emp_no
INNER JOIN departments AS ds
ON de.dept_no = ds.dept_no
ORDER BY ds.dept_name;

--Find information on all employees named Hercules B.

SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

--Sales department employees

SELECT 
de.dept_no,
ee.emp_no,
ee.last_name,
ee.first_name,
ds.dept_name
FROM employees AS ee
INNER JOIN dept_emp AS de
ON ee.emp_no = de.emp_no
INNER JOIN departments AS ds
ON de.dept_no = ds.dept_no
WHERE ds.dept_name = 'Sales'
ORDER BY ee.emp_no;


--Sales and Development

SELECT 
de.dept_no,
ee.emp_no,
ee.last_name,
ee.first_name,
ds.dept_name
FROM employees AS ee
INNER JOIN dept_emp AS de
ON ee.emp_no = de.emp_no
INNER JOIN departments AS ds
ON de.dept_no = ds.dept_no
WHERE ds.dept_name IN ('Sales', 'Development')
ORDER BY ds.dept_name;


-- determine the last name frequency
SELECT last_name, 
COUNT(*) AS frequency
FROM employees
GROUP BY last_name
-- descending order
order by frequency DESC;

