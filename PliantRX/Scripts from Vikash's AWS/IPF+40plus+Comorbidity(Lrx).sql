select count(distinct patient_id) from laad_data.dx_claim where 
patient_id in (select distinct patient_id from (select distinct patient_id ,min(svc_dt::date) as svc_dt from laad_data.dx_claim where 
diag_cd in ('J84112','51631') group by 1) where left(svc_dt,4)='2015')
and patient_id in (select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40 )
and patient_id in (select distinct patient_id from laad_data.dx_claim where prc_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='LungTransplant'))

select count(distinct patient_id) from laad_data.dx_claim where 
patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631'))
and patient_id in (select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40 )
and patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD'))


--2014 857
--2013 589
--2022 985
--2017 1454

select left(A.svc_dt,4),count(distinct A.patient_id) as TPS , count(distinct B.patient_id) as Fourty_Plus  , count(distinct C.patient_id) as Lung_Transplant,
count(distinct D.patient_id) as Lung_Cancer,count(distinct E.patient_id) as COPD,count(distinct F.patient_id) as PH ,
count(distinct G.patient_id) as Heart_Failure, count( distinct H.patient_id) as All_comorbidities from 
(select distinct min(svc_dt::date) as svc_dt , patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631') group by 2) A 
left join 
(select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) > 40) B on A.patient_id=B.patient_id 
left join 
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Transplant')) C 
on A.patient_id=C.patient_id and B.patient_id=C.patient_id
left join 
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Lung Cancer')) D 
on A.patient_id=D.patient_id and B.patient_id=D.patient_id
left join 
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='COPD')) E 
on A.patient_id=E.patient_id and B.patient_id=E.patient_id
left join 
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Pulmonary Hypertension')) F
on A.patient_id=F.patient_id and B.patient_id=F.patient_id
left join 
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description='Heart Failure')) G
on A.patient_id=G.patient_id and B.patient_id=G.patient_id
left join
(select distinct patient_id from laad_data.dx_claim where diag_cd in 
(select distinct dx_code from pharmetrics.comorbid_ipf2 where description in ('Heart Failure','Pulmonary Hypertension','COPD','Lung Cancer','Lung Transplant'))
) H
on A.patient_id=H.patient_id and B.patient_id=H.patient_id
group by 1

select distinct description from pharmetrics.comorbid_ipf2

select distinct * from pharmetrics.comorbid_ipf2 where description in ('Heart Failure','Pulmonary Hypertension','COPD','LungCancer','LungTransplant')