-- Write your PostgreSQL query statement below
with base as (
    select distinct
            employee_id,
            (last_value(rating) over(partition by employee_id order by review_date rows between unbounded preceding and unbounded following) -
            nth_value(rating, 3) over(partition by employee_id order by review_date desc rows between unbounded preceding and unbounded following)) improvement_score,
            count(review_id) over(partition by employee_id) cnt
    from performance_reviews
    group by 1, review_date, rating, review_id
)
select  a.employee_id,
        b.name,
        a.improvement_score
from base a
inner join employees b using(employee_id)
where cnt > 2 and a.improvement_score > 1
order by improvement_score desc, name asc
