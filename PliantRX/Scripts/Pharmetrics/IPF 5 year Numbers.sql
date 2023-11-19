create temp table #ipf_diag_5yr as 
select distinct pat_id from pharmetrics.claims where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112') and from_dt between '2017-07-01' and '2022-06-30';

select count(*) from #ipf_diag_5yr;--26199

select count(distinct pat_id) from pharmetrics.claims where pat_id in (select pat_id from #ipf_diag_5yr) and diag1 <>'' and diag2 <>'';

select count(distinct pat_id) from pharmetrics.claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
) and from_dt between '2017-07-01' and '2022-06-30';--4688

select count(distinct pat_id) from pharmetrics.claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
and from_dt between '2017-07-01' and '2022-06-30') and pat_id in (select pat_id from #ipf_diag_5yr); --3481

select count(distinct pat_id) from pharmetrics.claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
and from_dt between '2017-07-01' and '2022-06-30') or pat_id in (select pat_id from #ipf_diag_5yr);--27406

select b.mkted_prod_nm,count(distinct pat_id) from pharmetrics.claims a inner join 
(select distinct ndc,mkted_prod_nm from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF') b 
on a.ndc =b.ndc
where  from_dt between '2017-07-01' and '2022-06-30' 
group by b.mkted_prod_nm;

select b.mkted_prod_nm,count(distinct pat_id) from pharmetrics.claims a inner join 
(select distinct ndc,mkted_prod_nm from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF') b 
on a.ndc =b.ndc
where  from_dt between '2017-07-01' and '2022-06-30'  and pat_id in (select pat_id from #ipf_diag_5yr)
group by b.mkted_prod_nm;

select rend_spec,count(distinct pat_id) from pharmetrics.claims where pat_id in (select pat_id from #ipf_diag_5yr)
and from_dt between '2017-07-01' and '2022-06-30'
group by rend_spec order by 2 desc;