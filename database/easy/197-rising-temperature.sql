-- Write your PostgreSQL query statement below
select a.id as Id
from Weather a
inner join Weather b on (a.recordDate - interval '1 day')::date = b.recordDate
where a.temperature > b.temperature
