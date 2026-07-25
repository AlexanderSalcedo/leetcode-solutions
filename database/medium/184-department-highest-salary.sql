-- Write your PostgreSQL query statement below
with max_sal as (
    select name,
            salary,
            departmentId,
            dense_rank() over(partition by departmentId order by salary desc) order_sal
    from Employee
)
select b.name Department,
        a.name Employee,
        a.salary Salary
from max_sal a
inner join Department b on a.departmentId = b.id
where order_sal = 1
