select distinct len(patient_id) , count( distinct patient_id) from dbo.FactDx group by 1;
select distinct len(patient_id) , count( distinct patient_id) from dbo.rx_claim group by 1;
select * from dbo.products p where mkted_prod_nm like '%ESBRIET%';
select * from dbo.products p where mkted_prod_nm like '%OFEV%';
select * from dbo.products p where mkted_prod_nm like '%PIRFENIDONE%';
select * from dbo."procedure" where prc_short_desc  ilike '%OFEV%' limit 10;


select count(distinct patient_id) from dbo.FactDx  
where diag_cd in ('51631','J84112') and month_id  between '201707' and '202206';

select count(distinct patient_id) from dbo.FactDx  
where diag_cd in ('5761','K8301') and month_id  between '201707' and '202206';

select count(distinct d.patient_id)  from dbo.rx_claim d
inner join dbo.products p on d.product_id=p.product_id 
where  d.month_id  between '201707' and '202206'
and p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE');

select count(distinct patient_id) from (
select distinct d.patient_id from dbo.rx_claim d
inner join dbo.products p on d.product_id=p.product_id 
where  d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
and d.patient_id in (
select distinct patient_id from dbo.FactDx  
where diag_cd in ('51631','J84112')
));

select p.mkted_prod_nm,count(distinct d.patient_id) from dbo.rx_claim d
inner join dbo.products p on d.product_id=p.product_id 
where d.month_id  between '201707' and '202206' and
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
group by p.mkted_prod_nm order by mkted_prod_nm;


select p.mkted_prod_nm,count(distinct d.patient_id) from dbo.rx_claim d
inner join dbo.products p on d.product_id=p.product_id 
where d.month_id  between '201707' and '202206' and 
p.mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE')
and patient_id in (select patient_id from dbo.FactDx dc where   diag_cd in ('51631','J84112'))
group by p.mkted_prod_nm order by mkted_prod_nm;
