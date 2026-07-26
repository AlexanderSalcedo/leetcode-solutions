-- Write your PostgreSQL query statement below
with sal as (
    select *,
            dense_rank() over(order by salary desc) escala
    from Employee
)
select max(salary) SecondHighestSalary 
from sal
where escala = 2
