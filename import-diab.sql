
CREATE DATABASE project2

USE project2

DROP TABLE IF EXISTS diabetes

CREATE TABLE diabetes (
    Pregnancies INT,
    Glucose INT,
    BloodPressure INT,
    Skinthickness INT,
    Insulin INT,
    BMI DECIMAL(5,2),
    DiabetesPedigreeFunction DECIMAL(6,3),
    Age INT,
    Outcome BIT
)

BULK INSERT diabetes
FROM '/mydata/dataset/diabetes.csv'
WITH (
    FORMAT = 'CSV',
    firstrow = 2,
    fieldterminator =',',
    rowterminator ='\r\n'
);

SELECT * FROM diabetes;