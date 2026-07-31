-- Write your PostgreSQL query statement below
select a.name,
        b.bonus
from Employee a
left join Bonus b using (empId) 
where b.bonus < 1000 or b.bonus is null
