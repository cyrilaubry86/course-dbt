with product_in_orders as (
    select
        order_id,
        count(product_id) as product_in_orders
    from {{ ref('stg_order_items')}}
    group by 1
)

select
    orders.order_id,
    orders.user_id,
    orders.promo_id,
    orders.address_id,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_id,
    orders.shipping_service,
    orders.estimated_delivery_at,
    orders.delivered_at,
    orders.status,
    p.product_in_orders
from {{ ref('stg_orders')}} as orders
left join product_in_orders as p
    using(order_id)