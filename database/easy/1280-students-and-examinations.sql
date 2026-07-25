/* Write your T-SQL query statement below */
select a.student_id,
        a.student_name,
        b.subject_name,
        count(c.subject_name ) as attended_exams 
from Students a
cross join Subjects b 
left join Examinations c on a.student_id = c.student_id and b.subject_name = c.subject_name
--left join Subjects c on a.subject_name = 
group by 1,2,3
order by 1 asc, 3 
