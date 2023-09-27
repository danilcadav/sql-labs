CREATE
OR REPLACE FUNCTION get_experience(
experience numeric(5, 2),
date_taking date,
out result int
) AS $$ BEGIN result := experience + extract(
year
from
age(date_taking)
) RETURN;
END;
$$ LANGUAGE plpgsql;

select * from get_experience(12.00, '2012-11-22');

create table prize as
select
surname,
name_and_patronymic,
salary * 0 as prize
FROM
employee
JOIN posts ON employee.curr_post = posts.post_name;
CREATE
OR REPLACE FUNCTION get_prize(
base_rate numeric(1, 3)
) RETURNS BOOLEAN AS $$ BEGIN
UPDATE
prize
SET
prize = (
SELECT
t.prize
from
(
SELECT
surname,
name_and_patronymic,
(
base_rate * salary * CASE WHEN get_experience(
work_experience, date_of_taking_office
) BETWEEN 1
AND 5 THEN 0.1 WHEN get_experience(
work_experience, date_of_taking_office
) BETWEEN 5
AND 10 THEN 0.2 WHEN get_experience(
work_experience, date_of_taking_office
) BETWEEN 10
AND 20 THEN 0.3 WHEN get_experience(
work_experience, date_of_taking_office
) BETWEEN 20
AND 30 THEN 0.5 WHEN get_experience(
work_experience, date_of_taking_office
) > 30 THEN 1 ELSE 0 END
) AS prize
FROM
employee
JOIN posts ON employee.curr_post = posts.post_name
) as t
WHERE
prize.surname = t.surname
);
RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

select get_prize(0.1);