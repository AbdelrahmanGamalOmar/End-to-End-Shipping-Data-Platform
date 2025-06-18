{% snapshot scd_stg_employee %}

{{
   config(
       unique_key='employee_id',
       strategy='check',
       check_cols=['job_title', 'department', 'manager_id', 'monthly_salary', 'address'],
       invalidate_hard_deletes=True 
   )
}}

SELECT  *
FROM    {{ ref('employee') }}

{% endsnapshot %}