

USE project2

DROP TABLE IF EXISTS diabetes

SELECT * FROM diabetes;

/*
Section 1
    Data Cleaning
    1. missing data
    2. Outlier
    3. Duplicates

*/

-- 1.1 Missing Data

SELECT
    COUNT(1) [Outcome],
    COUNT(Pregnancies)*1.0/COUNT(1) [Pregnancies],
    COUNT(Glucose)*1.0/COUNT(1) [Glucoses],
    COUNT(BloodPressure)*1.0/COUNT(1) [BloodPressure],
    COUNT(Skinthickness)*1.0/COUNT(1) [Skinthickness],
    COUNT(Insulin)*1.0/COUNT(1) [Insulin],
    COUNT(BMI)*1.0/COUNT(1) [BMI],
    COUNT(DiabetesPedigreeFunction)*1.0/COUNT(1) [DiabetesPedigreeFunction],
    COUNT(Age)*1.0/COUNT(1) [Age]
FROM
    diabetes;


--1.2 Check the outliers (for numeric columns )--
SELECT
    MIN(Pregnancies) [Pregnancies],
    MAX(Pregnancies) [Pregnancies],
    AVG(Pregnancies) [Pregnancies],
    MIN(Glucose) [Glucose],
    MAX(Glucose) [Glucose],
    AVG(Glucose) [Glucose],
    MIN(BloodPressure) [BloodPressure],
    MAX(BloodPressure) [BloodPressure],
    AVG(BloodPressure) [BloodPressure],
    MIN(Skinthickness) [Skinthickness],
    MAX(Skinthickness) [Skinthickness],
    AVG(Skinthickness) [Skinthickness],
    MIN(Insulin) [Insulin],
    MAX(Insulin) [Insulin],
    AVG(Insulin) [Insulin],
    MIN(BMI) [BMI],
    MAX(BMI) [BMI],
    AVG(BMI) [BMI],
    MIN(DiabetesPedigreeFunction) [DiabetesPedigreeFunction],
    MAX(DiabetesPedigreeFunction) [DiabetesPedigreeFunction],
    AVG(DiabetesPedigreeFunction) [DiabetesPedigreeFunction],
    MIN(Age) [Age],
    MAX(Age) [Age],
    AVG(Age) [Age]
FROM 
    diabetes;



--1.3 Check Duplicate 

SELECT
    Pregnancies, 
    Glucose,
    BloodPressure,
    Skinthickness,
    Insulin,
    BMI,
    DiabetesPedigreeFunction,
    Age,
    Outcome,
    COUNT(*)
FROM 
    diabetes
GROUP BY 
    Pregnancies, 
    Glucose,
    BloodPressure,
    Skinthickness,
    Insulin,
    BMI,
    DiabetesPedigreeFunction,
    Age,
    Outcome
HAVING COUNT(*)>1 ;


--Count zero Insulin = 374 (360)

Select Count(*) [Insulin]
from diabetes
where Insulin=0;

--Count zero BMI = 11 (0)
Select Count(*) [BMI]
from diabetes
where BMI=0;

--Count zero GLucose = 5 (0)
Select Count(*) [Glucose]
from diabetes
where Glucose=0;


--Count Zero BP = 35 (28)
Select Count(*) [BloodPressure]
from diabetes
where BloodPressure=0;

--Count zero skinthickness  = 227 (218)

Select Count(*) [SkinThickness]
from diabetes
where Skinthickness= 0;




Select * from diabetes;


--Replace 0 values with NULL

UPDATE diabetes
SET 
    Glucose = NULLIF ( Glucose, 0 ),
    BloodPressure = NULLIF ( BloodPressure, 0 ),
    SkinThickness = NULLIF(SkinThickness, 0),
    Insulin = NULLIF(Insulin, 0),
    BMI = NULLIF ( BMI, 0 ) ;

Select * from diabetes;


--Count NULL values of Insulin

Select
    count(*) Insulin
FROM 
    diabetes
where Insulin is NULL;









--EDA--
--UNivariate Data analysis of numerical Features Distribution

--Pregnant
SELECT
    Pregnancies,
    COUNT(Pregnancies) [Count_preg]
FROM 
    diabetes
GROUP BY Pregnancies
ORDER BY Pregnancies;


--Glucose
SELECT
    Glucose,
    COUNT(Glucose) [Count_Gluc]
FROM 
    diabetes
GROUP BY Glucose
ORDER BY Glucose;

--BloodPressure

SELECT
    BloodPressure,
    COUNT(BloodPressure) [Count_BP]
FROM 
    diabetes
GROUP BY BloodPressure
ORDER BY BloodPressure;

--SkinThickness

SELECT
    Skinthickness,
    COUNT(Skinthickness) [Count_SkinThick]
FROM 
    diabetes
GROUP BY Skinthickness
ORDER BY Skinthickness;

--Insulin

SELECT
    Insulin,
    COUNT(Insulin) [Count_insulin]
FROM 
    diabetes
GROUP BY Insulin
ORDER BY Insulin;

--BMI

SELECT
    BMI,
    COUNT(BMI) [Count_BMI]
FROM 
    diabetes
GROUP BY BMI
ORDER BY BMI;

--Diabetespercentage

SELECT
    DiabetesPedigreeFunction,
    COUNT(BloodPressure) [Count_DPF]
FROM 
    diabetes
GROUP BY DiabetesPedigreeFunction
ORDER BY DiabetesPedigreeFunction;

--Age

SELECT
    Age,
    COUNT(Age) [Count_age]
FROM 
    diabetes
GROUP BY Age
ORDER BY Age;

--outcome

SELECT
    Outcome,
    COUNT(Outcome) [Count_outcome]
FROM 
    diabetes
GROUP BY Outcome
ORDER BY Outcome;



