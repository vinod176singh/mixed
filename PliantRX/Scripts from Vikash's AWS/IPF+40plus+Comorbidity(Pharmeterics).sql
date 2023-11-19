

create table #temp2 as 
select * FROM(
select distinct  pat_id, diag_admit,from_dt from(
SELECT distinct  pat_id, diag_admit,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id,diag1,from_dt from #temp
UNION 
SELECT distinct pat_id,diag2,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,diag3,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,diag4,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, diag5,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, diag6,from_dt FROM  #temp
UNION
SELECT distinct  pat_id,diag7,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, diag8,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, diag9,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id,diag10,from_dt FROM #temp
UNION 
SELECT distinct  pat_id, diag11,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,diag12,from_dt from #temp)) where diag_admit <>''

create table #temp3 as 
select * FROM(
select distinct  pat_id, proc_cde,from_dt from(
SELECT distinct  pat_id, proc_cde,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id,icdprc1,from_dt from #temp
UNION 
SELECT distinct pat_id,icdprc2,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,icdprc3,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,icdprc4,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, icdprc5,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, icdprc6,from_dt FROM  #temp
UNION
SELECT distinct  pat_id,icdprc7,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, icdprc8,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id, icdprc9,from_dt FROM  #temp
UNION 
SELECT distinct  pat_id,icdprc10,from_dt FROM #temp
UNION 
SELECT distinct  pat_id, icdprc11,from_dt FROM  #temp
UNION 
SELECT distinct pat_id,icdprc12,from_dt from #temp)) where proc_cde <>''

select * from #temp limit 10

create table #temp as
select * from pharmetrics.ipf_claims where pat_id in 
(select distinct pat_id from pharmetrics.ipf_claims ic where pat_id in (select distinct pat_id from pharmetrics.ipf_diag ic))


select extract(year from from_dt),count(distinct A.pat_id) as TPS , count(distinct B.pat_id) as Fourty_Plus  , count(distinct C.pat_id) as Lung_Transplant,
count(distinct D.pat_id) as Lung_Cancer,count(distinct E.pat_id) as COPD,count(distinct F.pat_id) as PH ,
count(distinct G.pat_id) as Heart_Failure, count( distinct H.pat_id) as All_comorbidities from 
(select distinct min(from_dt) as from_dt , pat_id from #temp2 where diag_admit in ('J84112','51631') group by 2) A 
left join 
(select distinct pat_id from pharmetrics.enroll where  (2023 - der_yob) > 40) B on A.pat_id=B.pat_id 
left join 
(select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Transplant')) C 
on A.pat_id=C.pat_id and B.pat_id=C.pat_id
left join 
(select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Cancer')) D 
on A.pat_id=D.pat_id and B.pat_id=D.pat_id
left join 
(select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD')) E 
on A.pat_id=E.pat_id and B.pat_id=E.pat_id
left join 
(select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Pulmonary Hypertension')) F
on A.pat_id=F.pat_id and B.pat_id=F.pat_id
left join 
(select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Heart Failure')) G
on A.pat_id=G.pat_id and B.pat_id=G.pat_id
left join
(select distinct pat_id from #temp2 where pat_id in (select distinct pat_id from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 
where description in ('Heart Failure','Pulmonary Hypertension','COPD','Lung Cancer','Lung Transplant'))) 
) H
on A.pat_id=H.pat_id and B.pat_id=H.pat_id
group by 1
