{{
  config(
    materialized='table'
  )
}}

SELECT 
    INVENTORY,
    NAME,
    PRICE,
    PRODUCT_ID
FROM {{ source('snowflake', 'products') }}