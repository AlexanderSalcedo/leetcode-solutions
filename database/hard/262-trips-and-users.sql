-- Write your PostgreSQL query statement below
with not_banned as (
    select a.*
    from Trips a
    left join b on (a.cliente_id = b.user_id or a.driver_id = b.user_id)
    where b.banned <> 'Yes' 
)
select 
a.request_at as "Day",
       count(a.status)/count(a.status) as "Cancellation Rate"
from Trips a
left join Users b on a.client_id = b.users_id
where b.banned <> 'Yes' and 
      a.request_at in ('2013-10-01', '2013-10-02', '2013-10-03')
group by Day
