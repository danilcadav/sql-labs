CREATE
OR REPLACE FUNCTION verify_employee_data() RETURNS trigger AS
$$ BEGIN CASE WHEN NOT(
new.taxpayer_number LIKE '%[^0-9]%'
AND extract(
year
from
age(new.date_of_birth)
) - get_experience(
new.work_experience, new.date_of_taking_office
) > 16
AND new.date_of_taking_office < CURRENT_TIMESTAMP
) THEN RAISE EXCEPTION '%',
'Invalid data';
ELSE RETURN NEW;
CASE WHEN new.date_of_taking_office END CASE;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER verify_employee_data_trigger BEFORE INSERT
OR
UPDATE
ON employee FOR EACH ROW EXECUTE PROCEDURE
verify_employee_data();

CREATE
OR REPLACE FUNCTION update_gender() RETURNS trigger AS $BODY$
BEGIN NEW.gender = CASE WHEN NEW.name_and_patronymic ~ 'ich'
THEN 'm' WHEN NEW.name_and_patronymic ~ 'vna' THEN 'f' ELSE
'u' END CASE;
RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;
CREATE TRIGGER "update_employees_gender_on_insert_trigger"
BEFORE INSERT ON employee FOR EACH ROW EXECUTE PROCEDURE
"update_gender"();