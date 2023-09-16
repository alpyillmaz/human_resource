/* 1. Find the longest ongoing project for each department.
2. Find all employees who are not managers.
3. Find all employees who have been hired after the start of a project in their department.
4. Rank employees within each department based on their hire date (earliest hire gets the highest rank).
5. Find the duration between the hire date of each employee and the hire date of the next employee 
hired in the same department.*/

-- 1. Find the longest ongoing project for each department.

select d.name as DepartmentName,p.name,p.start_date,p.end_date,datediff(end_date,start_date) as LongestProject
from departments d inner join projects p on p.department_id=d.id;

select d.name as DepartmentName,p.name,p.start_date,p.end_date,timestampdiff(day,start_date,end_date) as LongestProject
from departments d inner join projects p on p.department_id=d.id;

-- 2. Find all employees who are not managers.

select name,job_title
from employees
where job_title not like "%manager%";

select name,job_title
from employees
where id not in (select manager_id from departments);

-- 3. Find all employees who have been hired after the start of a project in their department.

select e.name,e.hire_date,p.start_date
from employees e join projects p using(department_id)
where e.hire_date>p.start_date;

-- 4. Rank employees within each department based on their hire date (earliest hire gets the highest rank).

select *,rank () over (partition by department_id order by hire_date asc) as Rnk
from employees;


-- 5. Find the duration between the hire date of each employee and the hire date of the next employee 
--hired in the same department.*/
SELECT
    e1.employee_id AS EmployeeID,
    e1.hire_date AS HireDate,
    e1.department_id AS DepartmentID,
    e2.employee_id AS NextEmployeeID,
    e2.hire_date AS NextHireDate,
    DATEDIFF(e2.hire_date, e1.hire_date) AS DurationInDays
FROM
    employees e1
JOIN
    employees e2
ON
    e1.department_id = e2.department_id
    AND e1.hire_date < e2.hire_date

