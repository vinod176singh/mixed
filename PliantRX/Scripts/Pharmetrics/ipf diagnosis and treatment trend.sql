select from_dt ,count(distinct pat_id) from (
select pat_id ,date_trunc('year',min_from_dt) as from_dt from pharmetrics.ipf_diag )
group by from_dt 
order by from_dt; 


select from_dt ,count(distinct pat_id) from (
select pat_id ,date_trunc('month',min(from_dt)) as from_dt from pharmetrics.ipf_claims  
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
group by pat_id)
group by from_dt 
order by from_dt; 

select from_dt ,count(distinct pat_id) from (
select a.pat_id ,date_trunc('month',from_dt) as from_dt from pharmetrics.ipf_claims a
--inner join pharmetrics.ipf_diag b on a.pat_id=b.pat_id 
where  ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
and (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112'))
group by from_dt 
order by from_dt; 
