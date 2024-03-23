{{
  config(
    materialized='table'
  )
}}

SELECT 
    DISCOUNT,
    PROMO_ID,
    STATUS
FROM {{ source('snowflake', 'promos') }}