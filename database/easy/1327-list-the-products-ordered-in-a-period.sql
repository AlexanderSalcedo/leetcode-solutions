-- Write your PostgreSQL query statement below
select b.product_name,
        sum(a.unit) unit
from Orders a
inner join Products b on a.product_id = b.product_id
where a.order_date::varchar like '2020-02%'
group by b.product_name
having sum(a.unit) >= 100
