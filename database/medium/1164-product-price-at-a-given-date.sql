with rank as (
    select product_id,
            new_price,
            change_date,
            row_number() over(partition by product_id order by change_date desc) rn
    from products
    where change_date <= '2019-08-16'
),
uniq as (
    select product_id
    from products
    group by product_id 
)
select a.product_id,
        coalesce(b.new_price, 10) price
from uniq a
left join rank b on a.product_id = b.product_id and b.rn = 1
order by 1
