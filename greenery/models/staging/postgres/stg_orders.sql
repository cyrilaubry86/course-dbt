{{
  config(
    materialized='table'
  )
}}

SELECT 
    ADDRESS_ID,
    CREATED_AT,
    DELIVERED_AT,
    ESTIMATED_DELIVERY_AT,
    ORDER_COST,
    ORDER_ID,
    ORDER_TOTAL,
    PROMO_ID,
    SHIPPING_COST,
    SHIPPING_SERVICE,
    STATUS,
    TRACKING_ID,
    USER_ID
FROM {{ source('snowflake', 'orders') }}