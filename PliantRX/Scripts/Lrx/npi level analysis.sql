select count(distinct patient_id) from laad_data.dx_claim  
where diag_cd in ('51631','J84112');

drop table if exists laad_data.ipf_mb_pat;
create table laad_data.ipf_mb_pat as 
select  distinct d.patient_id,p.mkted_prod_nm  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
and d.patient_id in (select distinct patient_id from laad_data.dx_claim  
where diag_cd in ('51631','J84112'));

select count(*) from laad_data.ipf_mb_pat;

select distinct p2.pri_spcl_cd,p2.pri_spcl_desc,count(distinct d.patient_id)   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
where  p.mkted_prod_nm ='OFEV'
group by p2.pri_spcl_cd,p2.pri_spcl_desc;

select distinct rs.region,count(distinct d.patient_id)   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
inner join laad_data.region_state rs on rs.state_code =p2.st_cd 
where  p.mkted_prod_nm ='OFEV'
group by rs.region;

select distinct p2.npi,p2.pri_spcl_desc,count(distinct d.patient_id) as pat_cnt   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
where  p.mkted_prod_nm ='OFEV'
group by p2.npi,p2.pri_spcl_desc
order by pat_cnt desc;

select distinct p.mkted_prod_nm,count(distinct p2.npi) as hcp_cnt   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
where  d.patient_id in(select patient_id from laad_data.ofev_pat)
group by p.mkted_prod_nm 
order by hcp_cnt desc;

--,p.mkted_prod_nm ||'_C' as mkted_prod_nm_c,count(distinct d.patient_id||d.svc_dt) as claim_cnt   
--,isnull(ofev_c,0) as OFEV_C,isnull(esbriet_c,0) as ESBRIET_C,isnull(PIRFENIDONE_C,0) as PIRFENIDONE_C,isnull(ofev_c,0)+isnull(esbriet_c,0)+isnull(PIRFENIDONE_C,0) as total_claims
with npi_pats_data as (
select npi,pri_spcl_desc,region,st_cd,city_nm,zip,isnull(ofev,0) as OFEV,isnull(esbriet,0) as ESBRIET,isnull(PIRFENIDONE,0) as PIRFENIDONE,isnull(ofev,0)+isnull(esbriet,0)+isnull(PIRFENIDONE,0) as total_pats
from (
select distinct p2.npi,p2.st_cd,p2.city_nm,p2.zip,p2.pri_spcl_desc,rs.region,p.mkted_prod_nm,count(distinct d.patient_id) as pat_cnt
from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
inner join laad_data.region_state rs  on rs.state_code =p2.st_cd 
where  p.mkted_prod_nm  in ('ESBRIET','OFEV','PIRFENIDONE') and  d.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by p2.npi,p2.pri_spcl_desc,rs.region,st_cd,city_nm,zip,p.mkted_prod_nm  
order by pat_cnt desc)
pivot(max(pat_cnt) for mkted_prod_nm in ('OFEV','ESBRIET','PIRFENIDONE'))
order by total_pats desc,ofev desc,esbriet desc,pirfenidone desc)
,npi_claims_data as (
select npi,pri_spcl_desc,region,st_cd,city_nm,zip,isnull(ofev,0) as OFEV,isnull(esbriet,0) as ESBRIET,isnull(PIRFENIDONE,0) as PIRFENIDONE,isnull(ofev,0)+isnull(esbriet,0)+isnull(PIRFENIDONE,0) as total_claims
from (
select distinct p2.npi,p2.st_cd,p2.city_nm,p2.zip,p2.pri_spcl_desc,rs.region,p.mkted_prod_nm,count(distinct d.patient_id||d.svc_dt) as claim_cnt
from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
inner join laad_data.region_state rs  on rs.state_code =p2.st_cd 
where  p.mkted_prod_nm  in ('ESBRIET','OFEV','PIRFENIDONE') and  d.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by p2.npi,p2.pri_spcl_desc,rs.region,st_cd,city_nm,zip,p.mkted_prod_nm  
order by claim_cnt desc)
pivot(max(claim_cnt) for mkted_prod_nm in ('OFEV','ESBRIET','PIRFENIDONE'))
order by total_claims desc,ofev desc,esbriet desc,pirfenidone desc)
select a.*,b.ofev,b.esbriet,b.PIRFENIDONE,b.total_claims from npi_pats_data a inner join npi_claims_data b on a.npi=b.npi

,npi_data_per as (select npi,pri_spcl_desc,region,st_cd,city_nm,zip,ofev,esbriet,PIRFENIDONE,total,ntile(10) over (order by total) as percentile from npi_data)
select * from npi_data_per order by percentile desc,total desc

distinct p.mkted_prod_nm,count(distinct p2.npi) as hcp_cnt

select distinct  p2.npi ,d.patient_id,p.mkted_prod_nm,d.svc_dt   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
where  p2.npi ='1831271741' and p.mkted_prod_nm  in ('ESBRIET','OFEV','PIRFENIDONE')
order by p2.npi ,d.patient_id,4 ;
d.patient_id in(select patient_id from laad_data.ofev_pat)
group by p.mkted_prod_nm 
order by hcp_cnt desc;


--claim basis dx,tx

select distinct p2.npi,p2.st_cd,p2.city_nm,p2.zip,p2.pri_spcl_desc,count(distinct d.patient_id||d.svc_dt) as claim_cnt
from laad_data.dx_claim d
inner join laad_data.provider p2 on p2.provider_id =d.rendering_provider_id  
where d.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by p2.npi,p2.pri_spcl_desc,st_cd,city_nm,zip  
order by claim_cnt desc;

select distinct p2.npi,p2.st_cd,p2.city_nm,p2.zip,p2.pri_spcl_desc,count(distinct d.patient_id||d.svc_dt) as claim_cnt
from laad_data.rx_claim d
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
inner join laad_data.products p on d.product_id=p.product_id 
where p.mkted_prod_nm  in ('ESBRIET','OFEV','PIRFENIDONE') 
group by p2.npi,p2.pri_spcl_desc,st_cd,city_nm,zip  
order by claim_cnt desc;

select distinct p2.npi,p2.st_cd,p2.city_nm,p2.zip,p2.pri_spcl_desc,count(distinct d.patient_id||d.svc_dt) as claim_cnt
from laad_data.rx_claim d
inner join laad_data.provider p2 on p2.provider_id =d.provider_id 
inner join laad_data.products p on d.product_id=p.product_id 
where p.mkted_prod_nm  in ('ESBRIET','OFEV','PIRFENIDONE') and  d.patient_id in (select distinct patient_id from laad_data.dx_claim  where diag_cd in ('51631','J84112'))
group by p2.npi,p2.pri_spcl_desc,st_cd,city_nm,zip  
order by claim_cnt desc;