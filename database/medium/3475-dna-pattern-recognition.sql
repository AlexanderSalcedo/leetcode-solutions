-- Write your PostgreSQL query statement below
select sample_id,
        dna_sequence,
        species,
        case when dna_sequence like 'ATG%' then count(dna_sequence) else 0 end has_start,
        case when (dna_sequence like '%TAA' or dna_sequence like '%TAG' or dna_sequence like '%TGA') then count(dna_sequence) else 0 end has_stop,
        case when dna_sequence like '%ATAT%' then count(dna_sequence) else 0 end has_atat,
        case when dna_sequence like '%GGG%' then count(dna_sequence) else 0 end has_ggg
from samples
group by 1,2,3,dna_sequence
order by sample_id asc
