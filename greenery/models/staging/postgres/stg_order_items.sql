{{
  config(
    materialized='table'
  )
}}

SELECT 
    ORDER_ID,
    PRODUCT_ID,
    QUANTITY
FROM {{ source('snowflake', 'order_items') }}