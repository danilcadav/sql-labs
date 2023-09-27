select distinct employee, post
from employment_history;

select *
from employee
where curr_department = 2;

select post_name, department_name
from posts, departments;

select security_number, taxpayer_number,
curr_department
from employee
where date_of_taking_office < '2021-01-01'
UNION
select security_number, taxpayer_number,
curr_department
from employee
where work_experience > 2;

select surname, name_and_patronymic,
curr_department
from employee
where curr_post not in
(
select post_name
from posts
where salary > 15000
);

select distinct security_number, surname,
name_and_patronymic
from employee
where security_number in
(
select security_number from employee
where work_experience > 2
)
and security_number in
(
select security_number from employee
where curr_post = 'first post'
or curr_post = 'fourth post'
);

select l.surname, l.name_and_patronymic,
j.department_name, l.curr_post
from employee l inner join departments j
on l.curr_department = j.num;
