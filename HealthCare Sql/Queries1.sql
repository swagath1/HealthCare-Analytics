use healthcare;


/*Q1.

Find the Top 5 Departments generating the highest revenue by joining Department → Admission → Billing. Display:

Department Name
Total Revenue
Number of Admissions
Average Bill Amount
Revenue Rank
Percentage Contribution to Hospital Revenue
Running Revenue.*/

WITH CTE AS (
	SELECT 
		DEPARTMENT_NAME,
		SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE,
		COUNT(*) TOTAL_ADMISSIONS,
		AVG(TOTAL_AMOUNT) AS AVERAGE_BILL_AMOUNT,
		DENSE_RANK()OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) RN
	FROM 
	CLEANED_ADMISSION A
	JOIN
	CLEANED_DEPARTMENT D ON 
	A.DEPARTMENT_ID=D.DEPARTMENT_ID
	JOIN 
	CLEANED_BILLING B ON 
	A.ADMISSION_ID=B.ADMISSION_ID
	GROUP BY DEPARTMENT_NAME
	)
	SELECT TOP 5 
		DEPARTMENT_NAME,
		TOTAL_REVENUE,
		TOTAL_ADMISSIONS,
		AVERAGE_BILL_AMOUNT,
		RN,
		CAST(TOTAL_REVENUE*100.0 /SUM(TOTAL_REVENUE)OVER()AS DECIMAL(10,2)) PERCENTAGE_REVENUE,
		SUM(TOTAL_REVENUE)OVER(ORDER BY TOTAL_REVENUE DESC ROWS UNBOUNDED PRECEDING) AS RUNNING_REVENUE
	FROM CTE


/*
Q.2
Business Problem

Find the patients whose total hospital billing amount is greater than the average total billing amount across all patients.

Display:

Patient ID
Total Admissions
Total Revenue
Average Bill Amount
Average Length of Stay (Days)
Spending Rank
*/

WITH CTE AS (
	SELECT
		A.PATIENT_ID,
		COUNT(DISTINCT A.ADMISSION_ID) TOTAL_ADMISSIONS,
		SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE,
		AVG(TOTAL_AMOUNT) AS AVERAGE_BILL_AMOUNT,
		AVG(LENGTH_OF_STAY) AS AVG_LENGTH_OF_DAYS,
		DENSE_RANK()OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) DR
	FROM CLEANED_ADMISSION A 
	JOIN
	CLEANED_BILLING B ON 
	A.ADMISSION_ID=B.ADMISSION_ID
	GROUP BY A.PATIENT_ID
)
		SELECT 
			PATIENT_ID,
			TOTAL_ADMISSIONS,
			TOTAL_REVENUE,
			AVERAGE_BILL_AMOUNT,AVG_LENGTH_OF_DAYS,
			DR
		FROM CTE 
		WHERE TOTAL_REVENUE>(SELECT 
								AVG(TOTAL_REVENUE)
							 FROM CTE
							 )


/*
Q.3
Business Problem

Analyze the financial and operational performance of each disease.

For every disease, display:

Disease Name
Total Admissions
Total Revenue
Average Bill Amount
Average Length of Stay (Days)
Revenue Contribution (%) to the Hospital
Revenue Rank

Display only those diseases that have more than the average number of admissions across all diseases.*/

WITH CTE AS (
	SELECT
		DISEASE_NAME,
		COUNT(A.ADMISSION_ID) TOTAL_ADMISSIONS,
		SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE,
		AVG(TOTAL_AMOUNT) AVG_BILL_AMOUNT,
		AVG(LENGTH_OF_STAY) AVG_STAY,
		DENSE_RANK()OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) DR
	FROM 
	CLEANED_ADMISSION A 
	JOIN
	CLEANED_DISEASE D ON 
	A.DISEASE_ID=D.DISEASE_ID
	JOIN
	CLEANED_BILLING B ON 
	A.ADMISSION_ID=B.ADMISSION_ID
		GROUP BY DISEASE_NAME
	)
		SELECT TOP 3 *,
		CONCAT(CAST(TOTAL_REVENUE*100.0/SUM(TOTAL_REVENUE)OVER() AS DECIMAL(10,2)),'%') AS REVENUE_PCT
		FROM CTE 
		WHERE 
		TOTAL_ADMISSIONS>(SELECT
						   AVG(TOTAL_ADMISSIONS)
						   FROM CTE)

/*
Q.4
Business Problem

Hospital management wants to identify patients who are frequently readmitted.

Find patients who were readmitted within 30 days of their previous discharge.

For each readmission, display:

Patient ID
Current Admission ID
Previous Admission ID
Previous Discharge Date
Current Admission Date
Days Between Admissions
Total Revenue of the Current Admission
Readmission Status
'Readmitted Within 30 Days'
'Normal Admission'
Readmission Rank (patients with the shortest gap ranked first)

Display only patients who have more than one admission.*/

