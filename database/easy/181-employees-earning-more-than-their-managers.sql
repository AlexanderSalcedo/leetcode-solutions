-- Write your PostgreSQL query statement below
select a.name employee
from Employee a
inner join Employee b on a.managerId = b.id
where a.salary > b.salary
