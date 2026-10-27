CREATE SCHEMA mission3;

SELECT * FROM jobs;

-- Question 1
SELECT job_title, salary_in_usd FROM jobs ORDER BY job_title;

-- Question 2
SELECT job_title, work_year, salary FROM jobs WHERE job_title IN ('Data Scientist', 'Data Analyst') ORDER BY work_year;

-- Question 3
SELECT job_title, experience_level, employment_type FROM jobs WHERE experience_level = 'Senior' AND employment_type = 'Full-time' ORDER BY job_title;

-- Question 4
SELECT job_title, company_location, salary_in_usd FROM jobs WHERE salary_in_usd > 100000 ORDER BY salary_in_usd DESC;

-- Question 5
SELECT job_title, company_size, salary FROM jobs WHERE company_location = 'United States' AND work_setting = 'Remote' ORDER BY company_size;

-- Question 6
SELECT job_title, company_location, salary FROM jobs WHERE experience_level = 'Senior' AND company_size = 'L' ORDER BY job_title;

-- Question 7
SELECT job_title, FORMAT(AVG(salary_in_usd), 0) AS avg_salary_in_usd FROM jobs GROUP BY job_title ORDER BY AVG(salary_in_usD) DESC;

-- Question 8 and need to update their employment types to 'FT' or 'Full-time'
SELECT job_title, employment_type, salary FROM jobs WHERE employment_type LIKE 'P%T%' AND salary > 50000 ORDER BY salary DESC;


START TRANSACTION;

COMMIT;
ROLLBACK;


-- Change employment type to 'FT' from 'PT'
UPDATE jobs SET employment_type = 'Full-time' WHERE employment_type = 'Part-time' AND salary > 50000;

-- Verify the update
SELECT * FROM jobs WHERE employment_type = 'Part-time' AND salary_in_usd > 50000;

-- SAFE UPDATE MODE ENABLE/DISABLE
SET SQL_SAFE_UPDATES = 1;

-- Question 9
SELECT * FROM jobs WHERE job_title IS NULL OR job_title = '' OR job_title = 'Unknown';

-- Change job title from Unknown to Data Specialist
UPDATE jobs SET job_title = 'Data Specialist' WHERE job_title IS NULL OR job_title = '' OR job_title = 'Unknown';

-- Question 10

SELECT * FROM jobs WHERE salary_in_usd < 70000 ORDER BY salary_in_usd DESC;

DELETE FROM jobs WHERE salary_in_usd < 70000;