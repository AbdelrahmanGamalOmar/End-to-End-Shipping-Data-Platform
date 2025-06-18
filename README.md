# End-to-End Shipping Company Data Platform & Analytics Solution

## Project Overview

This project demonstrates the design, development, and implementation of a complete end-to-end data platform for a hypothetical shipping company. It covers the entire data lifecycle, from transactional data capture and mock data generation to robust data warehousing, automated ELT pipelines, and insightful business intelligence dashboards. The goal was to build a scalable and efficient data infrastructure capable of supporting advanced analytics and reporting for key business functions.

## Key Features & Components

* **Database Design & Implementation:**
    * Designed a normalized operational database schema (18 tables) to represent core shipping company entities and relationships accurately.
    * Implemented the database in MySQL using SQL DDL statements.
* **Mock Data Generation & Ingestion:**
    * Generated realistic mock transactional data using Python's `Faker` library.
    * Loaded mock data into the MySQL operational database using `Pandas` and `SQLAlchemy`.
* **Automated ELT Pipeline with Airflow & dbt:**
    * Developed and orchestrated automated Extract and Load (EL) pipelines using **Apache Airflow** to efficiently transfer raw data from MySQL to a staging layer within a **Google BigQuery** data warehouse.
    * Implemented sophisticated data transformations (T) using **dbt (data build tool)**, establishing a structured data flow:
        * **Staging Layer:** Direct representation of source data.
        * **Core Layer:** Built a dimensional model (3 fact tables, 8 dimension tables, including a `dim_date` table) optimized for analytical queries.
        * **Slowly Changing Dimensions (SCD Type 2):** Handled historical changes for key dimensions to preserve historical accuracy.
        * **Data Marts:** Created three subject-oriented data marts (Customer Insights, Logistics, Finance) for targeted departmental reporting.
* **Business Intelligence & Reporting:**
    * Developed three interactive **Power BI** dashboards, each connected to its respective data mart in BigQuery.
    * Visualized key performance indicators (KPIs) and critical insights to empower data-driven decision-making for customer service, logistics operations, and financial management teams.

## Technologies Used

* **Databases:** MySQL, Google BigQuery
* **Orchestration:** Apache Airflow
* **Data Transformation:** dbt (data build tool)
* **Programming Languages:** Python (Pandas, SQLAlchemy, Faker)
* **Business Intelligence:** Power BI

## Project Structure

This repository is organized into the following main sections:

---

### Datawarehouse
- `ERD/`
  - `shipping_data_warehouse_core_layer_ERD.png` — Core layer ERD (denormalized)
  - `logistics_mart_ERD.png` — Logistics Mart ERD
  - `finance_mart_ERD.png` — Finance Mart ERD
  - `customer_insights_mart_ERD.png` — Customer Insights Mart ERD

---

### Database
  - `Shipping_DB_ERD.png` — ERD for the OLTP schema (normalized)
  - `shipping_DDL.sql` — MySQL table creation scripts

---

### ELT Pipeline
- `Airflow/` — DAGs for Extract & Load operations
- `dbt/` — dbt models for staging, core, and data marts + SCD logic

---

### Power BI Dashboards *(In development)*
- `Customer_Insights_Dashboard.pbix`
- `Logistics_Dashboard.pbix`
- `Finance_Dashboard.pbix`

---

### Mock Data Generator
- `mock_data_generator.ipynb` Creating and loading mock data into MySQL

