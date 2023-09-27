select
surname,
name_and_patronymic,
curr_department
from
employee
where
curr_post like '%engineer%'
order by
curr_department;

select
surname,
name_and_patronymic,
curr_department
from
employee
where
extract(
year
from
age(date_of_taking_office)
) + work_experience >= 20
order by
curr_department;

select
surname,
name_and_patronymic,
curr_department
from
employee
where
not exists(
select
post
from
employment_history
where
(
employment_history.post <> curr_post
)
and (
employment_history.employee = security_number
)
)
order by
curr_department;

select
surname,
name_and_patronymic,
curr_department
from
employee
where
exists(
select
eh1.employee,
eh1.date_of_taking_office data1,
eh2.date_of_taking_office data2
from
employment_history eh1
join employment_history eh2 ON eh1.employee =
eh2.employee
where
@(
eh1.date_of_taking_office -
eh2.date_of_taking_office
) < 365
and @(
eh1.date_of_taking_office -
eh2.date_of_taking_office
) <> 0
and eh1.employee = security_number
);

select
surname,
name_and_patronymic,
curr_department
from
employee
where
exists(
select
count (
distinct (employee, post)
)
from
employment_history
where
employee = security_number
having
count(
distinct (employee, post)
) >= 3
)