-- Write your PostgreSQL query statement below
with rank as (
    select *,
            row_number() over(order by id asc) ranked
    from Stadium 
    where people >= 100
    order by visit_date asc
),
diff as (
    select id-ranked diff
    from rank
    group by diff
    having count(id) >=3
)
select b.id, b.visit_date, b.people
from rank b
inner join diff c on b.id-b.ranked = c.diff
