-- Write your PostgreSQL query statement below
with empl as (
    select *
    from Employees
    where manager_id is not null and salary < 30000
)
select a.employee_id--a.*, b.employee_id
from empl a
left join Employees b on a.manager_id = b.employee_id
where b.employee_id is null
order by a.employee_id asc
