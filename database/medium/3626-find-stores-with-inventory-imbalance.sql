-- Write your PostgreSQL query statement below
with base as (
    select store_id,
            count(store_id) cnt_si,
            min(price) min_p,
            max(price) max_p
    from inventory
    group by store_id
),
calc as(
    select a.store_id,
            c.store_name,
            c.location,
            case when a.price = b.max_p then a.quantity end max_q,
            case when a.price = b.max_p then a.product_name end most_exp_product,
            case when a.price = b.min_p then a.quantity end min_q,
            case when a.price = b.min_p then a.product_name end cheapest_product
    from inventory a
    inner join base b on a.store_id = b.store_id --and (a.price = b.min_p or a.price = b.max_p)
    inner join stores c on a.store_id = c.store_id
    where b.cnt_si >= 3
)
select store_id,
        store_name,
        location,
        max(most_exp_product) most_exp_product,
        max(cheapest_product) cheapest_product,
        round(max(min_q)::numeric/max(max_q)::numeric,2) imbalance_ratio
from calc
group by store_id,
        store_name,
        location
having max(min_q) > min(max_q)
order by round(max(min_q)::numeric/max(max_q)::numeric,2) desc, store_name asc
