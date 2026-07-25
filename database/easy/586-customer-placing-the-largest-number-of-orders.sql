/* Write your T-SQL query statement below */
with max_cus as (
select customer_number, count(order_number)
from Orders
group by customer_number
order by count(order_number) desc
limit 1)
select customer_number
from max_cus
