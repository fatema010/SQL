CREATE DATABASE IF NOT EXISTS hrdata;
USE hrdata;

CREATE TABLE hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);
SELECT * FROM hrdata;
#Employee cunt:
SELECT SUM(employee_count) as employee_count from hrdata
#where education = 'High School';
#where department = 'R&D'

where education_field = 'Medical';
#Attrition Count:
select count(attrition) from hrdata where attrition='Yes'
and education = 'Doctoral degree';
select count(attrition) from hrdata where attrition='Yes' 
and department = 'R&D' and education_field = 'Medical'  
and education = 'High School'; 
#Attrition Rate:

select round (((select count(attrition)
from hrdata where attrition='Yes' and department = 'Sales') / sum(employee_count)) * 100,2) from hrdata
where department = 'Sales';

#Active Employee:
select sum(employee_count) - (select count(attrition) from hrdata  where attrition='Yes' and gender = 'Male') 
from hrdata where gender = 'Male';

select (select sum(employee_count) from hrdata) - count(attrition) as active_employee from hrdata
where attrition='Yes';

#Average Age:
select round(avg(age),0)  as Avg_age from hrdata;

#Attrition by Gender

select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes' and education = 'High School'
group by gender
order by count(attrition) desc;

#  Department wise Attrition

SELECT
  department,
  COUNT(attrition) AS attrition_count,
  ROUND(
    (CAST(COUNT(attrition) AS DECIMAL(10, 2)) / 
    CASE WHEN (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes' AND gender = 'Female') > 0
         THEN (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes' AND gender = 'Female')
         ELSE 1
    END) * 100, 2
  ) AS pct
FROM
  hrdata
WHERE
  attrition = 'Yes' AND gender = 'Female'
GROUP BY
  department
ORDER BY
  COUNT(attrition) DESC;


# No of Employee by Age Group
SELECT age,  sum(employee_count) AS employee_count FROM hrdata
GROUP BY age
order by age;

# Education Field wise Attrition:

select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes' and department = 'Sales'
group by education_field
order by count(attrition) desc;

#Attrition Rate by Gender for different Age Group

select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as decimal) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;

#Job Satisfaction Rating

SELECT
  job_role,
  SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS one,
  SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS two,
  SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS three,
  SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS four
FROM
  hrdata
GROUP BY
  job_role
ORDER BY
  job_role;













