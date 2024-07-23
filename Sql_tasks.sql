SELECT * FROM EMPLOYEES;
SELECT SALARY FROM EMPLOYEES;
SELECT DISTINCT job_name FROM EMPLOYEES;
SELECT emp_name,concat('$ ',round(salary*1.15)) as Salary FROM EMPLOYEES;
SELECT concat(emp_name, '    ' ,job_name) AS "Employee \& Job" FROM EMPLOYEES;
SELECT emp_id,emp_name,salary, DATE_FORMAT(hire_date,'%M %d,%Y') AS to_char FROM EMPLOYEES;
SELECT length(emp_name) FROM EMPLOYEES;
SELECT emp_id,salary,commission from EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE dep_id NOT IN (2001);
SELECT * FROM EMPLOYEES WHERE hire_date<'1991-01-01';
SELECT AVG(salary) FROM EMPLOYEES WHERE job_name="ANALYST";
SELECT * FROM EMPLOYEES WHERE emp_name="BLAZE";
SELECT * FROM EMPLOYEES WHERE (salary*1.25)>3000;
SELECT * FROM EMPLOYEES WHERE hire_date like '%-01-%';
SELECT emp_id,emp_name,hire_date,salary FROM EMPLOYEES WHERE hire_date<'1991-04-01';
SELECT emp_name,salary FROM EMPLOYEES WHERE (salary between 2101 AND 3100) AND emp_name="FRANK";
SELECT * FROM EMPLOYEES WHERE job_name NOT IN("PRESIDENT","MANAGER") ORDER BY salary;
SELECT MAX(SALARY) FROM EMPLOYEES;
SELECT job_name,AVG(salary),AVG(salary+commission) FROM EMPLOYEES GROUP BY job_name;
SELECT emp_id,emp_name,e.dep_id,dep_name,dep_location FROM EMPLOYEES e,DEPARTMENT d WHERE e.dep_id=d.dep_id AND d.dep_id IN(1001,2001);
SELECT manager_id,COUNT(manager_id) AS count FROM EMPLOYEES GROUP BY manager_id HAVING count>0 ORDER BY manager_id;
SELECT dep_id,COUNT(dep_id) FROM EMPLOYEES GROUP BY dep_id HAVING COUNT(*)>2;
SELECT * FROM EMPLOYEES WHERE emp_name LIKE '%AR%';
-- added workbench
SELECT * FROM EMPLOYEES WHERE job_name NOT IN("PRESIDENT","MANAGER");
SELECT DISTINCT job_name,
	CASE 
		WHEN job_name IN("PRESIDENT","MANAGER","ANALYST") THEN "Management-Level"
		WHEN job_name IN("CLERK","SALESMAN") THEN "Employee-level"
	END as Level
    FROM Employees;
/*UPDATE EMPLOYEES 
SET commission=650.00 
WHERE job_name="ANALYST";*/
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENT;
SELECT * FROM salary_grade;