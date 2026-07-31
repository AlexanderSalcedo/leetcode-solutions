-- Write your PostgreSQL query statement below
with rank as (
    select id,
            email,
            row_number() over(partition by email order by id asc) ranked
    from Person
)
delete from Person
where id not in (select id from rank where ranked = 1)
