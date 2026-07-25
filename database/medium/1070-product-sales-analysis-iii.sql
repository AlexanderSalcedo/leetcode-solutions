-- Write your PostgreSQL query statement below
with rank as (
    select  sale_id,
            product_id,
            year,
            dense_rank() over(partition by product_id order by year asc) year_rank
    from Sales
)
select a.product_id,
        a.year first_year,
        a.quantity,
        a.price
from Sales a
inner join rank b on a.sale_id = b.sale_id
where b.year_rank = 1
