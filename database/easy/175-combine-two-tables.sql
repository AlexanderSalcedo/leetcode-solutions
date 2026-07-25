-- Write your PostgreSQL query statement below
select a.lastName,
        a.firstName,
        b.city,
        b.state
from Person a
left join Address b on a.personId = b.personId
