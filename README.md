🏥 Healthcare Analytics — Patient & Hospital Performance Dashboard — Patient & Hospital Performance Dashboard

An end-to-end healthcare analytics project built to analyze hospital operations, patient behavior, admissions, billing, revenue, diseases, prescriptions, doctors, diagnostics, beds, wards, and payment performance.

The project follows a practical analytics workflow:

Raw CSV Data → Python Data Cleaning & Feature Engineering → SQL Server Business Analysis → Power BI Data Model & DAX → Interactive Dashboard

📌 Project Overview

Healthcare organizations generate data across many operational areas such as patient registration, admissions, billing, departments, wards, diagnostics, prescriptions, doctors, diseases, and beds.

The objective of this project is to transform these separate datasets into a centralized analytical solution that helps answer questions such as:

Which departments generate the most revenue?

Which diseases contribute the most admissions and revenue?

How are hospital admissions changing over time?

What percentage of beds are occupied?

How much revenue is covered by insurance versus patients?

Which patients have high hospital spending?

Which patients are readmitted within 30 days?

Which doctors conduct the most diagnostic tests?

Which wards have high occupancy?

What are the most frequently prescribed drugs?

How is revenue performing month-over-month and year-over-year?

Which payment modes generate the most revenue?

Which patients have abnormal diagnostic results or high financial risk?

🎯 Business Objectives

The project focuses on five major business areas:

1. Financial Performance

Analyze hospital revenue, billing, insurance coverage, patient payable amounts, payment status, payment modes, and average bills.

2. Patient Analytics

Understand patient demographics, age groups, gender distribution, admission behavior, length of stay, and readmission patterns.

3. Revenue & Time Intelligence

Track monthly revenue, MTD, YTD, previous-month revenue, last-90-day revenue, MoM growth, and YoY growth.

4. Hospital Operations

Monitor bed availability, occupancy, departments, wards, doctors, diagnostic activity, prescriptions, and diseases.

5. Advanced SQL Business Analysis

Use joins, CTEs, subqueries, EXISTS, NOT EXISTS, window functions, ranking, LAG(), running totals, conditional aggregation, and date-based analysis to solve business problems.

🗂️ Dataset

The project uses multiple related healthcare CSV datasets.

Dataset

Records

Purpose

Patient

30,000

Patient demographics and basic information

Admission

45,000

Hospital admissions and admission details

Billing

45,000

Hospital billing and payment information

Doctor

98

Doctor specialization and experience

Department

11

Hospital departments

Ward

27

Hospital wards and bed capacity

Disease

20

Diseases and disease categories

Patient Diagnostic

63,269

Diagnostic tests and results

Bed

415

Bed allocation and occupancy

Drug

250

Drug details and cost

Prescription

73,109

Prescriptions associated with admissions

The notebook loads the datasets separately and performs cleaning and transformation before exporting cleaned CSV files.

🛠️ Technology Stack

Python

Pandas

NumPy

Matplotlib / Seaborn where applicable

Jupyter / Google Colab

SQL

Microsoft SQL Server

SQL Server Management Studio (SSMS)

Power BI

Power Query / Data Model

DAX

Interactive visualizations

Time intelligence

Slicers

KPI cards

Matrix/Table visuals

Drill-through/navigation design

Version Control

Git / GitHub

🔄 Project Workflow

                RAW HEALTHCARE CSV FILES
                         │
                         ▼
              ┌──────────────────────┐
              │ Python / Pandas      │
              │ Data Cleaning        │
              │ Data Validation      │
              │ Feature Engineering  │
              └──────────┬───────────┘
                         │
                         ▼
                 CLEANED CSV FILES
                         │
                         ▼
              ┌──────────────────────┐
              │ SQL Server           │
              │ Cleaned Tables       │
              │ Business Analysis    │
              │ Advanced SQL Queries │
              └──────────┬───────────┘
                         │
                         ▼
              ┌──────────────────────┐
              │ Power BI             │
              │ Data Model           │
              │ DAX Measures         │
              │ Time Intelligence    │
              └──────────┬───────────┘
                         │
                         ▼
              ┌──────────────────────┐
              │ Interactive Dashboard│
              │ 5 Analytical Pages   │
              └──────────────────────┘

🐍 1. Python — Data Cleaning & Feature Engineering

The Python notebook loads the healthcare CSV files into Pandas DataFrames and performs exploratory inspection and transformation.

Data inspection

The workflow includes:

Loading individual CSV datasets

Inspecting the first rows

Checking dataset dimensions

Reviewing data types

Checking descriptive statistics

Examining categorical distributions

Converting date columns into datetime format

Standardizing text values

Examples of date columns converted to datetime include:

