End-to-End Shipping Company Data Platform & Analytics Solution
Project Overview
This project demonstrates the design, development, and implementation of a complete end-to-end data platform for a hypothetical shipping company. It covers the entire data lifecycle, from transactional data capture and mock data generation to robust data warehousing, automated ELT pipelines, and insightful business intelligence dashboards. The goal was to build a scalable and efficient data infrastructure capable of supporting advanced analytics and reporting for key business functions.

Key Features & Components
Database Design & Implementation:

Designed a normalized operational database schema (18 tables) to accurately represent core shipping company entities and relationships.

Implemented the database in MySQL using SQL DDL statements.

Mock Data Generation & Ingestion:

Generated realistic mock transactional data using Python's Faker library.

Loaded mock data into the MySQL operational database using Pandas and SQLAlchemy.

Automated ELT Pipeline with Airflow & dbt:

Developed and orchestrated automated Extract and Load (EL) pipelines using Apache Airflow to efficiently transfer raw data from MySQL to a staging layer within a Google BigQuery data warehouse.

Implemented sophisticated data transformations (T) using dbt (data build tool), establishing a structured data flow:

Staging Layer: Direct representation of source data.

Core Layer: Built a dimensional model (3 fact tables, 8 dimension tables including a dim_date table) optimized for analytical queries.

Slowly Changing Dimensions (SCD Type 2): Handled historical changes for key dimensions to preserve historical accuracy.

Data Marts: Created three subject-oriented data marts (Customer Insights, Logistics, Finance) for targeted departmental reporting.

Business Intelligence & Reporting:

Developed three interactive Power BI dashboards, each connected to its respective data mart in BigQuery.

Visualized key performance indicators (KPIs) and critical insights to empower data-driven decision-making for customer service, logistics operations, and financial management teams.

Technologies Used
Databases: MySQL, Google BigQuery

Orchestration: Apache Airflow

Data Transformation: dbt (data build tool)

Programming Languages: Python (Pandas, SQLAlchemy, Faker)

Business Intelligence: Power BI

Other: SQL

Project Structure
This repository is organized into the following main directories:

.
├── Datawarehouse/
│   └── ERD/                  # Contains the Entity-Relationship Diagrams (ERDs) for the Data Warehouse schema (denormalized).
├── Database/
│   └── ERD/                  # Contains the Entity-Relationship Diagrams (ERDs) for the OLTP Database schema (normalized).
│   └── DDL/                  # Contains SQL Data Definition Language (DDL) statements for creating the MySQL database tables.
├── ELT Pipeline/
│   └── Airflow/              # Contains Apache Airflow DAGs for Extract and Load operations.
│   └── dbt/                  # Contains dbt project files, including models for staging, core, and data mart layers, and SCD logic.
└── PowerBI/
    └── Customer_Insights_Dashboard.pbix  # Power BI dashboard for Customer Insights.
    └── Logistics_Dashboard.pbix        # Power BI dashboard for Logistics operations.
    └── Finance_Dashboard.pbix          # Power BI dashboard for Financial performance.

How to Get Started (High-Level)
Clone the Repository: git clone [repository_url]

Database Setup: Navigate to Database/DDL and execute the SQL scripts in MySQL.

Data Generation & Loading: Run the Python scripts from the Database folder (or a designated scripts folder if applicable in your actual project) to generate and load mock data.

Airflow Setup: Configure Airflow and deploy the DAGs from ELT Pipeline/Airflow.

dbt Setup: Configure dbt, connect to BigQuery, and run the dbt models from ELT Pipeline/dbt.

Power BI: Open the .pbix files in Power BI Desktop and ensure connections to BigQuery are correctly configured.

This README provides a comprehensive overview of the project, highlighting its technical depth and business value, while also clearly detailing the project's file structure for easy navigation.
