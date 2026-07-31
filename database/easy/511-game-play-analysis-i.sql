-- Write your PostgreSQL query statement below
with rank as (
    select player_id,
            event_date,
            row_number() over(partition by player_id order by event_date asc) rn
    from Activity
)
select player_id,
        event_date as first_login
from rank
where rn = 1
