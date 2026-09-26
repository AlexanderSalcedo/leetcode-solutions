-- Write your PostgreSQL query statement below
with base as (
    select driver_id,
            trip_date,
            case when trip_date < '2023-07-01'::date then 'First_half' else 'Second_half' end half,
            distance_km,
            fuel_consumed,
            distance_km/fuel_consumed avg_half
    from trips
),
calc as (
    select driver_id,
            avg(case when half = 'First_half' then avg_half end) first_half_avg,
            avg(case when half = 'Second_half' then avg_half end) second_half_avg
    from base
    group by driver_id
)
select driver_id,
        driver_name,
        round(first_half_avg,2) first_half_avg,
        round(second_half_avg,2) second_half_avg,
        round(second_half_avg - first_half_avg,2) as efficiency_improvement
from calc
inner join drivers using(driver_id)
where first_half_avg is not null and second_half_avg is not null and second_half_avg > first_half_avg
order by efficiency_improvement desc, driver_name
