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

