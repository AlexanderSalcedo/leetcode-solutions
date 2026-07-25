-- Write your PostgreSQL query statement below
select to_char(trans_date, 'YYYY-MM') as month,
       country,
       count(case when country is not Null then country else '0' end) as trans_count,
       count(case when state = 'approved' then state end) as approved_count,
       sum(amount) as trans_total_amount,
       sum(case when state = 'approved' then amount else 0 end ) as approved_total_amount
from Transactions 
group by to_char(trans_date, 'YYYY-MM'),
         country
