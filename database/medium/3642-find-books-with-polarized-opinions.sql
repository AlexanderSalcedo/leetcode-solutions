-- Write your PostgreSQL query statement below
with base as (
    select  book_id,
            title,
            author,
            genre,
            pages,
            count(book_id) over(partition by book_id) cnt,
            min(session_rating ) over(partition by book_id) min,
            max(session_rating ) over(partition by book_id) max,
            count(*) filter (where session_rating <= 2) over(partition by book_id) cnt_1,
            count(*) filter (where session_rating >= 4) over(partition by book_id) cnt_2
    from reading_sessions 
    inner join books using(book_id)
)
select distinct 
        book_id,
        title,
        author,
        genre,
        pages,
        max - min as rating_spread,
        round((cnt_1+cnt_2)::numeric/cnt, 2) polarization_score
from base
where cnt >= 5 and cnt_1 > 0 and cnt_2 > 0 and round((cnt_1+cnt_2)::numeric/cnt, 2) >= 0.6
order by round((cnt_1+cnt_2)::numeric/cnt, 2) desc, title desc
