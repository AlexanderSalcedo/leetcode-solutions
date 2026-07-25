-- Write your PostgreSQL query statement below
with rank as (
    select id,
            num,
            lead(num, 1) over(order by id asc) r1,
            lead(num, 2) over (order by id asc) r2
    from Logs
    order by id asc
)
select num ConsecutiveNums 
from rank
where num = r1 and num = r2
group by num
