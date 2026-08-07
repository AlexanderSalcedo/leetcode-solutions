-- Write your PostgreSQL query statement below
select a.user_id buyer_id,
        a.join_date,
        case when count(b.buyer_id) is not null then count(b.buyer_id) else 0 end orders_in_2019
from users a
left join orders b on a.user_id = b.buyer_id and date_part('year', b.order_date) = 2019
left join items c using (item_id)
--where date_part('year', b.order_date) = 2019
group by a.user_id, 
        a.join_date
order by a.user_id asc
