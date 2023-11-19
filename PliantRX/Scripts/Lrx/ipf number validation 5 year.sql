select distinct len(patient_id) , count( distinct patient_id) from laad_data.dx_claim group by 1;
select distinct len(patient_id) , count( distinct patient_id) from laad_data.rx_claim group by 1;
select * from laad_data.products p where mkted_prod_nm like '%ESBRIET%';
select * from laad_data.products p where mkted_prod_nm like '%OFEV%';
select * from laad_data.products p where mkted_prod_nm like '%PIRFENIDONE%';
select * from laad_data."procedure" where prc_short_desc  ilike '%OFEV%' limit 10;

select count(distinct patient_id) from laad_data.dx_claim  
where diag_cd in ('51631','J84112') and month_id  between '201707' and '202206'
--and DIAG_CD_POSN_NBR in (1,2);

select count(distinct patient_id) from laad_data.dx_claim  
where diag_cd in ('5761','K8301') and month_id  between '201707' and '202206';

select count(distinct d.patient_id)  from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  d.month_id  between '201707' and '202206'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE');

select 37911-51485
select count(distinct d.patient_id)  from 
laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.dx_claim c on c.patient_id =d.patient_id 
where  d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE') 
and diag_cd in ('51631','J84112');
--and d.patient_id in (
--select distinct patient_id from laad_data.dx_claim  
--where diag_cd in ('51631','J84112')
--)
--);

select p.mkted_prod_nm,count(distinct d.patient_id) from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where d.month_id  between '201707' and '202206' and
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
group by p.mkted_prod_nm order by mkted_prod_nm;


select p.mkted_prod_nm,count(distinct d.patient_id) from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
and patient_id in (select patient_id from laad_data.dx_claim dc where   diag_cd in ('51631','J84112'))
group by p.mkted_prod_nm order by mkted_prod_nm;



-------Diag wise patient count-----
with patientList as (
select distinct d.patient_id  from 
laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE') 
except
select distinct d.patient_id  from 
laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
inner join laad_data.dx_claim c on c.patient_id =d.patient_id 
where  d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE') 
and diag_cd in ('51631','J84112'))
select dc.diag_cd,diag_short_desc,count(distinct patient_id) from laad_data.dx_claim dc 
inner join laad_data.diagnosis d2 on dc.diag_cd =d2.diag_cd 
where patient_id in (select distinct patient_id from patientList)
group by dc.diag_cd,diag_short_desc
