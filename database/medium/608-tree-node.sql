-- Write your PostgreSQL query statement below
select a.id,
       case 
        when a.p_id is null then 'Root'
        when b.id is null then 'Leaf'
       else 'Inner'
       end type
from Tree a
left join Tree b on a.id = b.p_id
group by 1,2
