-- Write your PostgreSQL query statement below
with sign as (
    select stock_name,
            operation,
            case when operation = 'Buy' then price * (-1) else price end price
    from stocks
)
select distinct stock_name,
        sum(price) over(partition by stock_name) capital_gain_loss
from sign
