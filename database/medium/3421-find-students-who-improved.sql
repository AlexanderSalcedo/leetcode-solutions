with rank as (
    select student_id,
            subject,
            first_value(score) over(partition by student_id, subject order by exam_date asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) first_score,
            last_value(score) over(partition by student_id, subject order by exam_date asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) latest_score
    from scores
    group by 1,2, score, exam_date
)
select distinct student_id,
        subject,
        first_score,
        latest_score
from rank
where latest_score > first_score
order by 1,2
