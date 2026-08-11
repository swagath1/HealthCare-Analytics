use healthcare;

/* 1. Calculate the average length of stay for each disease category, but only include categories with more than 100 admissions.*/

SELECT dis.disease_category,
       ROUND(AVG(CAST(a.length_of_stay AS FLOAT)), 2) AS avg_los,
       COUNT(*) AS admissions
FROM cleaned_Admission a
JOIN cleaned_Disease dis ON a.disease_id = dis.disease_id
GROUP BY dis.disease_category
HAVING COUNT(*) > 100
ORDER BY avg_los DESC;

/* 2. List the top 5 departments by total billing revenue.*/

SELECT TOP (5) d.department_name,
       SUM(b.total_amount) AS total_revenue
FROM cleaned_Billing b
JOIN cleaned_Admission a ON b.admission_id = a.admission_id
JOIN cleaned_Department d ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_revenue DESC;

/* 3. Find the bed occupancy rate (%) for each ward.*/

SELECT ward_name,total_beds,
       count(case when bed_status='occupied' then 1  end) as bed_occupied,
	   cast(count(case when bed_status='occupied' then 1  end)*100.0/total_beds as decimal(10,2)) as bed_pct
from cleaned_bed b
join cleaned_ward w on b.ward_id=w.ward_id
group by ward_name,total_beds
order by bed_pct desc;

/* 4. Break down outstanding (unpaid) balances by payment status and payment mode.*/

SELECT payment_status,payment_mode,
      count(*) total_bills,
	  sum(total_amount) total_revenue
from cleaned_billing
where payment_status='pending'
group by payment_status,payment_mode;

/* 5.Show the distribution of diseases across different age bands.*/

SELECT age_band,disease_category, 
       count(*) total_count
from cleaned_admission a
join cleaned_disease d on a.disease_id=d.disease_id
where age_band is not null
group by age_band,disease_category
order by total_count desc;

/* 6. Find all patients who were billed but have no insurance coverage at all. */

SELECT a.patient_id,total_amount,insurance_covered_amount
from cleaned_admission a 
join cleaned_billing b on a.admission_id=b.admission_id
join cleaned_patient p on a.patient_id=p.patient_id
where insurance_covered_amount = 0

/* 7. List all doctors along with the number of diagnostic tests they've conducted. */

SELECT d.doctor_id, specialization,
       COUNT(pd.patient_diagnostic_id) AS test_count
FROM cleaned_Doctor d
LEFT JOIN cleaned_Patient_Diagnostic pd ON d.doctor_id = pd.doctor_id
GROUP BY d.doctor_id, d.specialization
ORDER BY test_count DESC;

/* 8. Find the most common blood group among admitted patients per department. */

with cte as (
SELECT department_name,blood_group,
       count(*) total_groups
from cleaned_admission a 
join cleaned_department d on a.department_id=d.department_id
join cleaned_patient p on a.patient_id=p.patient_id
group by department_name,blood_group
),
cte1 as (
select 
     department_name,blood_group,
	 total_groups,
	 rank()over(partition by department_name order by total_groups desc) rk
from cte 
)
select * from cte1 where rk=1

/* 9. Identify wards where more than 70% of beds are occupied.*/

select ward_name,total_beds,
       count(case when bed_status='occupied' then 1 end) beds_occupied,
	   cast(count(case when bed_status='occupied' then 1 end)*100.0/total_beds as decimal(10,2)) total_pct
from cleaned_bed b 
join cleaned_ward w on b.ward_id=w.ward_id
group by ward_name,total_beds
having cast(count(case when bed_status='occupied' then 1 end)*100.0/total_beds as decimal(10,2))>70

/* 10. Patients who have at least one abnormal diagnostic result */

select patient_id,city
from cleaned_patient p 
where exists (select 1 
                from cleaned_admission a 
				join cleaned_patient_diagnostic pd on a.admission_id=pd.admission_id
				where p.patient_id=a.admission_id
				and result_status='abnormal');

