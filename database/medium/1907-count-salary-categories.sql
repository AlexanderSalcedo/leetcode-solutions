-- Write your PostgreSQL query statement below
with categ as (
    select account_id,
            case
                when income < 20000  then 'Low Salary'
                when 20000 <= income and income <= 50000 then 'Average Salary'
                else 'High Salary'
            end category
    from accounts
),
categories(category) as (
    VALUES
        ('Low Salary'),
        ('Average Salary'),
        ('High Salary')
    
)
select a.category,
        count(b.category) accounts_count
from categories a
left join categ b on a.category = b.category
group by a.category
