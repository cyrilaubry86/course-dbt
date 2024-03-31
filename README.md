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