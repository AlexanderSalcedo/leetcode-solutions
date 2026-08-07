-- Write your PostgreSQL query statement below
with tot as (
    select accepter_id id , 
            count(accepter_id) num
    from RequestAccepted
    group by accepter_id
    union all
    select requester_id id , 
            count(requester_id) num
    from RequestAccepted
    group by requester_id
)
select id, sum(num) num
from tot
group by id
order by 2 desc
limit 1