WITH CTE AS (
	SELECT
		PATIENT_ID,
		ADMISSION_ID AS CURRENT_ID,
		LAG(ADMISSION_ID)OVER(PARTITION BY PATIENT_ID ORDER BY ADMISSION_DATE) PREVIOUS_ID,
		ADMISSION_DATE,
		DISCHARGE_DATE AS CURRENT_DISCHARGE_DATE,
		LAG(DISCHARGE_DATE)OVER(PARTITION BY PATIENT_ID ORDER BY ADMISSION_DATE) PREVIOUS_DISCHARGE_DATE,
		LENGTH_OF_STAY,
		COUNT(*)OVER(PARTITION BY PATIENT_ID) TOTAL_ADMISSIONS
	FROM CLEANED_ADMISSION
)
	SELECT
		PATIENT_ID,
		CURRENT_ID,
		PREVIOUS_ID,
		CURRENT_DISCHARGE_DATE,
		PREVIOUS_DISCHARGE_DATE,
		LENGTH_OF_STAY,
		CASE 
		WHEN DATEDIFF(DAY,PREVIOUS_DISCHARGE_DATE,ADMISSION_DATE)<=30 
		THEN 'READMITTED WITHIN 30 DAYS' 
		ELSE 'NORMAL ADMISSION'
		END AS READMISSION_STATUS,
		DENSE_RANK() OVER
			(ORDER BY CASE WHEN DATEDIFF(DAY,PREVIOUS_DISCHARGE_DATE,ADMISSION_DATE)<=30 
							THEN 'READMITTED WITHIN 30 DAYS' 
							ELSE 'NORMAL ADMISSION'
							END
								) AS READMISSION_RANK,
		TOTAL_ADMISSIONS
	FROM CTE
		WHERE TOTAL_ADMISSIONS >1
		AND DATEDIFF(DAY,PREVIOUS_DISCHARGE_DATE,ADMISSION_DATE)<=30 

/*
Q5. Patients Who Never Received a Prescription
Business Problem

Find all patients who were admitted to the hospital but never received any prescription during any of their admissions.

Display:

Patient ID
Total Admissions
First Admission Date
Last Admission Date

Sort the results by Total Admissions in descending order.*/

SELECT
	PATIENT_ID,
	COUNT(DISTINCT ADMISSION_ID) TOTAL_ADMISSIONS,
	MIN(ADMISSION_DATE) FIRST_ADMISSION_DATE,
	MAX(ADMISSION_DATE) LAST_ADMISSION_DATE
FROM CLEANED_ADMISSION A 
		WHERE NOT EXISTS(
				SELECT 1 
				FROM CLEANED_PRESCRIPTION P
				WHERE A.ADMISSION_ID=P.ADMISSION_ID
			)
	GROUP BY PATIENT_ID
	ORDER BY TOTAL_ADMISSIONS DESC



/*Q6. Payment Mode Performance Analysis
Business Problem

Hospital management wants to analyze the performance of different payment modes to understand revenue generation, payment completion, and insurance utilization.

For each Payment Mode, display:

Payment Mode
Total Bills
Total Revenue
Average Bill Amount
Total Insurance Covered Amount
Total Patient Payable Amount
Number of Paid Bills
Number of Pending Bills
Paid Percentage (%)
Revenue Contribution to Hospital (%)
Revenue Rank

Display only those payment modes whose total revenue is greater than the average revenue across all payment modes.

Sort the results by Total Revenue in descending order.*/

WITH CTE AS (
SELECT 
PAYMENT_MODE,
COUNT(*) TOTAL_BILLS,
SUM(TOTAL_AMOUNT) TOTAL_REVENUE,
AVG(TOTAL_AMOUNT) AVG_BILL_AMOUNT,
SUM(INSURANCE_COVERED_AMOUNT) TOTAL_INSURANCE_AMOUNT,
SUM(PATIENT_PAYABLE_AMOUNT) TOTAL_PATIENT_PAYABLE_AMOUNT,
COUNT(CASE WHEN PAYMENT_STATUS='PAID' THEN 1 END) AS NO_OF_PAID_BILLS,
COUNT(CASE WHEN PAYMENT_STATUS='PENDING' THEN 1 END) AS NO_OF_PENDING_BILLS
FROM CLEANED_BILLING
GROUP BY PAYMENT_MODE
)
SELECT 
PAYMENT_MODE,
TOTAL_BILLS,
TOTAL_REVENUE,
AVG_BILL_AMOUNT,
CAST(TOTAL_INSURANCE_AMOUNT AS DECIMAL(18,2)) AS TOTAL_INSURANCE_AMOUNT ,
CAST(TOTAL_PATIENT_PAYABLE_AMOUNT AS DECIMAL(18,2)) TOTAL_PATIENT_PAYABLE_AMOUNT,
NO_OF_PAID_BILLS,
NO_OF_PENDING_BILLS,
CAST(NO_OF_PAID_BILLS*100.0/TOTAL_BILLS AS DECIMAL(18,2)) AS PAID_BILLS_PCT,
CAST(TOTAL_REVENUE*100.0/SUM(TOTAL_REVENUE)OVER() AS DECIMAL(18,2)) AS REVENUE_PCT,
DENSE_RANK()OVER(ORDER BY TOTAL_REVENUE DESC) DK
FROM CTE
WHERE TOTAL_REVENUE>(SELECT AVG(TOTAL_REVENUE) FROM CTE)


/*Q7. Business Problem

Hospital management wants to identify beds that remained vacant for more than 7 days before being assigned to the next patient.

For each vacancy period, display:

Bed ID
Previous Patient Discharge Date
Current Patient Admission Date
Vacancy Duration (Days)

Return only those beds where the vacancy duration is greater than 7 days.

Sort the results by:

Vacancy Duration (Descending)
Bed ID*/

WITH CTE AS (
SELECT 
BED_ID,
LAG(DISCHARGE_DATE)OVER(PARTITION BY BED_ID ORDER BY ADMISSION_DATE) PREV_DISCHARGE_DATE,
ADMISSION_DATE AS CURRENT_ADMISSION_DATE
FROM CLEANED_ADMISSION
),
CTE1 AS (
SELECT 
BED_ID,
PREV_DISCHARGE_DATE,
CURRENT_ADMISSION_DATE,
DATEDIFF(DAY,PREV_DISCHARGE_DATE,CURRENT_ADMISSION_DATE) AS VACANCY_DURATION
FROM CTE
)
SELECT * FROM CTE1 WHERE VACANCY_DURATION>=7 ORDER BY VACANCY_DURATION DESC





