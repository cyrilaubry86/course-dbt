select
    events.session_id,
    events.order_id,
    coalesce(events.product_id, order_items.product_id) as product_id,
    timing.session_started_at,
    timing.session_ended_at,
    {{ event_type('stg_events', 'event_type') }}
    datediff('minute', timing.session_started_at, timing.session_ended_at) as session_length_minutes
from {{ ref('stg_events')}} as events
left join {{ ref('stg_order_items')}} as order_items
    on order_items.order_id = events.order_id
left join {{ ref('int_session_timing')}} timing
    on timing.session_id = events.session_id
group by 1, 2, 3, 4, 5