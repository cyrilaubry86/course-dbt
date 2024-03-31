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