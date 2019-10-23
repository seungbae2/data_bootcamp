DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

CREATE TABLE departments(
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender VARCHAR(10) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_manager(
	id SERIAL PRIMARY KEY NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp(
	id SERIAL PRIMARY KEY NOT NULL,
	emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE titles(
	id SERIAL PRIMARY KEY NOT NULL,
	emp_no INT NOT NULL,
	title VARCHAR(50) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries(
	id SERIAL PRIMARY KEY NOT NULL,
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

COPY departments(dept_no, dept_name)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/departments.csv' DELIMITER ',' CSV HEADER;

COPY employees(emp_no, birth_date, first_name, last_name, gender, hire_date)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/employees.csv' DELIMITER ',' CSV HEADER;

COPY dept_manager(dept_no, emp_no, from_date, to_date)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/dept_manager.csv' DELIMITER ',' CSV HEADER;

COPY dept_emp(emp_no, dept_no, from_date, to_date)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/dept_emp.csv' DELIMITER ',' CSV HEADER;

COPY titles(emp_no, title, from_date, to_date)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/titles.csv' DELIMITER ',' CSV HEADER;

COPY salaries(emp_no, salary, from_date, to_date)
FROM '/Users/sb/Bootcamp/Homework/EmployeeSql/data/salaries.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM dept_manager;

SELECT * FROM dept_emp;

SELECT * FROM titles;

SELECT * FROM salaries;


