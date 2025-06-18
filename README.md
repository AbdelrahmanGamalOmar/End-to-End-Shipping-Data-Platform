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

This repository is organized into the following main directories:
.
├── Datawarehouse/ 
│   └── Shipping_Data_Warehouse_Core_Layer ERD         # Contains the Entity-Relationship Diagrams (ERDs) for the Data Warehouse Core layer (denormalized).  
│   └── Logistics_Mart ERD                             # Contains the Entity-Relationship Diagrams (ERDs) for the Data Warehouse Logistics mart.  
│   └── Finance_Mart ERD                               # Contains the Entity-Relationship Diagrams (ERDs) for the Data Warehouse Finance mart.  
│   └── Customer_Insights_Mart ERD                     # Contains the Entity-Relationship Diagrams (ERDs) for the Data Warehouse Customer Insights mart  
├── Database/  
│   └── Shipping_DB_ERD                    # Contains the Entity-Relationship Diagrams (ERDs) for the OLTP Database schema (normalized).  
│   └── Shipping_DDL                       # Contains SQL Data Definition Language (DDL) statements for creating the MySQL database tables.  
├── ELT Pipeline/  
│   └── Airflow/                           # Contains Apache Airflow DAGs for Extract and Load operations.  
│   └── dbt/                               # Contains dbt project files, including models for staging, core, and data mart layers, and SCD logic.  
└── PowerBI/    **Note:** This section is currently under Development  
└── Customer_Insights_Dashboard.pbix      # Placeholder for Power BI dashboard for Customer Insights.  (in development)  
└── Logistics_Dashboard.pbix              # Placeholder for Power BI dashboard for Logistics operations.  (in development)  
└── Finance_Dashboard.pbix                # Placeholder for Power BI dashboard for Financial performance.  (in development)  
