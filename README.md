# 🏥 Healthcare Analytics Dashboard

An End-to-End Healthcare Business Intelligence Solution using Python, SQL Server, and Power BI.

# 📖 Table of Contents

Project Overview

Business Problem

Project Objectives

Dataset Description

Project Architecture

Python Workflow

SQL Data Analysis

Power BI Data Model

Dashboard Pages

Dashboard Screenshots

Key Business Insights

Technologies Used

Skills Demonstrated

Repository Structure

Future Enhancements

# 📌 Project Overview

This project presents an end-to-end Healthcare Analytics solution developed using Python, SQL Server, and Power BI.

The objective was to transform healthcare data covering patients, admissions, billing, departments, diseases, doctors, diagnostics, beds, wards, drugs, and prescriptions into meaningful financial, patient, revenue, and hospital operational insights.

The project follows a practical Business Intelligence workflow, beginning with raw healthcare data and ending with an interactive Power BI dashboard that supports business and operational decision-making.

# 🎯 Business Problem

Healthcare organizations generate large amounts of data across patient admissions, billing, insurance, doctors, departments, diagnostics, prescriptions, diseases, wards, and hospital beds.

However, raw healthcare data makes it difficult for hospital management to quickly understand operational and financial performance.

Business stakeholders need answers to questions such as:

Which departments generate the highest revenue?

Which patients have the highest hospital billing?

How are admissions changing over time?

Which age groups have the highest number of admissions?

How much revenue is covered by insurance?

How much is payable by patients?

Which wards have high bed occupancy?

Which diseases are most common?

Which doctors conduct the most diagnostic tests?

Which drugs are prescribed most frequently?

Which patients are readmitted within 30 days?

How is hospital revenue performing month-over-month and year-over-year?

This project addresses these challenges through a complete Python → SQL Server → Power BI analytics workflow.

# 🎯 Project Objectives

Clean and preprocess healthcare data using Python

Perform Exploratory Data Analysis (EDA)

Perform feature engineering for healthcare analysis

Load cleaned datasets into SQL Server

Perform advanced SQL business analysis

Analyze patient and admission behavior

Analyze hospital billing and revenue

Analyze insurance and patient payable amounts

Analyze bed occupancy and hospital capacity

Analyze diseases, diagnostics, doctors, drugs, and prescriptions

Develop reusable DAX measures

Implement Time Intelligence in Power BI

Build an interactive 5-page healthcare dashboard

Generate actionable business and operational insights

# 📊 Dataset Description

The project uses multiple related healthcare datasets covering different areas of hospital operations.

# Patient Data

Patient ID

Patient demographics

Gender

Blood Group

Patient information

# Admission Data

Admission ID

Patient ID

Department ID

Disease ID

Admission Date

Discharge Date

Admission Type

Length of Stay

Age Band

# Billing Data

Admission ID

Bill Date

Total Amount

Insurance Covered Amount

Patient Payable Amount

Payment Mode

Payment Status

Insurance Coverage Percentage

# Doctor Data

Doctor ID

Specialization

Department Data

Department ID

Department Name

# Ward & Bed Data

Ward ID

Ward Name

Bed ID

Total Beds

Bed Status

# Disease Data

Disease ID

Disease Name

Disease Category

# Diagnostic Data

Patient Diagnostic ID

Doctor ID

Admission ID

Result Status

# Drug & Prescription Data

Drug ID

Drug Name

Drug Category

Unit Cost

Prescription information

# Feature Engineering

Business-friendly analytical fields were created during preprocessing, including:

Age Band

Length of Stay

Insurance Coverage %

Patient Payable Amount

Payment Status

Admission Type

Disease Category

Bed Occupancy Status

