-- Write your PostgreSQL query statement below
with ref as (
    select id
    from Customer
    where referee_id != 2 or referee_id is null
)
select name
from Customer 
inner join ref on Customer.id = ref.id
