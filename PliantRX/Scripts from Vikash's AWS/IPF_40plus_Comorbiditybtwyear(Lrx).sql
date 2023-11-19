select count(distinct patient_id) from laad_data.dx_claim where 
patient_id in (select distinct patient_id from (select distinct patient_id ,min(svc_dt::date) as svc_dt from laad_data.dx_claim where 
diag_cd in ('J84112','51631') group by 1) where left(svc_dt,4)='2021')
and patient_id in (select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40 )
and patient_id in (select distinct patient_id from laad_data.dx_claim where prc_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='LungTransplant'))

select count(distinct patient_id) from laad_data.dx_claim where 
patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631'))
and patient_id in (select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40 )
and patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD'))


--2021 857
--2021 589
--2021 985
--2021 1454

select left(A.svc_dt,4),count(distinct A.patient_id) as TPS , count(distinct B.patient_id) as Fourty_Plus  , count(distinct C.patient_id) as Lung_Transplant,
count(distinct D.patient_id) as Lung_Cancer,count(distinct E.patient_id) as COPD,count(distinct F.patient_id) as PH ,
count(distinct G.patient_id) as Heart_Failure, count( distinct H.patient_id) as All_comorbidities from 
(select distinct patient_id,svc_dt from (select distinct min(svc_dt::date) as svc_dt , patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631') group by 2)
where extract(year from svc_dt)='2021') A 
left join 
(select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40) B on A.patient_id=B.patient_id 
left join 
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Transplant')) 
where extract(year from svc_dt) in ('2021')  ) C 
on A.patient_id=C.patient_id and B.patient_id=C.patient_id
left join 
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Cancer')) 
where extract(year from svc_dt) in ('2021')  ) D 
on A.patient_id=D.patient_id and B.patient_id=D.patient_id
left join 
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD')) 
where extract(year from svc_dt) in ('2021')  ) E 
on A.patient_id=E.patient_id and B.patient_id=E.patient_id
left join 
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Pulmonary Hypertension')) 
where extract(year from svc_dt) in ('2021')  ) F
on A.patient_id=F.patient_id and B.patient_id=F.patient_id
left join 
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Heart Failure')) 
where extract(year from svc_dt) in ('2021')  ) G
on A.patient_id=G.patient_id and B.patient_id=G.patient_id
left join
(select distinct patient_id from (select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2
where description in ('Heart Failure','Pulmonary Hypertension','COPD','Lung Cancer','Lung Transplant')))
where extract(year from svc_dt) in ('2021') ) H
on A.patient_id=H.patient_id and B.patient_id=H.patient_id
group by 1 