🏗 Project Architecture

                    Raw Healthcare Data
                             │
                             ▼
                   Python Data Preparation
                             │
                 ┌───────────┴───────────┐
                 ▼                       ▼
          Data Cleaning                EDA
                 │                       │
                 └───────────┬───────────┘
                             ▼
                    Feature Engineering
                             │
                             ▼
                       SQL Server
                             │
                    Advanced SQL Analysis
                             │
                             ▼
                    Power BI Data Model
                             │
                       DAX Measures
                             │
                    Time Intelligence
                             │
                             ▼
              Interactive Healthcare Dashboard

# 🐍 Python Workflow

Python was used to prepare the healthcare datasets for SQL Server and Power BI analysis.

## Data Cleaning

The preprocessing workflow included:

Loading healthcare datasets

Inspecting dataset structure

Checking missing values

Checking data types

Converting date columns

Standardizing data types

Cleaning analytical fields

Preparing cleaned datasets

Performing consistency checks

## Exploratory Data Analysis

EDA included:

Univariate Analysis

Bivariate Analysis

Distribution Analysis

Correlation Analysis

Outlier Analysis

Categorical Analysis

Numerical Analysis

Date-based Analysis

## Feature Engineering

Business-oriented features were prepared, including:

Age Band

Length of Stay

Insurance Coverage %

Patient Payable Amount

Payment Status

Admission Type

Disease Category

Bed Occupancy Status

# 🗄 SQL Data Analysis

The cleaned healthcare datasets were analyzed in SQL Server to solve real-world healthcare business problems.

The SQL analysis connects:

Patients

Admissions

Billing

Departments

Diseases

Doctors

Diagnostics

Beds

Wards

Drugs

Prescriptions

Business Analysis

SQL analysis includes:

Top departments by total billing revenue

Patients with above-average hospital billing

Disease-level financial and operational analysis

Patients readmitted within 30 days

Patients who never received prescriptions

Payment mode performance

Beds with long vacancy periods

Ward occupancy analysis

Patients with no insurance coverage

Doctors ranked by diagnostic test volume

Most common blood group by department

Abnormal diagnostic result rate by department

Most expensive drug by category

Departments with above-average billing

Second-highest revenue department

Advanced SQL Concepts

The project demonstrates:

JOIN

LEFT JOIN

CTE

CASE

HAVING

Subqueries

EXISTS

NOT EXISTS

UNION

DATEDIFF

LAG()

ROW_NUMBER()

RANK()

DENSE_RANK()

Window Functions

Running Totals

Ranking within Groups

Date-based Analysis

Advanced analysis also includes:

Running monthly hospital revenue

Month-over-month revenue growth

Top doctors within each specialization

Cumulative monthly admissions

Patients with multiple admissions within a 90-day window

High-bill uninsured patients

Abnormal diagnostic risk identification

# 📈 Power BI Data Model

The Power BI report brings together the cleaned healthcare datasets into an interactive analytical model.

Main Tables

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

DAX & Time Intelligence

The report contains 29+ DAX measures for healthcare performance analysis.

Key calculations include:

Total Revenue

Total Admissions

Total Patients

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

Previous Month Revenue

MoM Growth %

YoY Growth %

Total Beds

Occupied Beds

Total Prescriptions

Total Doctors

# 📊 Dashboard Pages

## 1️⃣ Executive Dashboard

Provides a high-level overview of hospital performance.

KPIs

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

## 2️⃣ Financial Analysis

Focuses on hospital revenue, insurance coverage, patient payable amounts, and billing performance.

KPIs

Total Revenue

Total Insurance Covered

Total Patient Payable

Average Bill

Paid Bills

Visuals

Insurance Covered vs Patient Payable

Insurance and Patient Payable by Month

Total Patient Payable by Department

Department Financial Performance Table

## 3️⃣ Patient Analysis

Provides insights into patient demographics and admission behavior.

KPIs

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

## 4️⃣ Revenue & Time Intelligence

Focuses on revenue trends and time-based performance.

KPIs

Revenue MTD

Revenue YTD

Revenue Last 90 Days

MoM Growth %

YoY Growth %

Visuals

Revenue Growth Trend

