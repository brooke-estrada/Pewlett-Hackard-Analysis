-- Deliverable 1: The Number of Retiring Employees by Title

-- Creating Retirement Title table
SELECT 
e.emp_no,
e.first_name,
e.last_name,
ts.title,
ts.from_date,
ts.to_date
INTO retirement_titles 
FROM employees as e
INNER JOIN titles as ts
ON (e.emp_no = ts.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Create unique_titles table for most recent title for retired employees
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create retiring_titles table with count
SELECT COUNT(emp_no),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program

SELECT DISTINCT ON(e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ts.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ts
ON (e.emp_no = ts.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;


-- Deliverable 3: A written report on the employee database analysis: below is additional analysis

-- 1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?

-- Total retiring 36,619
SELECT COUNT (emp_no)
FROM total_retiring;

-- Total by department

SELECT COUNT (emp_no),
dept_name
FROM total_retiring
GROUP BY dept_name
ORDER BY (COUNT(emp_no)) DESC;

-- Table for total retiring
SELECT ut.emp_no,
ut.first_name,
ut.last_name,
d.dept_name
INTO total_retiring
FROM unique_titles AS ut
INNER JOIN dept_info AS d
ON (ut.emp_no = d.emp_no)
ORDER BY dept_name;

-- 2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

-- The number of eligible mentors
SELECT COUNT (emp_no)
FROM mentorship_eligibility;

-- The nuber of eligible mentors by department
SELECT COUNT (emp_no),
dept_name
FROM mentors_dept
GROUP BY dept_name;

-- Create table to hold mentorship eligibility

SELECT  (me.emp_no),
d.dept_name
INTO mentors_dept
FROM mentorship_eligibility AS me
INNER JOIN dept_info AS di
ON (me.emp_no = di.emp_no);