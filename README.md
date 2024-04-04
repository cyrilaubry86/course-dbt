# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License
GPL-3.0


How many users do we have?
124

On average, how many orders do we receive per hour?
15.041667

On average, how long does an order take from being placed to being delivered?
93.40 hours

How many users have only made one purchase? Two purchases? Three+ purchases?

one purchase
25

Two purchases
28
Three+ purchases?
71

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?
39.46




Repeat rate is 0.798387
```sql
select
    sum(case when is_buyer then 1 else 0 end) as count_buyer,
    sum(case when is_frequent_buyer then 1 else 0 end) as count_frequent,
    count_frequent / count_buyer as repeat_rate
from dev_db.dbt_cyrilaubry22gmailcom.fact_user_orders;
```




Which products had their inventory change from week 1 to week 2? 

```
PRODUCT_ID
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80
4cda01b9-62e2-46c5-830f-b7f262a58fb1
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3
be49171b-9f72-4fc9-bf7a-9a52e259836b
```

```sql
select
    product_id
from dev_db.dbt_cyrilaubry22gmailcom.products_snapshot
group by 1
having count(inventory) > 1;
```




*week_3

**convertion rate
***overall avg conv rate

```sql
with pre as (

    select
        session_id,
        sum(checkouts) as sum_checkout,
        from dev_db.dbt_cyrilaubry22gmailcom.fact_page_views
    group by 1
    
    )

select
    count(*) as total_session_count,
    sum(case when sum_checkout > 0 then 1 else 0 end) as total_session_with_checkout,
    sum(case when sum_checkout = 0 then 1 else 0 end) as total_session_without_checkout,
    round(total_session_with_checkout / total_session_count::float, 4) * 100 as global_conv_rate
from pre;
```

global conversation rate is 62.46%


***conv rate per product
```sql
with pre as (

    select
        session_id,
        product_id,
        products.name as product_name,
        sum(checkouts) as sum_checkout,
        from dev_db.dbt_cyrilaubry22gmailcom.fact_page_views
        inner join dev_db.dbt_cyrilaubry22gmailcom.stg_products as products
            using(product_id)
    group by 1,2,3
    
    ),

final as (

    select
        product_name,
        count(*) as total_session_count,
        sum(case when sum_checkout > 0 then 1 else 0 end) as total_session_with_checkout,
        sum(case when sum_checkout = 0 then 1 else 0 end) as total_session_without_checkout,
        round(total_session_with_checkout / total_session_count::float, 4) * 100 as conv_rate
    from pre
group by 1
)

select
    product_name,
    conv_rate
from final
order by conv_rate desc;
```

![alt text](<Screenshot 2024-04-04 at 12.54.12.png>)





**macro
![alt text](<Screenshot 2024-04-04 at 13.56.11.png>)


**Snapshot
Which products had their inventory change from week 2 to week 3?\

```sql
select
    *
from dev_db.dbt_cyrilaubry22gmailcom.products_snapshot
where DBT_UPDATED_AT::date >= '2024-04-01';
```

-- product with inventory change
689fb64e-a4a2-45c5-b9f2-480c2155624d
b66a7143-c18a-43bb-b5dc-06bb5d1d3160
be49171b-9f72-4fc9-bf7a-9a52e259836b
4cda01b9-62e2-46c5-830f-b7f262a58fb1
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3