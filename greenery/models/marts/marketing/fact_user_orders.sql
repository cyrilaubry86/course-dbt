with user_order as (
    select
        user_id,
        min(created_at) as first_order_created_at,
        max(created_at) as last_order_created_at,
        sum(order_cost) as total_spend,
        count(order_id) as number_of_orders
    from {{ ref('stg_orders')}}
    group by 1
),

products_purchased as (
    select
        orders.user_id,
        count(order_items.product_id) as products_purchased
    from {{ ref('stg_order_items')}} as order_items
    left join {{ ref('stg_orders')}} as orders
        using(order_id)
    group by 1
)

select
    users.user_id,
    user_order.number_of_orders is not null as is_buyer,
    coalesce(user_order.number_of_orders, 0) >= 2 as is_frequent_buyer,
    user_order.first_order_created_at,
    user_order.last_order_created_at,
    user_order.number_of_orders,
    coalesce(user_order.total_spend, 0) as total_sprend,
    coalesce(pp.products_purchased, 0) as products_purchased
from {{ ref('stg_users')}} as users
left join user_order
    using(user_id)
left join products_purchased pp
    using(user_id)