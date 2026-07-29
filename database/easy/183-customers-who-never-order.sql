-- Write your PostgreSQL query statement below
select a.name Customers
from Customers a
left join Orders b on b.customerId = a.id
where b.customerId is null
