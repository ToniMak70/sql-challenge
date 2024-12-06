-- List the employee number, last name, first name, sex, and salary of each employee
CREATE VIEW query1 AS
SELECT e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
FROM EMPLOYEES as e
INNER JOIN SALARIES as s ON
e.emp_no = s.emp_no;

SELECT * FROM query1;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
CREATE VIEW query2 AS
SELECT e.first_name,
	e.last_name,
	e.hire_date
FROM EMPLOYEES as e
WHERE hire_date BETWEEN '1985-12-31' AND '1987-01-01';

SELECT * FROM query2;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
CREATE VIEW query3 AS
SELECT dm.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
FROM DEPT_MANAGER as dm
INNER JOIN DEPARTMENTS as d ON 
dm.dept_no = d.dept_no
INNER JOIN EMPLOYEES as e ON
dm.emp_no = e.emp_no;

SELECT * FROM query3;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
CREATE VIEW query4 AS
SELECT de.dept_no,
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM EMPLOYEES as e
INNER JOIN DEPT_EMP as de ON
e.emp_no = de.emp_no
INNER JOIN DEPARTMENTS as d ON
de.dept_no = d.dept_no;

SELECT * FROM query4;

-- List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
CREATE VIEW query5 AS
SELECT e.first_name,
	e.last_name,
	e.sex
FROM EMPLOYEES as e
WHERE first_name IN ('Hercules') AND last_name LIKE 'B%';

SELECT * FROM query5;

-- List each employee in the Sales department, including their employee number, last name, and first name.
CREATE VIEW query6 AS
SELECT emp_no,
	last_name,
	first_name
FROM EMPLOYEES
WHERE emp_no IN
(
	SELECT emp_no
	FROM DEPT_EMP
	WHERE dept_no IN
	(
		SELECT dept_no
		FROM DEPARTMENTS
		WHERE dept_name IN ('Sales')
	)
);
SELECT * FROM query6;

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW q AS
SELECT dept_no,
	emp_no
FROM DEPT_EMP
WHERE dept_no IN
(
	SELECT dept_no
	FROM DEPARTMENTS
	WHERE dept_name IN ('Sales', 'Development')
);

CREATE VIEW query7 AS
SELECT q.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM q AS q
INNER JOIN EMPLOYEES as e ON
q.emp_no = e.emp_no
INNER JOIN DEPARTMENTS as d ON
q.dept_no = d.dept_no;

SELECT * FROM query7;

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
CREATE VIEW query8 AS
SELECT last_name, COUNT(last_name) as "frequency count"
FROM EMPLOYEES
GROUP BY last_name
ORDER BY "frequency count" DESC;

SELECT * FROM query8;