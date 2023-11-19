select * from laad_data.provider limit 10;

select * into laad_data.dx_claim_ipf  from laad_data.dx_claim dc  
where patient_id in (select distinct patient_id  from laad_data.dx_claim dc  
where diag_cd in ('51631','J84112'));

select left(svc_dt,4),count(distinct patient_id) from laad_data.dx_claim_ipf 
where diag_cd in ('51631','J84112') 
group by 1;

select svc_dt  from laad_data.dx_claim limit 10;          

with ipf_data as(
select distinct patient_id,svc_dt,rendering_provider_id,referring_provider_id,billing_provider_id,facility_provider_id  from laad_data.dx_claim_ipf  
where diag_cd in ('51631','J84112') 
)
--,ifp_gt1 as 
--(select patient_id from laad_data.dx_claim_ipf dc  
--where diag_cd in ('51631','J84112') group by patient_id having count(distinct patient_id||svc_dt)>2)
select left(svc_dt,4) as Pat_yr,count(distinct p.provider_id),count(distinct dc.patient_id)  from ipf_data dc 
inner join laad_data.provider p  on p.provider_id =dc.rendering_provider_id
or p.provider_id =dc.referring_provider_id or p.provider_id =dc.billing_provider_id or p.provider_id =dc.facility_provider_id  
where p.pri_spcl_desc  like '%PULM%' --and patient_id in (select patient_id from ifp_gt1)
group by 1 order by 1,2 desc ,3 desc;


with ipf_data as(
select distinct patient_id,svc_dt,rendering_provider_id,referring_provider_id,billing_provider_id,facility_provider_id  from laad_data.dx_claim_ipf  
where diag_cd in ('51631','J84112') 
),ifp_gt1 as 
(select patient_id from laad_data.dx_claim_ipf dc  
where diag_cd in ('51631','J84112') group by patient_id having count(distinct patient_id||svc_dt)>2)
select count(distinct p.provider_id) as HCP,count(distinct dc.patient_id) as Patients  from ipf_data dc 
inner join laad_data.provider p  on p.provider_id =dc.rendering_provider_id
or p.provider_id =dc.referring_provider_id or p.provider_id =dc.billing_provider_id or p.provider_id =dc.facility_provider_id  
where p.pri_spcl_desc  like '%PULM%' --and patient_id in (select patient_id from ifp_gt1)
--group by 1 order by 1,2 desc ,3 desc;