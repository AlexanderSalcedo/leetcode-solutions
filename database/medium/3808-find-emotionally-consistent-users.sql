-- Write your PostgreSQL query statement below
with grp1 as ( 
    select user_id,
        reaction,
        count(reaction) cnt_r
    from reactions
    group by 1,2
),
grp2 as (
    select distinct 
            user_id,
            count(user_id) over(partition by user_id) cnt_t
    from reactions
),
grp3 as (
    select a.user_id,
            a.reaction dominant_reaction,
            round(a.cnt_r::numeric/b.cnt_t, 2) reaction_ratio
    from grp1 a
    inner join grp2 b on a.user_id = b.user_id and b.cnt_t > 4
)
select user_id,
        dominant_reaction,
        reaction_ratio
from grp3
where reaction_ratio >= 0.6
order by reaction_ratio desc, user_id asc
