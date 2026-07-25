with ranki as (
    select score,
            row_number() over(order by score desc) ranked
    from Scores
    group by score
    order by score desc
)
select a.score,
        b.ranked rank    
from Scores a
inner join ranki b on a.score = b.score
order by a.score desc
