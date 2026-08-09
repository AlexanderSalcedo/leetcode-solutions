-- Write your PostgreSQL query statement below
with categ as (
    select user_id,
            case
                when action = 'timeout' then 0.0
                else 1.0
            end action
    from Confirmations
)
select a.user_id,
       coalesce(round(sum(b.action)/count(a.user_id), 2), 0) confirmation_rate
from signups a
left join categ b using(user_id)
group by 1