date_of_birth

admission_date

discharge_date

bill_date

test_date

Data Cleaning

The patient dataset contains a contact_number field that was removed from the analytical dataset.

The notebook also performs transformations such as:

Date conversion

Text standardization

Column renaming

Data type handling

Derived analytical columns

Export of cleaned datasets

🧮 Feature Engineering

Several analytical features were created to make the data more useful for SQL and Power BI analysis.

Patient / Admission Features

Age at Admission

Age is calculated using the patient's date of birth and admission date.

Age_at_admission =
((admission_date - date_of_birth).dt.days / 365.25).astype('int64')

Age Group

Patients are categorized into:

Child

Young Adult

Adult

Senior Citizen

Length of Stay

length_of_stay =
(discharge_date - admission_date).dt.days

Stay Category

Admissions are categorized into:

Short

Medium

Long

Extended long

Billing Features

Insurance Coverage Percentage

Insurance_Coverage_Pct =
(insurance_covered_amount / total_amount) * 100

Patient Payment Percentage

Patient_Payment_Pct =
(patient_payable_amount / total_amount) * 100

Coverage Category

Billing records are classified as:

Fully Insured

Self Pay

Partially Insured

Bill Category

Bills are grouped into:

Low

Medium

High

Very High

🗄️ 2. SQL Server — Business Analysis

The cleaned datasets are loaded into SQL Server using the healthcare database and cleaned analytical tables.

The SQL layer is used to answer operational and financial business questions that go beyond simple aggregations.

🔍 SQL Analysis Performed

Revenue Analysis

Examples include:

Top 5 revenue-generating departments

Department revenue contribution

Running hospital revenue

Second-highest revenue department

Departments with above-average bill amounts

Monthly revenue trends

Month-over-month revenue growth

The advanced department analysis combines:

Total revenue

Number of admissions

Average bill

Revenue rank

Revenue contribution

Running revenue

Patient Analysis

The SQL analysis identifies:

Patients spending above the average hospital billing amount

High-spending patients

Patients with multiple admissions

Patients readmitted within 30 days

Patients with 3 or more admissions within a 90-day window

Patients who never received prescriptions

Patients who have never been admitted

Disease Analysis

Analysis includes:

Average length of stay by disease category

Disease distribution across age bands

Disease revenue contribution

Disease admission volume

Disease revenue ranking

Billing & Payment Analysis

The project analyzes:

Revenue by payment mode

Average bill amount

Insurance-covered amount

Patient payable amount

Paid versus pending bills

Paid percentage

Revenue contribution

Patients with no insurance coverage

Outstanding balances

Hospital Operations

SQL analysis also covers:

Bed occupancy by ward

Wards with occupancy above a threshold

Bed vacancy duration

Departments containing highly occupied wards

Doctor diagnostic-test volume

Top doctors by specialization

Doctors who have never conducted diagnostic tests

Diagnostic Analysis

The project analyzes:

Abnormal diagnostic results

Abnormal-result rate by department

Doctors ranked by diagnostic test volume

Patients with abnormal diagnostic results

Prescription & Drug Analysis

Analysis includes:

Most expensive drug in each drug category

Top doctors by diagnostic test volume

Prescription activity

Patients who never received prescriptions

Top prescribed drugs for dashboard reporting

🧠 Advanced SQL Concepts Used

The SQL scripts demonstrate practical interview-level SQL concepts:

INNER JOIN

LEFT JOIN

SELF JOIN

CTE

Subqueries

Correlated subqueries

EXISTS

NOT EXISTS

UNION

CASE

Conditional aggregation

HAVING

DATEDIFF

LAG()

ROW_NUMBER()

RANK()

DENSE_RANK()

Window functions

Running totals

Partitioned ranking

Date-based analysis

Revenue contribution calculations

Examples from the analysis include readmission detection using LAG(), cumulative revenue using window functions, and patient-prescription checks using NOT EXISTS.

📊 3. Power BI Dashboard

The Power BI report contains 5 analytical pages, each designed around a specific business function.

🏠 Page 1 — Executive Dashboard

Provides a high-level overview of hospital performance.

KPI Cards

Total Revenue

Total Admissions

Total Patients

Bed Occupancy %

Revenue Per Patient

Visuals

Total Revenue by Month

Total Revenue by Department

Total Admissions by Age Group

Emergency vs Elective Admissions by Month

Total Revenue by Payment Mode

Filters

Year

Month

Department

This page is designed for management-level monitoring.

💰 Page 2 — Financial Analysis

Focuses on the financial performance of the hospital.

KPI Cards

Total Revenue

Total Insurance Covered

Total Patient Payable

Average Bill

