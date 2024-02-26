# sql-challenge

I used the Xpert Learning Assistant tool for a few of the steps in the project.

Most importantly, I learned how to filter by dates  -  I asked how to get all employees hired in 1986 and it told me to use this code

SELECT hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01';

I wasn't sure what the date formatting was like and this worked.

I also used it to figure out how to count the instances of last names of employees.

I learned from it about COUNT(*)

Code from the AI was

SELECT last_name, COUNT(*) as frequency
FROM your_table_name
GROUP BY last_name
ORDER BY frequency DESC;

I only had to put in the table name as 'employees'

