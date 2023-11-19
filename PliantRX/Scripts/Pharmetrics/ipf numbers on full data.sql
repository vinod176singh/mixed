select 'FULL DATA-1DX' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where pat_id in (select pat_id from pharmetrics.ipf_diag) 
union all
select 'FULL DATA-2DX' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where pat_id in (select pat_id from pharmetrics.ipf_diag) and diag1 <>'' and diag2 <>''
union all
select 'FULL DATA-TX' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
)
union all
select 'FULL DATA-(DX+TX)' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
 ) and pat_id in (select pat_id from pharmetrics.ipf_diag)
union all
select 'FULL DATA-(DX/TX)' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
 ) or pat_id in (select pat_id from pharmetrics.ipf_diag);

select * from pharmetrics.ndc_codes limit 10;

with ipf_first_drug as (
select mkted_prod_nm,min(from_dt) as from_dt, pat_id  from pharmetrics.ipf_claims a
inner join pharmetrics.ndc_codes b on a.ndc=b.ndc
where prod_custom_lvl1_desc='IPF' and pat_id in (select pat_id from pharmetrics.ipf_diag) 
group by pat_id,mkted_prod_nm)
select mkted_prod_nm,date_trunc('year',from_dt) as from_dt ,count(distinct pat_id) as pat_cnt
from ipf_first_drug group by 1,2 order by 2;

select * from pharmetrics.ndc_codes limit 10;
with ipf_first_drug as (
select mkted_prod_nm,min(from_dt) as from_dt, pat_id  from pharmetrics.ipf_claims a
inner join pharmetrics.ndc_codes b on a.ndc=b.ndc
where prod_custom_lvl1_desc='IPF'
group by pat_id,mkted_prod_nm)
select * from (select mkted_prod_nm,extract(year from from_dt) as from_dt ,count(distinct pat_id) as pat_cnt 
from ipf_first_drug group by 1,2)
pivot (max(pat_cnt) for from_dt in ('2014','2015','2016','2017','2018','2019','2020','2021','2022'));

select * from pharmetrics.ndc_codes limit 10;
with ipf_first_drug as (
select mkted_prod_nm,min(from_dt) as from_dt, pat_id  from pharmetrics.ipf_claims a
inner join pharmetrics.ndc_codes b on a.ndc=b.ndc
where prod_custom_lvl1_desc='IPF' and pat_id in (select pat_id from pharmetrics.ipf_diag)
group by pat_id,mkted_prod_nm)
select * from (select mkted_prod_nm,extract(year from from_dt) as from_dt ,count(distinct pat_id) as pat_cnt 
from ipf_first_drug group by 1,2)
pivot (max(pat_cnt) for from_dt in ('2014','2015','2016','2017','2018','2019','2020','2021','2022'));


select rend_spec,count(distinct pat_id) from pharmetrics.ipf_claims where pat_id in (select pat_id from pharmetrics.ipf_diag)
group by rend_spec order by 2 desc;

select count(distinct rend_id) from pharmetrics.ipf_claims where pat_id in (select pat_id from pharmetrics.ipf_diag)
 