Paid Bills

Visuals

Insurance Covered vs Patient Payable

Insurance and Patient Payable by Month

Total Patient Payable by Department

Department-level financial matrix

Financial Questions Answered

How much revenue is covered by insurance?

How much is payable by patients?

Which departments generate the highest patient payable amount?

How do insurance and patient payments change over time?

What is the average billing amount?

👨‍⚕️ Page 3 — Patient Analysis

Focuses on patient demographics and admission behavior.

KPI Cards

Total Patients

Total Admissions

Average Stay

Emergency Admissions

Elective Admissions

Visuals

Total Patients by Age Group

Total Patients by Gender

Admissions by Department and Stay Category

Monthly Admissions Trend

Filters

Admission Date

Admission Type

Department

This page helps identify demographic and operational admission patterns.

📈 Page 4 — Revenue & Time Intelligence

Designed specifically for revenue trend and time-intelligence analysis.

KPI Cards

Revenue MTD

Revenue YTD

Revenue Last 90 Days

MoM Growth %

YoY Growth %

Visuals

Revenue Growth Trend

Revenue vs Previous Month Revenue

Monthly revenue performance matrix

Time Intelligence

The report compares revenue across time using measures for:

Month-to-date revenue

Year-to-date revenue

Previous month revenue

Last 90 days revenue

Month-over-month growth

Year-over-year growth

A dedicated Date table is used in the Power BI model for time-based analysis.

🏥 Page 5 — Hospital Operations

Focuses on hospital capacity, medical activity, and resources.

KPI Cards

Total Beds

Occupied Beds

Bed Occupancy %

Total Prescriptions

Total Doctors

Visuals

Disease Distribution

Top 10 Prescribed Drugs

Doctors per Department

Disease-level analytical table

Operational Questions Answered

How many beds are available/occupied?

What is the overall bed occupancy rate?

Which diseases are most common?

Which drugs are prescribed most frequently?

Which departments have the highest doctor activity?

📐 Power BI / DAX Analysis

The report uses DAX measures to calculate key business metrics.

Examples of analytical measures include:

Total Revenue
Total Patients
Total Admissions
Revenue Per Patient
Bed Occupancy %
Total Insurance Covered
Total Patient Payable
Average Bill
Paid Bills
Emergency Admissions
Elective Admissions
Average Stay
Revenue MTD
Revenue YTD
Revenue Last 90 Days
MoM Growth %
YoY Growth %
Total Beds
Occupied Beds
Total Prescriptions
Total Doctors

The report also uses Power BI time-intelligence concepts for previous-period comparisons and revenue growth.

🧩 Power BI Model

The report contains analytical tables including:

Cleaned_Patient

Cleaned_Admission

Cleaned_Billing

Cleaned_Doctor

Cleaned_Department

Cleaned_Ward

Cleaned_Disease

Cleaned_Patient_Diagnostic

Cleaned_Bed

Cleaned_Drug

Cleaned_Prescription

Date

The model connects patient, admission, billing, department, ward, disease, diagnostic, doctor, drug, prescription, and bed information to support cross-functional analysis.

🎨 Dashboard Design

The Power BI report uses a consistent dark navy dashboard theme with pink/red accent colors.

Design elements include:

Executive KPI cards

Consistent page navigation

Department and time filters

Interactive slicers

Bar and column charts

Trend charts

Matrix tables

Percentage KPIs

Time-intelligence visuals

Page navigation buttons

Consistent visual hierarchy

The report is structured so that users can move from:

Executive Overview → Financial Analysis → Patient Analysis → Revenue & Time → Hospital Operations

📌 Key Business Insights Enabled

The completed solution allows hospital management to investigate:

Financial

Department revenue performance

Insurance utilization

Patient financial responsibility

Payment completion

Revenue trends

Patient

Patient demographics

Admission types

Length of stay

Readmission behavior

High-spending patients

Medical

Disease distribution

Diagnostic activity

Abnormal test rates

Doctor diagnostic volume

Prescription activity

Operational

Bed occupancy

Ward capacity

Department performance

Doctor activity

Hospital admissions

Time-Based

Monthly revenue

Monthly admissions

MTD revenue

YTD revenue

MoM growth

YoY growth

Previous-month comparisons

📁 Project Files

Suggested repository structure:

Healthcare-Analytics/
│
├── Python/
│   └── Healthcareipynb.ipynb
│
├── SQL/
│   ├── healthcare queriessql.sql
│   └── healthcare2.sql
│
├── PowerBI/
│   └── HealthCare.pbix
│
├── Screenshots/
│   ├── 01_Executive_Dashboard.png
│   ├── 02_Financial_Analysis.png
│   ├── 03_Patient_Analysis.png
│   ├── 04_Revenue_Time_Intelligence.png
│   └── 05_Hospital_Operations.png
│
└── README.md

