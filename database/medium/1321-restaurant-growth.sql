-- Write your PostgreSQL query statement below
with sum_ac as (
    select visited_on,
            sum(amount) sum_amount
    from customer
    group by visited_on
),
rank as (
    select visited_on,
            sum_amount,
            row_number() over(order by visited_on) rn,
            sum(sum_amount) over (order by visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) sum_win
    from sum_ac
)
select visited_on, 
       sum_win amount,
       round(sum_win/7,2) average_amount
from rank
where rn >= 7
