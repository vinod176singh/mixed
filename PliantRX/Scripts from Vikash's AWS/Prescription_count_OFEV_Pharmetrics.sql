select * into #temp403 from pharmetrics.ofev_table where pat_id in (select distinct pat_id from pharmetrics.ofev_table ot where ndc in( 
select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')) and ('J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)or
'51631' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)or
'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)or
'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)or
'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12));


select distinct extract(year from from_dt),count(distinct claimno) from pharmetrics.ofev_table where ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='OFEV') and trim(claimno)<>'' group by 1 order by 1 

drop table #final_tb1130;
select * into #temp404 from pharmetrics.ofev_table where ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='OFEV')


select distinct a.pat_id,a.claimno,a.ndc,a.from_dt as claim_dt,b.from_dt as diag_dt,b.diag_admit, b.diag1, b.diag2, b.diag3, b.diag4,b.diag5, b.diag6, b.diag7, b.diag8, b.diag9, b.diag10, b.diag11, b.diag12 
into #final_tb1130 from #temp404 a
inner join
#temp403 b on a.pat_id=b.pat_id and b.from_dt=a.from_dt
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table if exists #final_tb1130;
select distinct a.pat_id,a.claimno,a.ndc,a.from_dt as claim_dt,b.from_dt as diag_dt,b.diag_admit, b.diag1, b.diag2, b.diag3, b.diag4,b.diag5, b.diag6, b.diag7, b.diag8, b.diag9, b.diag10, b.diag11, b.diag12 
into #final_tb1130 from #temp404 a
inner join
#temp403 b on a.pat_id=b.pat_id and b.from_dt between dateadd(day,-30,a.from_dt) and dateadd(day,30,a.from_dt)
--select distinct * from #final_tb1130 where pat_id='0dyasfnsq54iudve' order by claim_dt,diag_dt;
drop table if exists #final_tb1130;
drop table if exists #temp2;
drop table if exists #temp3;
drop table if exists #temp4;
drop table if exists #temp5;
drop table if exists #temp6;
drop table if exists #temp55;


select distinct * into #temp2 from(
select * from(
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag_admit FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag1 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag2 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag3 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag4 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag5 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag6 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag7 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag8 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag9 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag10 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag11 FROM #final_tb1130
UNION 
SELECT distinct pat_id,claim_dt,diag_dt,claimno,diag12 FROM #final_tb1130) where claimno<>'') where diag_admit IN('J84112','J84170','M3481','J8410','51631')

select distinct * ,ABS(DATEDIFF(day, claim_dt, diag_dt)) into #temp3 from #temp2

select * from #temp6 where pat_id='0dyasfnsq54iudve' order by claim_dt ,diag_dt

select distinct a.* into #temp4 from #temp3 a
inner join
(select pat_id,claim_dt,min(distinct abs) from #temp3 group by 1,2)b on a.pat_id=b.pat_id and a.claim_dt=b.claim_dt and b.min=a.abs

select distinct * from #temp6 where pat_id='0dyasfnsq54iudve' order by claim_dt

select a.* into #temp55 from #temp4 a
inner join
(select distinct pat_id,claim_dt,min(distinct diag_dt) diag_dt from #temp4 t group by 1,2)b 
on a.pat_id=b.pat_id and a.claim_dt=b.claim_dt and a.diag_dt=b.diag_dt

select * from #temp6
0dyasfnsq54iudve

drop table #temp55

SELECT 
*,
CASE diag_admit
WHEN 'J84112' THEN 1
WHEN '51631' THEN 1
WHEN 'J8410' THEN 2
WHEN 'M3481' THEN 3
WHEN 'J84170' THEN 4
END AS diag_priority into #temp5
FROM #temp55 

select distinct * from pharmetrics.ofev_table where pat_id='at5kz5dgacs5icxx' order by from_dt 

select pat_id,claim_dt,diag_dt,claimno,min(diag_priority) as priority_no into #temp6 from #temp5 group by 1,2,3,4

select extract(year from claim_dt),count(distinct claimno)as priority_no from #temp6 where priority_no=4 group by 1 order by 1;

select * from #temp6;

drop table #temp6

select priority_no,count(distinct claimno) from #temp6 group by 1 order by 2 desc;
