-- Write your PostgreSQL query statement below
with base as (
    select 
        customer_id,
        count(customer_id) over(partition by customer_id) total_orders,
        round(avg(order_rating) filter(where order_rating is not null) over(partition by customer_id),2) average_rating,
        count(order_rating) filter(where order_rating is not null) over(partition by customer_id) cnt_rated,
        count(customer_id) filter(where ((extract(hour from order_timestamp) >= 11) and (extract(hour from order_timestamp) < 14)) or ((extract(hour from order_timestamp) >= 18) and (extract(hour from order_timestamp) < 21))) over(partition by customer_id) cnt_ph
    from restaurant_orders 
)
select distinct
        customer_id,
        total_orders,
        round(cnt_ph::numeric/total_orders,2)*100 peak_hour_percentage,
        average_rating
from base
where average_rating::numeric >= 4.0
    and cnt_rated::numeric/total_orders >= 0.5
    and round(cnt_ph::numeric/total_orders,2) >= 0.6
    and total_orders >= 3
order by average_rating desc, customer_id desc
