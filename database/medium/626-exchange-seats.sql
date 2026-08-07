-- Write your PostgreSQL query statement below
with comp as (
    select id,
            student,
            lag(student) over(order by id) student_m,
            lead(student) over(order by id) student_p
    from Seat
)
select  id,
        case
            when id%2 != 0 then coalesce(student_p, student)
            else coalesce(student_m, student)
        end student
from comp
