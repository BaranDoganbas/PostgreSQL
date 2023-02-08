Select * from companies
DROP TABLE companies

CREATE TABLE companies
(
  company_id SMALLINT,
  company VARCHAR(20),
  number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

Delete FROM companies
--1. YOL

SELECT company, number_of_employees
FROM companies
ORDER BY number_of_employees DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--2. YOL --> Subquery ile
SELECT company, number_of_employees
FROM companies
WHERE number_of_employees = 18000;

SELECT company, number_of_employees
FROM companies
WHERE number_of_employees = (SELECT MAX(number_of_employees)
                            FROM companies
                            WHERE number_of_employees < (SELECT MAX(number_of_employees)
                                                         FROM companies));

UPDATE companies
SET number_of_employees = 16000
WHERE number_of_employees < (SELECT AVG(number_of_employees)
FROM companies);






