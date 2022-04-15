--Deliverable 1
----Retirement Titles table (Birth date between January 1, 1952 and December 31, 1955).

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date

INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ;


--Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- retiring titles table

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--Deliverable 2
-- The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title

INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

--Additional queries
----Retiring soon table ( Birth date between January 1, 1962 and December 31, 1964).

SELECT DISTINCT ON (emp_no) e.emp_no, d.dept_name, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO retiring_soon
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
LEFT JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1962-01-01' AND '1964-12-31')
	AND (de.from_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no

SELECT COUNT(emp_no)"count", title
FROM retiting_soon
GROUP BY title
ORDER BY "count";

-- retirement table by department

SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.title, de.dept_no, de.to_date, d.dept_name
INTO dept_unique
FROM retirement_titles AS rt
     LEFT JOIN dept_emp AS de
        ON rt. emp_no = de. emp_no
     LEFT JOIN departments AS d
        ON de. dept_no = d. dept_no
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;


SELECT COUNT (emp_no) AS emp_count, dept_name
FROM dept_unique
GROUP BY dept_name
ORDER BY emp_count DESC;






