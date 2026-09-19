-- Write your PostgreSQL query statement below
with bas as (
    select a.product_id product1_id ,
            b.product_id product2_id ,
            count(distinct a.user_id) customer_count
    from ProductPurchases a
    inner join ProductPurchases b on a.user_id = b.user_id and a.product_id < b.product_id
    group by 1, 2
    having count(distinct a.user_id) > 2
)
select a.product1_id,
        a.product2_id,
        b.category product1_category ,
        c.category product2_category ,
        a.customer_count
from bas a
left join ProductInfo b on a.product1_id = b.product_id
left join ProductInfo c on a.product2_id = c.product_id
order by customer_count desc, product1_id, product2_id
