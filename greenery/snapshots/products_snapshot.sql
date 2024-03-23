{% snapshot products_snapshot %}


{{
  config(
    target_database = 'dev_db',
    target_schema = 'dbt_cyrilaubry22gmailcom',
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

SELECT * FROM {{ source('snowflake', 'products') }}

{% endsnapshot %}