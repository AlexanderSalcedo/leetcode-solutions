-- Write your PostgreSQL query statement below
with rank as (
    select  delivery_id,
            customer_id,
            order_date,
            customer_pref_delivery_date,
            row_number() over(partition by customer_id order by order_date asc) rn
    from delivery
),
class as (
    select case
            when order_date = customer_pref_delivery_date then 1
            else 0
            end clasificacion
    from rank
    where rn = 1
)
select round((sum(clasificacion::numeric)*100)/count(clasificacion), 2)immediate_percentage
from class
