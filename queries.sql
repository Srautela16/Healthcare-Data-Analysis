CREATE DATABASE healthcare_db;
USE healthcare_db;

CREATE TABLE stroke_data (
    id INT,
    gender VARCHAR(20),
    age FLOAT,
    hypertension INT,
    heart_disease INT,
    ever_married VARCHAR(10),
    work_type VARCHAR(20),
    Residence_type VARCHAR(10),
    avg_glucose_level FLOAT,
    bmi FLOAT,
    smoking_status VARCHAR(20),
    stroke INT
);
select* from stroke_data;

-- Total Patients
SELECT COUNT(*) AS total_patients FROM stroke_data;

-- Total Stroke cases
SELECT SUM(stroke) AS total_stroke_cases FROM stroke_data;

-- stroke percentage
SELECT 
(SUM(stroke) / COUNT(*)) * 100 AS stroke_percentage
FROM stroke_data;

-- Average age
SELECT AVG(age) AS avg_age FROM stroke_data;

-- stroke by gender
SELECT gender, COUNT(*) AS total,
SUM(stroke) AS stroke_cases
FROM stroke_data
GROUP BY gender;

-- High risk patients
SELECT *
FROM stroke_data
WHERE age > 50 
  AND hypertension = 1 
  AND heart_disease = 1;
  
 -- BMI catogary Analysis 
  SELECT 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    COUNT(*) AS total,
    SUM(stroke) AS stroke_cases
FROM stroke_data
GROUP BY bmi_category;

-- Age Group Analysis
SELECT 
    CASE 
        WHEN age < 20 THEN '0-20'
        WHEN age BETWEEN 20 AND 40 THEN '20-40'
        WHEN age BETWEEN 40 AND 60 THEN '40-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total,
    SUM(stroke) AS stroke_cases
FROM stroke_data
GROUP BY age_group
ORDER BY age_group;