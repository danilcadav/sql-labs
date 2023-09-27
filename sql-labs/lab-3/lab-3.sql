CREATE view salary_lists AS SELECT security_number,
surname||' '||name_and_patronymic fio,
salary*0.87 salary_87
FROM employee em
JOIN posts ps
ON em.curr_post = ps.post_name;SELECT *
FROM salary_lists;

UPDATE salary_lists SET fio = 'fio'
WHERE security_number = 1234;

create view employee_max_salary AS SELECT e.*,
p.salary
FROM employee e
JOIN posts p
ON e.curr_post = p.post_name
WHERE p.salary =
(SELECT max(p2.salary)
FROM employee e2
JOIN departments d2
ON e2.curr_department = d2.num
JOIN posts p2
ON e2.curr_post = p2.post_name
WHERE d2.num = e.curr_department
GROUP BY d2.num, d2.department_name );
SELECT *
FROM employee_max_salary;

update employee_max_salary set surname = 'sur'
where security_number = 6663;

CREATE VIEW timetable AS SELECT security_number,
surname||' '||name_and_patronymic fio,
employee.curr_post AS "Должность", date_of_taking_office
AS "Дата вступления"
FROM employee
WHERE date_of_taking_office < '2023-01-01'
UNION
SELECT security_number,
surname||'
'||name_and_patronymic,employee.curr_post,employment_histo
ry.date_of_taking_office
FROM employment_history, employee
WHERE employment_history.employee =
employee.security_number
AND employment_history.date_of_taking_office >
CAST(date_trunc('year', CURRENT_date) AS date)
AND employment_history.date_of_taking_office =
(SELECT MAX(date_of_taking_office)
FROM employment_history r
WHERE employee.security_number=r.employee
AND r.date_of_taking_office <=
CAST(date_trunc('year',
CURRENT_date) AS date));SELECT *
FROM timetable;

insert into timetable values
(3346,'fio','first post','2021-01-01');