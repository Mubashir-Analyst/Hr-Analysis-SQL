Use hr_db;

Select * from hr;

Select count(emp_id) from hr;

set sql_safe_updates=0;

Alter table hr change column id empId varchar(20) null;

Describe hr;

Select birthdate from hr;

Alter table hr Change column id emp_id varchar(20) null;

Update hr set birthdate= Case
 when birthdate like '%/%' then date_format(str_to_date(birthdate, '%d-%m-%Y'),'%y-%m-%d')
 when birthdate like '%-%' then date_format(str_to_date(birthdate, '%d-%m-%Y'),'%y-%m-%d')
 else null
 end;

ALter table hr modify column birthdate Date;
Update hr set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')) where termdate is not null and termdate!=' ';

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

aLTER TABLE hr add column age Int;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

select age from hr;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

Select * from hr where termdate=' ';

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

Select count(*), count(termdate) from hr;

SELECT * FROM hr WHERE termdate = ' ' OR termdate=0;

Select emp_id from hr where termdate='' or race='';
