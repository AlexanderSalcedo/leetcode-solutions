-- Write your PostgreSQL query statement below
select b.name name
from Employee a
left join Employee b on a.managerId = b.id
where a.managerId is not null
group by b.id, b.name
having count(b.id) >= 5
