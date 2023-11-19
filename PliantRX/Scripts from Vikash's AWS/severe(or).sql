create table #temp as 
select * from laad_data.dx_claim where patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'))

create table #temp2 as 
select * from #temp where patient_id in 
(select distinct patient_id from #temp where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
type_desc in ('Abnormal LFT','Hepatic Fibrosis','Cirrhosis','Portal Hypertension', 'Varices', 'ENCEPHALOPATHY', 'ASCITES')))

select distinct patient_id from #temp4

--select count(distinct patient_id) from #temp2 where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
--type_desc in ('Cirrhosis','Portal Hypertension', 'Varices', 'ENCEPHALOPATHY', 'ASCITES')) 
----
--
--select 'K8301' as segment, count(distinct patient_id)  from #temp2
--union 
--select 'AIH' as segment, count(distinct patient_id) from #temp2 where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
--type_desc in ('AIH')) 
--union 
--select 'Small duct psc' as segment, count(distinct patient_id) from #temp2 where prc_cd in ('5014','5013','702','47700')
--union 
--select 'Carcinomas' as segment, count(distinct patient_id) from #temp2 where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523  where 
--type_desc in ('Abdominal Cancer','Intestinal Cancer','LB 5 Cancer'))
--union 
--select 'Cirhossis' as segment, count(distinct patient_id) from #temp2 where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
--type_desc in ('Cirrhosis','ENCEPHALOPATHY','Varices','Portal Hypertension','ASCITES'))
--

--Exclusion
create table #temp3 as
select * from #temp2 where patient_id in (select distinct patient_id from #temp2 where patient_id in
(select distinct patient_id from #temp2
except
select distinct patient_id from laad_data.dx_claim where prc_cd in ('5014','5013','702','47700') --small duct PSC
except
select distinct patient_id from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
type_desc in ('AIH', 'Intestinal Cancer','Abdominal Cancer'))))--AIH and Cirhossis


--LB 5 years to remove lb 5 Cancer
create table #temp4 as
select * from laad_data.dx_claim where patient_id in (SELECT DISTINCT A.patient_id
FROM (
    SELECT DISTINCT patient_id, MIN(svc_dt::date) AS min_dt
    FROM #temp3
    WHERE diag_cd ='K8301'
    GROUP BY patient_id
) A
WHERE A.patient_id NOT IN (
    SELECT DISTINCT patient_id
    FROM #temp
    WHERE patient_id = A.patient_id
      AND diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523  where type_desc in ('LB 5 Cancer')) 
      AND svc_dt  BETWEEN DATEADD(YEAR, -5, A.min_dt) AND A.min_dt -- Within the 5-year period prior to A.min_dt
)
)

select count(distinct patient_id) from #temp4 

drop table #temp4

--Yearwise count(K8301+5761)
create table #temp5 as
select * from  #temp where 
patient_id in (select distinct patient_id from #temp4 where diag_cd= 'K8301' )
and patient_id in (select distinct patient_id from #temp4 where diag_cd='5761' )

select extract(year from A.min_dt) , count(distinct B.patient_id) from (select distinct patient_id , MIN(svc_dt::date) as min_dt from #temp5 where 
diag_cd='5761' group by 1) A inner join 
#temp5 B
on A.patient_id = B.patient_id
group by 1 order by 1

--Yearwise count(Only K8301) 
create table #temp6 as
select * from #temp where 
patient_id in (select distinct patient_id from #temp4 where diag_cd='K8301')
and patient_id not in (select distinct patient_id from #temp4 where diag_cd='5761'  )

select extract(year from A.min_dt) , count(distinct B.patient_id) from (select distinct patient_id , MIN(svc_dt::date) as min_dt from #temp6 where 
diag_cd='K8301'  group by 1) A inner join 
#temp6 B
on A.patient_id = B.patient_id
group by 1 order by 1


