--Dx
select distinct B.place_of_svc_nm,count(distinct A.patient_id) from 
(select distinct patient_id,min(svc_dt) as svc_dt from laad_data.dx_claim where diag_cd in ('J84112','51631')
group by 1) A 
inner join laad_data.dx_claim B on A.patient_id=B.patient_id and B.diag_cd in ('J84112','51631') and A.svc_dt=B.svc_dt
group by 1 order by 2 desc

--Procedure
select distinct place_of_svc_nm,count(distinct prc_cd) from laad_data.dx_claim where patient_id in 
(select distinct patient_id from laad_data.dx_claim where 
diag_cd in ('J84112','51631')) and prc_cd in (select distinct prc_cd from laad_data.procedure_utilization)
group by 1 order by 2 desc

select distinct place_of_svc_nm,count(distinct prc_cd) from laad_data.dx_claim where patient_id in 
(select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631')) 
and prc_cd in (select distinct prc_cd from laad_data.procedure_utilization)
and diag_cd in ('J84112','51631')
group by 1 order by 2 desc

