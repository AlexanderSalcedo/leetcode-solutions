-- Write your PostgreSQL query statement below
with base as (
    select patient_id,
            min(test_date) min_posi
    from covid_tests
    where result = 'Positive'
    group by patient_id
)
select a.patient_id,
        c.patient_name,
        c.age,
        min(a.test_date) - b.min_posi recovery_time
from covid_tests a
inner join base b on a.patient_id = b.patient_id 
inner join patients c on a.patient_id = c.patient_id
where a.result = 'Negative' and a.test_date > min_posi
group by a.patient_id, b.min_posi, c.patient_name, c.age
order by recovery_time, c.patient_name
