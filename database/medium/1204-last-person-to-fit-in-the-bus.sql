-- Write your PostgreSQL query statement below
with sa as (
    select *,
            sum(weight) over(order by turn) sum_ac
    from queue
)
select person_name
from sa
where sum_ac <= 1000
order by turn desc
limit 1
