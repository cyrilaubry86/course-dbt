select
    events.session_id,
    events.order_id,
    coalesce(events.product_id, order_items.product_id) as product_id,
    timing.session_started_at,
    timing.session_ended_at,
    sum(case when events.event_type = 'page_view' then 1 else 0 end) as page_view,
    sum(case when events.event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when events.event_type = 'checkout' then 1 else 0 end) as checkout,
    sum(case when events.event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
    datediff('minute', timing.session_started_at, timing.session_ended_at) as session_length_minutes
from {{ ref('stg_events')}} as events
left join {{ ref('stg_order_items')}} as order_items
    on order_items.order_id = events.order_id
left join {{ ref('int_session_timing')}} timing
    on timing.session_id = events.session_id
group by 1, 2, 3, 4, 5