/* 11. Departments that have at least one ward running above 75% occupancy */

select department_name
from cleaned_department d 
where exists (select 1 
                 from cleaned_bed b 
				 join cleaned_ward w on b.ward_id=w.ward_id
				 where w.department_id=d.department_id
				 group by b.ward_id,total_beds
				 having 100.0 * COUNT(CASE WHEN b.bed_status = 'Occupied' THEN 1 END) / w.total_beds > 75
				 )
				 
/* 12. Patients who have never been admitted */

select patient_id
from cleaned_patient p
where not exists(select 1 from cleaned_admission a where a.patient_id=p.patient_id)

/* 13. 4. Doctors who have never conducted a diagnostic test */

select doctor_id,specialization 
from cleaned_doctor d 
where not exists (select 1 from cleaned_patient_diagnostic p where d.doctor_id=p.doctor_id)

/* 14. Combine two different risk criteria — financially at-risk and clinically at-risk — into one deduplicated list.*/

SELECT p.patient_id, 'High Bill, Uninsured' AS risk_flag
FROM cleaned_Billing b
JOIN cleaned_Admission a ON b.admission_id = a.admission_id
JOIN cleaned_Patient p ON a.patient_id = p.patient_id
WHERE b.Insurance_Coverage_Pct = 0
  AND b.total_amount > (SELECT AVG(total_amount) * 2 FROM cleaned_Billing)

UNION

SELECT DISTINCT p.patient_id, 'Abnormal Diagnostic' AS risk_flag
FROM cleaned_Patient p
JOIN cleaned_Admission a ON a.patient_id = p.patient_id
JOIN cleaned_Patient_Diagnostic pd ON pd.admission_id = a.admission_id
WHERE pd.result_status <> 'Normal'

ORDER BY patient_id;

/* 15. Rank doctors by diagnostic test volume within their specialization*/

SELECT specialization, doctor_id, test_count,
       RANK() OVER (PARTITION BY specialization ORDER BY test_count DESC) AS rnk
FROM (
    SELECT doc.doctor_id, doc.specialization, COUNT(pd.patient_diagnostic_id) AS test_count
    FROM cleaned_Doctor doc
    JOIN cleaned_Patient_Diagnostic pd ON doc.doctor_id = pd.doctor_id
    GROUP BY doc.doctor_id, doc.specialization
) t
ORDER BY specialization, rnk;

/* 16. Calculate a running total of monthly hospital revenue over time.*/

