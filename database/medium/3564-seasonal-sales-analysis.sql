-- Write your PostgreSQL query statement below
with base as (
    select a.sale_id,
            --b.product_name,
            b.category,
            case 
                when EXTRACT(MONTH FROM a.sale_date) in (12, 1, 2) then 'Winter'
                when EXTRACT(MONTH FROM a.sale_date) in (3, 4, 5) then 'Spring'
                when EXTRACT(MONTH FROM a.sale_date) in (6, 7 ,8) then 'Summer'
                when EXTRACT(MONTH FROM a.sale_date) in (9, 10, 11) then 'Fall'
            end season,
            a.quantity,
            a.price,
            a.quantity*a.price revenue
    from sales a
    left join products b on a.product_id = b.product_id
),
cnt as (
    select season,
        category,
        sum(quantity) as total_quantity,
        sum(revenue) as total_revenue
    from base
    group by season, category
    order by season asc
),
rank as (
    select *,
            row_number() over(partition by season order by total_quantity desc, total_revenue desc, category) rn
    from cnt
)
select season,
        category,
        total_quantity,
        total_revenue
from rank 
where rn = 1
