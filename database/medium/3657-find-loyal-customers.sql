-- Write your PostgreSQL query statement below
with base as (
    select 
        customer_id,
        count(customer_id) over(partition by customer_id) cnt_customer,
        max(transaction_date) over(partition by customer_id) maxfec,
        min(transaction_date) over(partition by customer_id) minfec,
        count(customer_id) filter (where transaction_type = 'refund') over(partition by customer_id) cnt_refund,
        count(customer_id) filter (where transaction_type = 'purchase') over(partition by customer_id) cnt_purchase
    from customer_transactions
    order by customer_id
)
select distinct customer_id
from base
where cnt_refund::numeric/cnt_purchase <= 0.2
    and maxfec - minfec >= 30
    and cnt_purchase >= 3