SELECT month, monthly_revenue,
       SUM(monthly_revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM (
    SELECT CONVERT(varchar(7), bill_date, 120) AS month, SUM(total_amount) AS monthly_revenue
    FROM cleaned_Billing
    GROUP BY CONVERT(varchar(7), bill_date, 120)
) m
ORDER BY month;

/*17. Calculate month-over-month revenue growth percentage.*/

with cte as (
select month(bill_date) [month],sum(total_amount) total_revenue
from cleaned_billing 
group by month(bill_date)
)
select 
     month,total_revenue,
	 lag(total_revenue)over( order by month) prev_revenue,
	 total_revenue-lag(total_revenue)over( order by month)*100.0/lag(total_revenue)over( order by month) AS MOM_PCT
	 from cte 

/* 18. Identify patients readmitted within 30 days of a previous discharge.*/

with cte as (
select a.patient_id,admission_date,discharge_date,
       lag(discharge_date)over(partition by a.patient_id order by admission_date) prev_discharge_date
from cleaned_admission a
join cleaned_patient p on a.patient_id=p.patient_id
)
select 
       patient_id,admission_date,discharge_date,prev_discharge_date,
	   datediff(day,prev_discharge_date,admission_date) days
from cte 
where prev_discharge_date is not null
and datediff(day,prev_discharge_date,admission_date) between 0 and 30
order by days desc

/* 19. Find the most expensive drug in each drug category. */

select * 
from (
select 
     drug_name,drug_category,sum(unit_cost) total_cost,
	 row_number()over(partition by drug_category order by sum(unit_cost) desc) rn
from cleaned_drug
group by drug_name,drug_category)t where rn=1;

/* 20. Calculate the abnormal diagnostic test result rate for each department.*/

select 
       department_name,
	   count(*) total,
	   count(case when result_status='abnormal' then 1 end) as abnormal_count,
	   cast(count(case when result_status='abnormal' then 1 end)*100.0/count(*) as decimal(10,2)) as ab_c
from cleaned_patient_diagnostic pd
join cleaned_admission a on pd.admission_id=a.admission_id
join cleaned_department d on a.department_id=d.department_id
group by department_name;

/* 21. Find departments where the average bill amount is higher than the hospital-wide average bill amount. */ 

select 
	 department_name,
	 avg(total_amount) avg_bill
from cleaned_admission a 
join cleaned_billing b on a.admission_id=b.admission_id
join cleaned_department d on a.department_id=d.department_id
group by department_name
having avg(total_amount)>(select avg(total_amount) from cleaned_billing);

/* 22. Find the department with the 2nd highest total revenue. */

WITH dept_rev AS (
    SELECT d.department_name, SUM(b.total_amount) AS revenue
    FROM cleaned_Billing b
    JOIN cleaned_Admission a ON b.admission_id = a.admission_id
    JOIN cleaned_Department d ON a.department_id = d.department_id
    GROUP BY d.department_name
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (ORDER BY revenue DESC) AS rnk
    FROM dept_rev
)
SELECT department_name, revenue
FROM ranked
WHERE rnk = 2;

/* 23. For each specialization, find the top 2 doctors by number of tests conducted. */

WITH doc_counts AS (
    SELECT doc.doctor_id, doc.specialization, COUNT(pd.patient_diagnostic_id) AS test_count
    FROM cleaned_Doctor doc
    JOIN cleaned_Patient_Diagnostic pd ON doc.doctor_id = pd.doctor_id
    GROUP BY doc.doctor_id, doc.specialization
),
ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY specialization ORDER BY test_count DESC) AS rn
    FROM doc_counts
)
SELECT specialization, doctor_id, test_count
FROM ranked
WHERE rn <= 2
ORDER BY specialization, rn;

/* 24. Show a cumulative count of admissions per month across the year. */

SELECT month, monthly_admissions,
       SUM(monthly_admissions) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM (
    SELECT CONVERT(varchar(7), admission_date, 120) AS month, COUNT(*) AS monthly_admissions
    FROM cleaned_Admission
    GROUP BY CONVERT(varchar(7), admission_date, 120)
) m
ORDER BY month;

/* 25. Find patients with 3 or more admissions occurring within any 90-day window. */

WITH ordered AS (
    SELECT patient_id, admission_id, admission_date,
           ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY admission_date) AS rn
    FROM cleaned_Admission
),
third_prior AS (
    SELECT o1.patient_id, o1.admission_id, o1.admission_date,
           o2.admission_date AS admission_2_back
    FROM ordered o1
    JOIN ordered o2 ON o1.patient_id = o2.patient_id AND o2.rn = o1.rn - 2
)
SELECT DISTINCT patient_id
FROM third_prior
WHERE DATEDIFF(day, admission_2_back, admission_date) <= 90;


/*26. Pairs of doctors in the same specialization with identical test counts*/

with cte as (
select 
      d.doctor_id,specialization,
	  count(*) total
from cleaned_doctor d
join cleaned_patient_diagnostic p
on d.doctor_id=p.doctor_id
group by d.doctor_id,specialization
)
select c1.doctor_id as d1 ,c2.doctor_id as d2,c1.specialization,c1.total
from cte c1
join cte c2 
on c1.specialization =c2.specialization
	and c1.total=c2.total
	and c1.doctor_id<c2.doctor_id

