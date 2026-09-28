-- Write your PostgreSQL query statement below
with base as (
    select departmentId,
            salary,
            name,
            dense_rank() over(partition by departmentId order by salary desc) rn
    from Employee 
)
select b.name Department,
        a.name Employee,
        a.salary Salary 
from base a
inner join Department b on a.departmentId = b.id
where rn <= 3
