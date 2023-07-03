use hr_db;
select * from hr;

-- What is the gender breakdown of employees in the company?
Select gender, count(gender), count(*) from hr group by gender;

Select gender, count(*) from hr group by gender;

Select sum(gender='Male')*100/count(gender) from hr;

Select sum(gender='Female')*100/count(gender) from hr;

Select sum(gender!='Male' or gender!='Female')*100/count(gender) as otherPercentage from hr;

SELECT gender, count(*) * 100.0 / (SELECT count(*) from hr) as 'Gender Percentage'
FROM hr
GROUP BY gender;

Select gender, count(*) from hr group by gender;

-- What is the race/ethnicity breakdown of employees in the company?
Select race as ethnicity, count(race) from hr group by race;

-- What is the age distribution of employees in the company?
Select age, count(*) from hr group by age;
ALTER TABLE hr
ADD age_group varchar(255);

Select case 
when age >=18 and age<35 then 'Young Age'
when age>=36 and age<=46 then 'Middle Age'
else                                                                   
'Old Age'
end as ageGroup from hr where age>18 group by ageGroup, first_name;

update hr set age_group=ageGroup;

update hr AS hr1  set age_group=(Select case 
when age >=18 and age<35 then 'Young Age'
when age>=36 and age<=46 then 'Middle Age'
else                                                                   
'Old Age'
end as ageGroup from hr where age>18 group by ageGroup) ;


-- How many employees work at headquarters versus remote locations?
select location, count(*) from hr group by location;

-- percentage of gender based on location values
Select location, gender, count(*)*100/(select count(*) from hr) as percentage from hr group by gender, location order by location;


-- How does the gender distribution vary across departments?
Select gender,department, count(gender) as countGender from hr group by  gender, department order by department;

-- What is the distribution of job titles across the company?
Select jobtitle, count(jobtitle) from hr group by jobtitle order by jobtitle;

-- Select least five duration employees
Select department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as duration from hr WHERE termdate<= curdate() and termdate<> '0000-00-00' and age>=18 group by department;

Select year(hire_date), count(*), case when termdate='0000-00-00' and termdate<=curdate() then 1 else 0 end as terminations from hr
 where age>18 group by year(hire_date);
 
 SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    department,
    sum(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN '1' ELSE '0' END) AS terminations,
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change
    FROM 
    hr
WHERE age >= 18
GROUP BY 
    department;

SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;


Select distinct(department),count(*) from hr group by department;
