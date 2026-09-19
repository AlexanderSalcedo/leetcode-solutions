-- Write your PostgreSQL query statement below
select user_id,
       round(avg(case when activity_type = 'free_trial' then activity_duration end), 2) trial_avg_duration ,
       round(avg(case when activity_type = 'paid' then activity_duration end), 2) paid_avg_duration 
from UserActivity
where activity_type in ('free_trial', 'paid')
group by 1
having count(distinct activity_type) = 2
order by user_id
