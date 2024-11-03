
USE project2

-- Add new columns: Convert numeric into categorical columns
--Convert Age into categorical-- bins group

DROP TABLE IF EXISTS project2.dbo.diab_age 

SELECT
    *,
    CASE
        WHEN Age <=29 then '1. 20-29'
        WHEN Age <=39 then '2. 30-39'
        WHEN Age <=49 then '3. 40-49'
        WHEN Age <=59 then '4. 50-59'
        else '4. 50-59' end [Age_bin]
    INTO project2.dbo.diab_age
FROM 
    diabetes;

SELECT * FROM project2.dbo.diab_age;

SELECT
    Age_bin,
    Count(*) [Count_Age_bin]
FROM 
    project2.dbo.diab_age
GROUP by Age_bin
ORDER by Age_bin;

--Convert BMI into categorical

DROP TABLE IF EXISTS project2.dbo.BMI_category

SELECT
    *,
    Case 
        when BMI < 18.5 then 'UnderWeight'
        when BMI >= 18.5 and BMI <=24.9 then 'Healthy'
        when BMI > 24.9 and BMI < 30 then 'Overweight'
        else 'Obese' END [BMI_category]
    INTO project2.dbo.BMI_category
FROM 
    diabetes;


Select * from project2.dbo.BMI_category


--Count the number of Underweight, Healthy, Overweight and Obese
-- Obese = 469, Overweight = 178, Underweight = 4, Healthy =101
--Most of the women present overweight or obesity.

SELECT
    BMI_category,
    Count(*) [Count_BMICategory]
FROM 
    project2.dbo.BMI_category
GROUP by BMI_category;


--Convert Glucose into categorical

SELECT
    Glucose,
    case 
        when Glucose < 70 then 'Low'
        when Glucose BETWEEN 70 and 100 then 'Normal'
        when Glucose > 100 then 'High'
        else 'unknown' END [Glucose_category]
    INTO project2.dbo.Glucose_category
FROM 
    diabetes;

Select * from project2.dbo.Glucose_category;

--Count the Glucose category (LOW = 11, NORMAL = 194, HIGH = 547)

SELECT
    GLucose_category,
    Count(*) 
FROM 
    project2.dbo.Glucose_category
GROUP BY Glucose_category; 





--Convert DiabetesPedigreeFUnction into categorical
--DPF < 0.7 (LOW RISK) and DPF >= 0.7 (HIGH RISK)

SELECT
    *,
    CASE 
        WHEN DiabetesPedigreeFunction < 0.7 THEN 'Low-Risk'
        ELSE 'High-Risk' End [Genetic_factor_risk]
FROM 
    diabetes;



--Convert OUTCOME into categorical 'Yes' and 'No'

SELECT
    Outcome,
    CASE 
        WHEN Outcome = 1 THEN 'Diabetes' 
        ELSE 'No-Diabetes' End [Outcome_Diabetes]
FROM 
    diabetes;




--save for analysis

DROP TABLE IF EXISTS project2.dbo.diab_base


SELECT
    Pregnancies,
    CASE
    WHEN Pregnancies = 0 THEN '[b1] 0'
    WHEN Pregnancies = 1 THEN '[b2] 1'
    WHEN Pregnancies = 2 THEN '[b3] 2'
    WHEN Pregnancies BETWEEN 3 AND 5 THEN '[b4] 3-5'
    WHEN Pregnancies BETWEEN 6 AND 9 THEN '[b5] 6-9'
    WHEN Pregnancies > = 10 THEN '[b6] 10+'
    Else '[b7] not matched'
    END AS 'pregnancy_bins',
    Glucose,
    CASE
        WHEN Glucose < 70 THEN 'Low'
        WHEN Glucose BETWEEN 70 AND 100 THEN 'Normal'
        WHEN Glucose > 100 THEN 'High'
        ELSE 'unknown' END [Glucose_category],
    CASE
        WHEN Glucose < 100 THEN '[g1] < 99'
        WHEN Glucose BETWEEN 100 AND 125 THEN '[g2] 100-125'
        WHEN Glucose >= 125 THEN '[g3] 126+'
        ELSE '[g4] not matched'
        END AS 'glucose_bins',
    BloodPressure,
    CASE
        WHEN BloodPressure < 60 THEN '[bp1] <60'
        WHEN BloodPressure BETWEEN 60 AND 79 THEN '[bp2] 60-79'
        WHEN BloodPressure BETWEEN 80 AND 89 THEN '[bp3] 80-89'
        WHEN BloodPressure >= 90 THEN '[bp4] 90+'
        ELSE '[bp5] not matched'
        End AS 'blood_pressure_bins',
    Skinthickness,
    CASE
        WHEN Skinthickness < 20 THEN '[st1] < 20'
        WHEN Skinthickness BETWEEN 20 AND 29 THEN '[st2] 20-29'
        WHEN Skinthickness >= 30  THEN '[st3] 30+'
        ELSE '[st4] not matched'
        END AS 'skin_thickness_bins',
    Insulin,
    CASE
        WHEN Insulin < 100 THEN '[ins1] < 100'
        WHEN Insulin BETWEEN 100 AND 149 THEN '[ins2] 100-149'
        WHEN Insulin >= 200 THEN '[ins3] 200+'
        ELSE '[ins4] not matched'
        END AS 'insulin_bins',
    BMI,
    CASE 
        WHEN BMI < 18.5 THEN 'UnderWeight'
        WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Healthy'
        WHEN BMI BETWEEN 25 AND 29 THEN 'Overweight'
        ELSE 'Obese' END [BMI_category],
    CASE
        WHEN BMI < 25 THEN '[bmi1] <= 24.9'
        WHEN BMI BETWEEN 25 and 29.9 THEN '[bmi2] 25-29.9'
        WHEN BMI >= 30 THEN '[bmi3] 30+'
        ELSE '[bmi4] not matched'
        END AS 'BMI_bins',
    DiabetesPedigreeFunction,
    CASE 
        WHEN DiabetesPedigreeFunction < 0.3 THEN '[dpf1] < 0.3'
        WHEN DiabetesPedigreeFunction BETWEEN 0.3 AND 0.6 THEN '[dpf2] < 0.3-0.6'
        WHEN DiabetesPedigreeFunction BETWEEN 0.6 AND 0.9 THEN '[dpf3] < 0.6-0.9'
        WHEN DiabetesPedigreeFunction >=1  THEN '[dpf4] 1+'
        ELSE '[dpf5] not matched'
        END AS 'dpf_bins',
    Age,
    CASE
        WHEN Age < 30 THEN '[b1] 20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '[b2] 30-39'
         WHEN Age BETWEEN 40 AND 49 THEN '[b3] 40-49'
        WHEN Age >= 50 THEN '[b4] 50+'
       ELSE '[b5] Not matched'
       END AS 'age_bins',
    Outcome,
    CASE 
        WHEN Outcome = 1 THEN 'Diabetes' 
        ELSE 'Non-Diabetes'End [Outcome_Diabetes]
INTO project2.dbo.diab_base
FROM 
    diabetes;


SELECT * FROM project2.dbo.diab_base;