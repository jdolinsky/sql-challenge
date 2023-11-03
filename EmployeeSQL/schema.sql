-- create tables;
CREATE TABLE IF NOT EXISTS public.titles
(
    title_id character varying(5) NOT NULL,
    title character varying NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE IF NOT EXISTS public.employees
(
    emp_no integer NOT NULL,
    emp_title_id character varying(5) NOT NULL,
    birth_date date NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    sex character(1) NOT NULL,
    hire_date date NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES public.titles(title_id),
	PRIMARY KEY (emp_no)
);

CREATE TABLE IF NOT EXISTS public.salaries
(
    emp_no integer NOT NULL,
    salary integer NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no),
	UNIQUE (emp_no)
);

CREATE TABLE IF NOT EXISTS public.departments
(
    dept_no character varying(4) NOT NULL,
    dept_name character varying(200) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE IF NOT EXISTS public.dept_manager
(
    dept_no character varying(4) NOT NULL,
    emp_no integer NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES public.departments (dept_no),	
	FOREIGN KEY (emp_no) REFERENCES public.employees (emp_no)
);

CREATE TABLE IF NOT EXISTS public.dept_emp
(
    emp_no integer NOT NULL,
    dept_no character varying(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES public.departments (dept_no),	
	FOREIGN KEY (emp_no) REFERENCES public.employees (emp_no)
);
