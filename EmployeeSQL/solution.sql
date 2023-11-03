-- Data Analysis

-- List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, cast(salaries.salary as money)
from employees join salaries 
on employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where extract(year from hire_date) = 1986
order by 3

-- List the manager of each department along with their department number, department name, employee number, 
-- last name, and first name.
select employees.last_name, employees.first_name, employees.emp_no, dept_manager.dept_no, departments.dept_name
from dept_manager join employees
on dept_manager.emp_no = employees.emp_no
join departments 
on dept_manager.dept_no = departments.dept_no
order by 1;

-- List the department number for each employee along with that employee’s employee number, last name, 
-- first name, and department name.
with base_table as (select employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
from dept_emp join employees 
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
order by 1)
select emp_no, last_name, first_name, ARRAY_TO_STRING(array_agg(dept_no), ', ') as "department number", 
ARRAY_TO_STRING(array_agg(dept_name), ', ') as "department name"
from base_table
group by emp_no, last_name, first_name;

-- List first name, last name, and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B.
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%' 

-- List each employee in the Sales department, including their employee number, last name, and first name.
select employees.emp_no, employees.last_name, employees.first_name
from employees where employees.emp_no in (select emp_no from dept_emp where dept_no = 'd007');

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
with base_table as (select employees.emp_no, employees.last_name, employees.first_name
from employees where employees.emp_no in (select emp_no from dept_emp where dept_no = 'd007' or dept_no = 'd005'))
select base_table.emp_no, base_table.last_name, base_table.first_name, dept_emp.dept_no
from base_table 
join dept_emp 
on base_table.emp_no = dept_emp.emp_no
where dept_emp.dept_no = 'd007' or dept_emp.dept_no = 'd005'





