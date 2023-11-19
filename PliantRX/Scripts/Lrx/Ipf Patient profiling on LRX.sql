select pat_gender_cd,count(distinct patient_id)  from laad_data.patient
where patient_id in (select distinct patient_id from laad_data.dx_claim  
where diag_cd in ('51631','J84112'))
group by pat_gender_cd;



select CASE 
    WHEN (2023 - pat_brth_yr_nbr) <18 THEN '0-17' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 30 AND 44 THEN '30-44'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 45 AND 64 THEN '45-64'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 65 AND 74 THEN '65-74'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 75 AND 84 THEN '75-84'
    WHEN (2023 - pat_brth_yr_nbr) >=85 THEN '85+'
    ELSE    'Unknown'  END AS age_group,
count(distinct patient_id) as tx  from laad_data.patient
where patient_id in (select distinct patient_id from laad_data.dx_claim  
where diag_cd in ('51631','J84112'))
group by age_group
order by age_group;


drop table if exists #ipf_dx_pat;
select distinct patient_id into #ipf_dx_pat from laad_data.dx_claim  
where diag_cd in ('51631','J84112');

select count(*) from #ipf_dx_pat;

drop table if exists #ipf_tx_pat;
select distinct d.patient_id into #ipf_tx_pat  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
and patient_id in (select patient_id from #ipf_dx_pat);

drop table if exists #ipf_non_tx_pat;
select patient_id into #ipf_non_tx_pat  from #ipf_dx_pat
except
select patient_id from #ipf_tx_pat;



;with Tx_age_wise as (
select CASE 
    WHEN (2023 - pat_brth_yr_nbr) <18 THEN '0-17' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 30 AND 44 THEN '30-44'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 45 AND 64 THEN '45-64'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 65 AND 74 THEN '65-74'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 75 AND 84 THEN '75-84'
    WHEN (2023 - pat_brth_yr_nbr) >=85 THEN '85+'
    ELSE    'Unknown'  END AS age_group,
count(distinct patient_id) as tx  from laad_data.patient
where patient_id in (select patient_id from #ipf_tx_pat)
group by age_group
order by age_group)
,non_tx_age_wise as (
select CASE 
    WHEN (2023 - pat_brth_yr_nbr) <18 THEN '0-17' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 30 AND 44 THEN '30-44'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 45 AND 64 THEN '45-64'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 65 AND 74 THEN '65-74'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 75 AND 84 THEN '75-84'
    WHEN (2023 - pat_brth_yr_nbr) >=85 THEN '85+'
    ELSE    'Unknown'  END AS age_group,
count(distinct patient_id) as non_tx  from laad_data.patient
where patient_id in (select patient_id from #ipf_non_tx_pat)
group by age_group
order by age_group)
select a.*,b.non_tx from tx_age_wise a inner join non_tx_age_wise b on a.age_group=b.age_group
order by age_group;

select distinct model_typ_nm, 
case when model_typ_nm like '%MEDICARE%' then 'MEDICARE'
	 when model_typ_nm like '%MANAGE%MEDICAID%' then 'MANAGED MEDICAID'
	 when model_typ_nm like '%MEDICAID%' then 'MEDICAID'
	 when model_typ_nm like '%CASH%' then 'CASH'
	 else '3rd Party' end as model_typ_nm 
from laad_data.plan ;

select distinct st_cd,region  from laad_data.zip_terr_mapping where region is not null
select * from laad_data.provider limit 10;

select * from laad_data.rx_claim rc limit 10;

select distinct d.patient_id  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  d.month_id  between '201707' and '202206'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')

select region,count(distinct  patient_id) as pat_cnt from (
(select distinct patient_id,rendering_provider_id,referring_provider_id
,facility_provider_id,billing_provider_id from laad_data.dx_claim where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('51631','J84112'))
and svc_dt::date between '2020-01-01' and '2020-12-31'
) dc
inner join laad_data.provider p on (dc.rendering_provider_id =p.provider_id or dc.referring_provider_id=p.provider_id
or dc.facility_provider_id  =p.provider_id or dc.billing_provider_id=p.provider_id)
inner join (select distinct st_cd,region  from laad_data.zip_terr_mapping where region is not null) c on c.st_cd=p.st_cd) 
group by c.region;

--total tx
select region,count(distinct  patient_id) as pat_cnt from (
(select distinct patient_id,provider_id from laad_data.rx_claim where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('51631','J84112'))
and svc_dt::date between '2020-01-01' and '2020-12-31' and patient_id in (
select distinct d.patient_id  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  svc_dt::date between '2020-01-01' and '2020-12-31'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
)
) dc
inner join laad_data.provider p on dc.provider_id=p.provider_id
inner join (select distinct st_cd,region  from laad_data.zip_terr_mapping where region is not null) c on c.st_cd=p.st_cd) 
group by c.region;


--new tx
select region,count(distinct  patient_id) as pat_cnt from (
(select distinct patient_id,provider_id from laad_data.rx_claim where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('51631','J84112'))
and svc_dt::date between '2020-01-01' and '2020-12-31' and patient_id in (
select distinct d.patient_id  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
group by 1 having min(svc_dt::date) between '2020-01-01' and '2020-12-31'
)
) dc
inner join laad_data.provider p on dc.provider_id=p.provider_id
inner join (select distinct st_cd,region  from laad_data.zip_terr_mapping where region is not null) c on c.st_cd=p.st_cd) 
group by c.region;


--age gender wise patient count
select pat_gender_cd ,CASE 
    WHEN (2023 - pat_brth_yr_nbr) <18 THEN '0-17' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 30 AND 44 THEN '30-44'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 45 AND 64 THEN '45-64'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 65 AND 74 THEN '65-74'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 75 AND 84 THEN '75-84'
    WHEN (2023 - pat_brth_yr_nbr) >=85 THEN '85+'
    ELSE    'Unknown'  END AS age_group,
count(distinct b.patient_id) as tx  from laad_data.patient a
inner join 
(
select distinct d.patient_id  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  svc_dt::date between '2020-01-01' and '2020-12-31'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
) b on a.patient_id =b.patient_id
where b.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by age_group,pat_gender_cd 
order by age_group,pat_gender_cd;

--age product wise patient count
select b.mkted_prod_nm ,CASE 
    WHEN (2023 - pat_brth_yr_nbr) <18 THEN '0-17' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 30 AND 44 THEN '30-44'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 45 AND 64 THEN '45-64'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 65 AND 74 THEN '65-74'
    WHEN (2023 - pat_brth_yr_nbr) BETWEEN 75 AND 84 THEN '75-84'
    WHEN (2023 - pat_brth_yr_nbr) >=85 THEN '85+'
    ELSE    'Unknown'  END AS age_group,
count(distinct b.patient_id) as tx  from laad_data.patient a
inner join 
(
select distinct d.patient_id,p.mkted_prod_nm  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  svc_dt::date between '2020-01-01' and '2020-12-31'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
) b on a.patient_id =b.patient_id
where b.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by age_group,b.mkted_prod_nm 
order by age_group,b.mkted_prod_nm;
