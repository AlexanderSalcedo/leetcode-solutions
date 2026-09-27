-- Write your PostgreSQL query statement below
with base as (
    select a.employee_id,
            b.employee_name,
            b.department,
            date_trunc('week', a.meeting_date)::date semana,
            a.duration_hours 
    from meetings a
    left join employees b using(employee_id)
),
cantidad as (
    select employee_id,
            employee_name,
            department,
            --sum(duration_hours) sum_duration_hours,
            count(employee_id) over(partition by employee_id) meeting_heavy_weeks
    from base
    group by 1,2,3, semana
    having sum(duration_hours) > 20
)
select distinct *
from cantidad
where meeting_heavy_weeks > 1
order by meeting_heavy_weeks desc, employee_name asc
