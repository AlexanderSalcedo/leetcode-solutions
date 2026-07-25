-- Write your PostgreSQL query statement below
select a.customer_id
from Customer a
inner join Product b on a.product_key = b.product_key
group by 1
having count(distinct a.product_key) = (select count(distinct(product_key)) from Product)
order by 1 asc
