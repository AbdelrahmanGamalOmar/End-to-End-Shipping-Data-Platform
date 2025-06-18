from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.mysql.transfers.mysql_to_gcs import MySQLToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.providers.google.cloud.operators.gcs import GCSDeleteObjectsOperator
from airflow.operators.dummy import DummyOperator
from airflow.operators.bash import BashOperator
from airflow.sensors.filesystem import FileSensor
from dotenv import load_dotenv
import os

# Configuration
load_dotenv()

PROJECT_ID = os.getenv('PROJECT_ID')
DATASET_ID = os.getenv('DATASET_ID')
GCS_BUCKET = os.getenv('GCS_BUCKET')
MYSQL_CONNECTION_ID = os.getenv('MYSQL_CONNECTION_ID') 
GCP_CONNECTION_ID = os.getenv('GCP_CONNECTION_ID')

# dbt Configuration
DBT_PROJECT_DIR = "/opt/airflow/dbt_project"
DBT_PROFILES_DIR = "/opt/airflow/dbt_profiles"

# List of tables to extract
TABLES = [
    'vendors', 'employees', 'vehicles', 'fuel_purchases', 'warehouses',
    'service_area', 'customers', 'maintenance_records', 'service_area_zip_codes', 'shipments',
    'delivery_routes', 'insurance_claims', 'customer_service_tickets', 'packages', 'route_stops',
    'invoices', 'inventory'
]

# Default arguments
default_args = {
    'owner': 'analytics_team',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
}

# Create DAG
dag = DAG(
    'mysql_to_bigquery_el_pipeline',
    default_args=default_args,
    description='EL Pipeline: Extract from MySQL and Load to BigQuery',
    schedule_interval='0 2 * * *',  # Daily at 2 AM
    catchup=False,
    tags=['EL', 'MySQL', 'BigQuery', 'Raw Data'],
    max_active_runs=1,
)

# Start task
start_task = DummyOperator(
    task_id='start_pipeline',
    dag=dag,
)

# Create tasks for each table
extract_load_tasks = []
cleanup_tasks = []

for table in TABLES:
    # Extract from MySQL to GCS
    extract_task = MySQLToGCSOperator(
        task_id=f'extract_{table}_to_gcs',
        mysql_conn_id=MYSQL_CONNECTION_ID,
        sql=f'SELECT * FROM {table}',
        bucket=GCS_BUCKET,
        filename=f'mysql_extracts/{table}/{{{{ ds }}}}/{table}.csv',
        schema_filename=f'mysql_extracts/{table}/{{{{ ds }}}}/{table}_schema.json',
        export_format='csv',
        field_delimiter=',',
        gzip=False,
        dag=dag,
    )
    
    # Load from GCS to BigQuery
    load_task = GCSToBigQueryOperator(
        task_id=f'load_{table}_to_bigquery',
        bucket=GCS_BUCKET,
        source_objects=[f'mysql_extracts/{table}/{{{{ ds }}}}/{table}.csv'],
        destination_project_dataset_table=f'{PROJECT_ID}.{DATASET_ID}.{table}',
        source_format='CSV',
        create_disposition='CREATE_IF_NEEDED',
        write_disposition='WRITE_TRUNCATE',  
        skip_leading_rows=1,
        autodetect=True,
        gcp_conn_id=GCP_CONNECTION_ID,
        dag=dag,
    )
    
    # Cleanup GCS files after successful load
    cleanup_task = GCSDeleteObjectsOperator(
        task_id=f'cleanup_{table}_gcs_files',
        bucket_name=GCS_BUCKET,
        prefix=f'mysql_extracts/{table}/{{{{ ds }}}}/',
        gcp_conn_id=GCP_CONNECTION_ID,
        dag=dag,
    )
    
    # Set EL dependencies
    start_task >> extract_task >> load_task >> cleanup_task >> extract_load_complete


# === dbt Transformation Phase ===

# dbt deps - Install dbt packages
dbt_deps = BashOperator(
    task_id='dbt_deps',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt deps --profiles-dir {DBT_PROFILES_DIR}',
    dag=dag,
)

# dbt snapshot - Run snapshots for slowly changing dimensions
dbt_snapshot = BashOperator(
    task_id='dbt_snapshot',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt snapshot --profiles-dir {DBT_PROFILES_DIR}',
    dag=dag,
)

# dbt run - Run staging layer first
dbt_run_staging = BashOperator(
    task_id='dbt_run_staging',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --profiles-dir {DBT_PROFILES_DIR} --select models/stg/',
    dag=dag,
)

# dbt run - Run core layer
dbt_run_intermediate = BashOperator(
    task_id='dbt_run_core',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --profiles-dir {DBT_PROFILES_DIR} --select models/core/',
    dag=dag,
)

# dbt run - Run mart layer
dbt_run_marts = BashOperator(
    task_id='dbt_run_marts',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --profiles-dir {DBT_PROFILES_DIR} --select models/*_mart/',
    dag=dag,
)

# dbt docs generate - Generate documentation
dbt_docs_generate = BashOperator(
    task_id='dbt_docs_generate',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt docs generate --profiles-dir {DBT_PROFILES_DIR}',
    dag=dag,
)

# End task
end_task = DummyOperator(
    task_id='end_pipeline',
    dag=dag,
)

# Set dbt transformation dependencies
extract_load_complete >> dbt_deps
dbt_deps >> dbt_snapshot
dbt_snapshot >> dbt_run_staging
dbt_run_staging >> dbt_run_core
dbt_run_core >> dbt_run_marts
dbt_run_marts >> dbt_docs_generate
dbt_docs_generate >> end_task