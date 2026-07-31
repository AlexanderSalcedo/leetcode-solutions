-- Write your PostgreSQL query statement below
with prim as (
    select player_id, 
            min(event_date) min_date
    from Activity
    group by player_id
)
select round(count(b.player_id)::numeric/count(*)::numeric,2) fraction
from prim a
left join Activity b on a.player_id = b.player_id and b.event_date = a.min_date + 1