🚀 End-to-End Implementation

Step 1 — Load Data

Loaded healthcare CSV files into Pandas DataFrames.

Step 2 — Explore Data

Performed:

Shape inspection

Data type inspection

Descriptive statistics

Category distributions

Date inspection

Step 3 — Clean Data

Performed:

Datetime conversion

Text standardization

Removal of unnecessary fields

Data type handling

Analytical column creation

Step 4 — Feature Engineering

Created:

Age at admission

Age groups

Length of stay

Stay categories

Insurance coverage %

Patient payment %

Coverage categories

Bill categories

Step 5 — Export Clean Data

The transformed datasets were exported as cleaned CSV files.

Step 6 — SQL Server

Loaded cleaned datasets into SQL Server and performed business analysis using multiple related tables.

Step 7 — Advanced SQL

Created analytical queries using:

CTEs

Window functions

Ranking

Subqueries

EXISTS

NOT EXISTS

Date calculations

Conditional aggregation

Step 8 — Power BI

Built the analytical model and created DAX measures for KPI and time-intelligence reporting.

Step 9 — Dashboard

Created five interactive Power BI pages covering executive, financial, patient, revenue/time, and operational analysis.

💼 Business Value

This project demonstrates the ability to take a multi-table healthcare dataset and convert it into an end-to-end analytics solution.

The solution combines:

Data Preparation + Business Analysis + SQL + DAX + Data Visualization

rather than focusing only on dashboard creation.

It can help decision-makers monitor financial performance, understand patient behavior, evaluate hospital capacity, and identify operational trends.

🧪 SQL Interview / Analytical Skills Demonstrated

This project also serves as a practical SQL portfolio project because the analysis includes real business-style questions involving:

Top-N analysis

Above-average comparisons

Revenue contribution

Running totals

Readmission analysis

Gaps between admissions

Bed vacancy analysis

EXISTS / NOT EXISTS

Ranking within groups

Second-highest revenue

Rolling/cumulative metrics

Date-difference analysis

Multiple-table joins

Conditional aggregation

📸 Power BI Dashboard Preview

The final Power BI report contains 5 interactive dashboard pages covering executive performance, financial analysis, patient behavior, revenue/time intelligence, and hospital operations.

🏠 1. Executive Dashboard

Provides a management-level overview of hospital performance, including revenue, admissions, patients, bed occupancy, revenue per patient, departmental revenue, age-group admissions, and admission trends.



💰 2. Financial Analysis

Focuses on hospital revenue, insurance coverage, patient payable amounts, average billing, paid bills, and department-level financial performance.



👨‍⚕️ 3. Patient Analysis

Analyzes patient demographics, age groups, gender, admission types, stay categories, departments, and monthly admission trends.



📈 4. Revenue & Time Intelligence

Focuses on MTD, YTD, last-90-day revenue, MoM growth, YoY growth, previous-month comparisons, and monthly revenue performance.



🏥 5. Hospital Operations

Provides an operational view of beds, occupancy, diseases, prescriptions, drugs, doctors, departments, and diagnostic activity.



📊 Dashboard Pages at a Glance

Page

Main Focus

Executive Dashboard

Overall hospital performance

Financial Analysis

Revenue, insurance & billing

Patient Analysis

Patients, admissions & demographics

Revenue and Time Intelligence

MTD, YTD, MoM & YoY

Hospital Operations

Beds, doctors, diseases & prescriptions

🏆 Project Highlights

30K patients

45K admissions

45K billing records

63K+ diagnostic records

73K+ prescriptions

98 doctors

415 beds

250 drugs

11 departments

27 wards

20 diseases

5 Power BI dashboard pages

Advanced SQL business analysis

DAX-based KPI and time-intelligence reporting

End-to-end Python → SQL Server → Power BI workflow

🔧 Tools Used

Tool

Purpose

Python

Data cleaning, transformation & feature engineering

Pandas

Data manipulation

NumPy

Numerical operations

SQL Server

Data storage & business analysis

SSMS

SQL development

Power BI

Data modeling & visualization

DAX

KPIs & time intelligence

GitHub

Project version control

👤 Author

[Dasari Swagath Reddy]

Data Analyst | Data Scientist

Skills Demonstrated

Python Pandas SQL SQL Server Power BI DAX Data Cleaning EDA Data Modeling Time Intelligence Business Analysis

⭐ If you find this project useful

Feel free to explore the SQL queries, Python workflow, and Power BI dashboard to understand the complete analytics pipeline.
