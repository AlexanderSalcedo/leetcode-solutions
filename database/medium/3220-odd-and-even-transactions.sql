-- Write your PostgreSQL query statement below
with categ as (
    select transaction_date,
            amount,
            case
                when amount%2 != 0 then 'odd'
                else 'even'
            end category
    from transactions
)
select transaction_date,
        coalesce(sum(case
            when category = 'odd' then amount
        end), 0) odd_sum,
        coalesce(sum(case
            when category = 'even' then amount
        end), 0) even_sum
from categ
group by 1
order by 1 