Revenue vs Previous Month Revenue

Monthly Revenue Performance Table

Revenue Time Intelligence Summary

## 5️⃣ Hospital Operations

Provides an operational overview of beds, diseases, doctors, and prescriptions.

KPIs

Total Beds

Occupied Beds

Bed Occupancy %

Total Prescriptions

Total Doctors

Visuals

Disease Distribution

Top 10 Prescribed Drugs

Doctors per Department

Disease Performance Table

# 📷 Dashboard Screenshots

## 🏠 Executive Dashboard

![Executive Dashboard](HealthCare%20ScreenShots/Executive%20Dashboard.png)

----

## 💰 Financial Analysis

![Financial Analysis](HealthCare%20ScreenShots/Financial%20Analysis.png)


----

## 👨‍⚕️ Patient Analysis

![Patient Analysis](HealthCare%20ScreenShots/Patient%20Analysis.png)



----

## 📈 Revenue & Time Intelligence

![Revenue & Time Intelligence](HealthCare%20ScreenShots/Revenue%20%26%20Time%20Intelligence.png)



----

## 🏥 Hospital Operations

![Hospital Operations](HealthCare%20ScreenShots/Hospital%20Operations.png)

----

# 📌 Key Business Insights

Surgery generated the highest department-level revenue in the dashboard analysis.

Senior Citizens represent the largest admission age group.

Emergency and elective admissions show different monthly patterns.

Insurance-covered amounts represent a significant component of hospital billing.

Patient payable amounts vary across departments.

Monthly revenue fluctuates throughout the year.

MTD, YTD, previous-month, MoM, and YoY metrics provide different perspectives on revenue performance.

Bed occupancy provides visibility into hospital capacity utilization.

Infectious diseases represent the largest disease category shown in the dashboard.

Prescription analysis identifies the most frequently prescribed drugs.

Doctor diagnostic-test volume can be compared across departments.

SQL analysis provides deeper visibility into readmissions, billing, insurance, diagnostics, bed utilization, and prescription activity.

# 🛠 Technologies Used

Technology

Purpose

## Python

Data Cleaning, EDA & Feature Engineering

Pandas

Data Manipulation

NumPy

Numerical Computing

Matplotlib

Exploratory Data Analysis

Seaborn

Exploratory Data Analysis

## SQL Server

Data Storage & Business Analysis

T-SQL

Advanced Healthcare Analysis

## Power BI

Dashboard Development

DAX

KPI & Time Intelligence Calculations

GitHub

Version Control

# 💡 Skills Demonstrated

Data Cleaning

Data Wrangling

Exploratory Data Analysis

Feature Engineering

SQL Query Writing

Multi-table Joins

CTEs

Subqueries

EXISTS / NOT EXISTS

Window Functions

Ranking Functions

Date-based Analysis

Healthcare Business Analysis

Power BI Data Modeling

DAX Measures

Time Intelligence

KPI Development

Interactive Dashboard Design

Business Intelligence Reporting

# 📂 Repository Structure

Healthcare-Analytics-Dashboard
│
├── Python
│   └── Healthcareipynb.ipynb
│
├── SQL
│   ├── healthcare queriessql.sql
│   └── healthcare2.sql
│
├── Power BI
│   └── HealthCare.pbix
│
├── Screenshots
│   ├── 01_Executive_Dashboard.png
│   ├── 02_Financial_Analysis.png
│   ├── 03_Patient_Analysis.png
│   ├── 04_Revenue_Time_Intelligence.png
│   └── 05_Hospital_Operations.png
│
├── README.md
│
└── LICENSE

🚀 Future Enhancements

Deploy dashboard to Power BI Service

Implement Row-Level Security (RLS)

Add hospital revenue forecasting

Add predictive patient readmission modeling

Build an automated ETL pipeline

Enable scheduled data refresh

Add patient risk scoring

Develop a mobile dashboard layout

⭐ If you found this project helpful, feel free to star the repository!
