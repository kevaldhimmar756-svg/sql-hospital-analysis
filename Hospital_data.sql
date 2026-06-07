DROP TABLE IF EXISTS hospital_data;

CREATE TABLE hospital_data(
		Hospital_name VARCHAR(100),
		Hospital_location VARCHAR(100),
		Department VARCHAR(100),
		Doctors_count Numeric,
		Patients_count Numeric,
		Admission_date DATE,
		Discharge_date DATE,
		Medical_expenses Numeric(10,2)
);

SELECT * FROM hospital_data;

COPY
hospital(Hospital_name, hospital_location, Department,Doctors_count,
Patients_count, Admission_date, Discharge_date, Medical_expenses)

FROM 'C:/Users/HP/OneDrive/Desktop'
DELIMITER','
CSV HEADER;


-- 1. Total Number of Patients Across All Hospitals.

SELECT SUM(Patients_Count) AS total_patients
FROM hospital_data;

-- 2. Average Number of Doctors per Hospital 

SELECT hospital_Name,
       AVG(Doctors_count) AS avg_doctors
FROM hospital_data
GROUP BY hospital_name
ORDER BY avg_doctors DESC;


-- 3. Top 3 Departments with the Highest Number of Patients 

SELECT Department,
       SUM(Patients_count) AS total_patients
FROM hospital_data
GROUP BY Department
ORDER BY total_patients DESC LIMIT 3;


-- 4. Hospital with the Maximum Medical Expenses 

SELECT Hospital_name,
       SUM(Medical_expenses) AS total_expenses
FROM hospital_data
GROUP BY hospital_name
ORDER BY total_expenses DESC LIMIT 1;

-- 5.Daily Average Medical Expenses 

SELECT hospital_name,
       SUM(Medical_expenses) / 
       (MAX(Discharge_date) - MIN(Admission_date)) AS daily_avg_expenses
FROM hospital_data
GROUP BY hospital_name;

-- 6. Longest Hospital Stay 

SELECT patient_name, hospital_name, admission_date,
       (discharge_date - admission_date) AS length_of_stay_days
FROM hospital_data
ORDER BY length_of_stay_days DESC LIMIT 1;

-- 7. Total Patients Treated Per City 

SELECT hospital_location AS city,
       SUM(Patients_count) AS total_patients
FROM hospital_data
GROUP BY hospital_location
ORDER BY total_patients DESC;

-- 8. Average Length of Stay Per Department 

SELECT department,
       AVG(discharge_date - admission_date) AS avg_stay_days
FROM hospital_data
GROUP BY department
ORDER BY avg_stay_days DESC;

-- 9. Identify the Department with the Lowest Number of Patients

SELECT Department,
       SUM(Patients_count) AS total_patients
FROM hospital_data
GROUP BY Department
ORDER BY total_patients ASC LIMIT 1;

-- 10. Monthly Medical Expenses Report 

SELECT TO_CHAR(admission_date, 'Month YYYY') AS month,
       SUM(medical_expenses) AS total_expenses
FROM hospital_data
GROUP BY TO_CHAR(admission_date, 'Month YYYY'),
         DATE_TRUNC('month', admission_date)
ORDER BY DATE_TRUNC('month', admission_date);
