-- Write your PostgreSQL query statement below
(select c.name as results
from MovieRating a
left join Movies b on a.movie_id = b.movie_id
left join Users c on a.user_id = c.user_id
group by c.name 
order by count(1) desc, c.name asc
limit 1)
union all
(select b.title as results
from MovieRating a
left join Movies b on a.movie_id = b.movie_id
left join Users c on a.user_id = c.user_id
where cast(a.created_at as varchar) like '2020-02%'
group by b.title
order by avg(a.rating) desc, b.title asc
limit 1)
