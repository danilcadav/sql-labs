CREATE TABLE Departments
(
Num numeric(6,0) PRIMARY KEY,
department_name char(50) NOT NULL
);
CREATE TABLE Posts
(
post_name char(50) PRIMARY KEY,
salary numeric(8,0) NOT NULL DEFAULT 0 CHECK (salary >= 0)
);
CREATE TABLE Employee
(
security_number numeric(6,0) PRIMARY KEY,
surname char(20) NOT NULL,
name_and_patronymic char(30),
taxpayer_number char(12) NOT NULL CONSTRAINT
unique_taxpayer UNIQUE,
gender char(1) NOT NULL DEFAULT 'm' CHECK (gender = 'm' OR
gender = 'f'),
date_of_birth date NOT NULL,
curr_department numeric(3,0) REFERENCES Departments(Num),
curr_post char(30) REFERENCES Posts(post_name),
date_of_taking_office date,
work_experience numeric(5,2) DEFAULT 0
);
CREATE TABLE Employment_history
(
employee numeric(6,0) REFERENCES Employee(security_number)
NOT NULL,
department char(50),
post char(50) NOT NULL,
date_of_taking_office date NOT NULL
);

INSERT INTO departments
VALUES
(1, 'first department'),
(2, 'second department'),
(3, 'third department');
INSERT INTO Posts
VALUES
('first post', 20000),
('second post', 15000),
('third post', 12500),
('fourth post', 22500);
INSERT INTO Employee
VALUES
(1234, 'Ivanov', 'Ivan Ivanovich',
'091827465678', 'm', 'December 7, 1994', 2, 'fourth post',
'January 1, 2022', 2.5),
(4321, 'Smirnova', 'Alena Alexandrovna',
'053917464323', 'f', 'May 5, 1991', 3, 'first post', 'March
10, 2021', 4);
(1324, 'Danilov', 'Danil Alexandrovich',
'019827445568', 'm', 'May 30, 1992', 2, 'third post', 'January
15, 2022', 2.5),
(4231, 'Ivanova', 'Viktoria Arturovna',
'053317554323', 'f', 'June 25, 1997', 3, 'fourth post', 'March
10, 2021', 1);
INSERT INTO Employment_history
VALUES
(1234, 'second department', 'fourth post', 'January 1, 2022'),
(4321, 'third department', 'first post', 'March 10, 2021');
