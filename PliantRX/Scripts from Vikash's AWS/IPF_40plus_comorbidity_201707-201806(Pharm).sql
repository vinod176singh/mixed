select extract(year from from_dt),CASE
    WHEN DATE_PART(MONTH, from_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct pat_id) from
(select distinct pat_id, from_dt from #temp2
where diag_admit in ('J84112','51631'))  where extract(year from from_dt) in ('2017','2017')
group by 1,2 order by 1,2

select distinct pat_id from (select distinct pat_id, from_dt from #temp2
where diag_admit in ('J84112','51631')) where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt) >6

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


create table #temp as
select * from pharmetrics.ipf_claims where pat_id in 
(select distinct pat_id from pharmetrics.ipf_claims ic where pat_id in (select distinct pat_id from pharmetrics.ipf_diag ic))


select count(distinct A.pat_id) as TPS , count(distinct B.pat_id) as Fourty_Plus  , count(distinct C.pat_id) as Lung_Transplant,
count(distinct D.pat_id) as Lung_Cancer,count(distinct E.pat_id) as COPD,count(distinct F.pat_id) as PH ,
count(distinct G.pat_id) as Heart_Failure, count( distinct H.pat_id) as All_comorbidities from 
(select distinct pat_id from (select distinct pat_id, from_dt from #temp2
where diag_admit in ('J84112','51631')) where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) A 
left join 
(select distinct pat_id from pharmetrics.enroll where  (2023 - der_yob) > 40) B on A.pat_id=B.pat_id 
left join 
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Transplant')) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) C 
on A.pat_id=C.pat_id and B.pat_id=C.pat_id
left join 
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Cancer')) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) D 
on A.pat_id=D.pat_id and B.pat_id=D.pat_id
left join 
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD')) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) E 
on A.pat_id=E.pat_id and B.pat_id=E.pat_id
left join 
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Pulmonary Hypertension')) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) F
on A.pat_id=F.pat_id and B.pat_id=F.pat_id
left join 
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Heart Failure')) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6) G
on A.pat_id=G.pat_id and B.pat_id=G.pat_id
left join
(select distinct pat_id from (select distinct pat_id,from_dt from #temp2 where diag_admit in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 
where description in ('Heart Failure','Pulmonary Hypertension','COPD','Lung Cancer','Lung Transplant'))) 
where extract(year from from_dt) in ('2017') and DATE_PART(MONTH, from_dt)>6 ) H
on A.pat_id=H.pat_id and B.pat_id=H.pat_id
