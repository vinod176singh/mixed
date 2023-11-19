--Analyze the time it takes to develop IPF after the diagnosis of other ILDs.
--drop table #temp1;

create table #temp1 as
select distinct pat_id ,min(from_dt) as ild_min_dt,max(from_dt) as max_ild_dt from pharmetrics.claims c where 
'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12) or
'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12) or
'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)  group by 1;

select count(distinct pat_id ) from #temp1

create table #temp2 as
select distinct pat_id from pharmetrics.ipf_diag id 
except
select a.pat_id from
(select * from #temp1)a
inner join 
pharmetrics.ipf_diag b on a.pat_id=b.pat_id  
where b.min_from_dt  > a.ild_min_dt;

create table #tt as
select a.* from #temp1 a
inner join 
pharmetrics.ipf_diag b on a.pat_id=b.pat_id  
where b.min_from_dt  > a.ild_min_dt;

select count(distinct pat_id ) from #tt

----
select count(distinct a.pat_id) from #temp1 a
inner join 
pharmetrics.ipf_diag b on a.pat_id=b.pat_id  
where b.min_from_dt  < a.ild_min_dt;

select distinct pat_id from #tt
intersect
select distinct pat_id from #temp3;

select count(distinct a.pat_id) from #tt a
inner join 
pharmetrics.ipf_diag b on a.pat_id=b.pat_id  
where b.min_from_dt  > a.ild_min_dt and a.max_ild_dt > b.min_from_dt;

create table #temp3 as
select a.pat_id,a.min_from_dt,b.ild_min_dt from
(pharmetrics.ipf_diag a
inner join 
(select * from #temp1) b on a.pat_id=b.pat_id  and a.min_from_dt  < b.ild_min_dt);

----------------

select distinct a.pat_id,b.ild_min_dt from
(#temp2 a
inner join 
(select * from #temp3) b on a.pat_id=b.pat_id  )
---------------------------------------------------------------------------------------------

--4,143 OFEV treated Patients: How many did not have any ILD diagnosis (-+ 0 to 30 days)


select distinct pat_id  from pharmetrics.claims c 
where ndc in (select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm = 'OFEV')
except 
select pat_id  from #temp1; 

------------------
create table #temp4 as
select c.* from pharmetrics.claims c 
inner join 
(select pat_id,min(from_dt) as rx_dt from pharmetrics.claims c 
where ndc in (select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm = 'OFEV') group by 1)b on c.pat_id=b.pat_id
where from_dt between dateadd(day,-30,rx_dt) and dateadd(day,30,rx_dt)


select count(distinct pat_id) from #temp4 where 
'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12) or
'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12) or
'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
--------------------------------------------------------------------------------------

--drop table #temp5;

create table #temp5 as 
select * from pharmetrics.claims c2 where pat_id in
(select distinct pat_id  from pharmetrics.claims c 
where ndc in (select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm = 'OFEV')
except 
select pat_id  from #temp1); 

select * into #temp6 from
(select b.* from (
(select pat_id,min(distinct from_dt) as rx_dt from pharmetrics.claims c 
where ndc in (select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm = 'OFEV') group by 1)c
inner join 
(select * from #temp5)b on c.pat_id =b.pat_id and c.rx_dt =b.from_dt))

--select * from #temp6 order by 1 desc

select distinct diag_admit ,count(distinct pat_id)from(
SELECT distinct pat_id,diag_admit FROM #temp6
UNION 
SELECT  distinct pat_id,diag1 FROM #temp6
UNION 
SELECT  distinct pat_id,diag2 FROM #temp6
UNION 
SELECT distinct pat_id,diag3 FROM #temp6
UNION 
SELECT  distinct pat_id,diag4 FROM #temp6
UNION 
SELECT distinct pat_id,diag5 FROM #temp6
UNION 
SELECT distinct pat_id,diag6 FROM #temp6
UNION 
SELECT distinct pat_id,diag7 FROM #temp6
UNION 
SELECT distinct pat_id,diag8 FROM #temp6
UNION 
SELECT distinct pat_id,diag9 FROM #temp6
UNION 
SELECT distinct pat_id,diag10 FROM #temp6
UNION 
SELECT  distinct pat_id,diag11 FROM #temp6
UNION 
SELECT  distinct pat_id,diag12 FROM #temp6) group by 1 order by 2 desc;

------------------------------------------------------------------

--ILD_IPF_ILD
select count(distinct a.pat_id) from #temp1 a
inner join 
pharmetrics.ipf_diag b on a.pat_id=b.pat_id  
where b.min_from_dt  > a.ild_min_dt and a.max_ild_dt > b.min_from_dt;



--IPF_ILD_IPF
create table #ipf1 as
select distinct pat_id,min(from_dt) as min_diag_dt,max(from_dt) as max_diag_dt from pharmetrics.claims WHERE  
('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)) group by 1

select count(distinct a.pat_id) from #ipf1 b
inner join 
#temp1 a on a.pat_id=b.pat_id  
where b.min_diag_dt  < a.ild_min_dt and b.max_diag_dt > a.ild_min_dt;


select dx_cd,diagnosis_desc from pharmetrics.dx_lookup dl where dx_cd in ('J8410','J84170','M3481')