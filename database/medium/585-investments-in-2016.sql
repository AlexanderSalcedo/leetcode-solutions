-- Write your PostgreSQL query statement below
with pid_rep as (
    select tiv_2015
    from Insurance
    group by tiv_2015
    having count(pid) > 1
),
lat_lon_uni as (
    select lat, lon
    from insurance
    group by 1,2
    having count(pid) = 1
)
select round(sum(tiv_2016)::numeric,2) tiv_2016  
from Insurance a
inner join pid_rep b on a.tiv_2015 = b.tiv_2015
inner join lat_lon_uni c on a.lat = c.lat and a.lon = c.lon
