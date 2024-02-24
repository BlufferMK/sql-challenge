-- create employees table first
CREATE TABLE employees (
emp_no INT NOT NULL,
emp_title VARCHAR(30) NOT NULL,
birth_date DATE,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
sex VARCHAR (3),
hire_date DATE NOT NULL
);

-- csv imported
SELECT * from employees;

--set primary key as emp_no
ALTER TABLE employees
ADD PRIMARY KEY (emp_no);

--departments table created
CREATE TABLE departments (
dept_no VARCHAR(30) PRIMARY KEY NOT NULL,
dept_name VARCHAR(30) NOT NULL
);
-- csv imported
SELECT * from departments;

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
-- success

SELECT * FROM dept_emp;
