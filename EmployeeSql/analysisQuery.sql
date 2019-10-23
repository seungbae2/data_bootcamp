--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no
ORDER BY e.emp_no ASC;

--list employees who were hired in 1986.
SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT 
	dm.dept_no, 
	d.dept_name, 
	dm.emp_no, 
	e.last_name, 
	e.first_name, 
	dm.from_date, 
	dm.to_date
FROM dept_manager dm
INNER JOIN departments d ON d.dept_no = dm.dept_no
INNER JOIN employees e ON e.emp_no = dm.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM dept_emp de
INNER JOIN departments d ON d.dept_no = de.dept_no
INNER JOIN employees e ON e.emp_no = de.emp_no
ORDER BY emp_no ASC;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM employees
WHERE
	first_name = 'Hercules' 
AND
	last_name LIKE 'B%'
;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM dept_emp de
INNER JOIN departments d ON d.dept_no = de.dept_no
INNER JOIN employees e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales'
ORDER BY emp_no ASC;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM dept_emp de
INNER JOIN departments d ON d.dept_no = de.dept_no
INNER JOIN employees e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY emp_no ASC;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(last_name) AS "Count of Last Name", last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
