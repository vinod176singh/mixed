select 'K8301' as segment, count(distinct patient_id)  from laad_data.dx_claim dc where diag_cd in ('K8301')
union 
select 'AIH' as segment, count(distinct patient_id) from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
type_desc in ('AIH')) and patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'))
union 
select 'Small duct psc' as segment, count(distinct patient_id) from laad_data.dx_claim where prc_cd in ('5014','5013','702','47700')
and patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'))
union 
select 'Carcinomas' as segment, count(distinct patient_id) from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523  where 
type_desc in ('Abdominal Cancer','Intestinal Cancer','LB 5 Cancer')) and patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'))
union 
select 'Cirhossis' as segment, count(distinct patient_id) from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
type_desc in ('Cirrhosis','ENCEPHALOPATHY','Varices','Portal Hypertension','ASCITES')) and patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'))
union 
select 'Drugs' as segment, count(distinct patient_id) from laad_data.rx_claim where product_id in (select distinct product_id from laad_data.products p  where 
mkted_prod_nm in ('RIFAMPIN','FENOFIBRATE','VANCOMYCIN HCL')) and patient_id in (select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301'));



create temp table #pat_list as 
select distinct patient_id  from laad_data.dx_claim dc where diag_cd in ('K8301')
except
select distinct patient_id from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523 where 
type_desc in ('AIH','Cirrhosis','ENCEPHALOPATHY','Varices','Portal Hypertension','ASCITES')) --AIH&Cirhossis
except 
select distinct patient_id from laad_data.dx_claim where prc_cd in ('5014','5013','702','47700') --small duct PSC
except 
select distinct patient_id from laad_data.rx_claim where product_id in (select distinct product_id from laad_data.products p  where 
mkted_prod_nm in ('RIFAMPIN','FENOFIBRATE','VANCOMYCIN HCL'))--three drug
except 
select distinct patient_id from laad_data.dx_claim where diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523  where 
type_desc in ('Abdominal Cancer','Intestinal Cancer'))

select * into #temp2 from laad_data.dx_claim where patient_id in (select patient_id from #pat_list);

create table #temp3 as
select * from laad_data.dx_claim where patient_id in (SELECT DISTINCT A.patient_id
FROM (
    SELECT DISTINCT patient_id, MIN(svc_dt::date) AS min_dt
    FROM #temp2
    WHERE diag_cd ='K8301'
    GROUP BY patient_id
) A
WHERE A.patient_id NOT IN (
    SELECT DISTINCT patient_id
    FROM laad_data.dx_claim dc 
    WHERE patient_id = A.patient_id
      AND diag_cd in (select distinct dx_cd from pharmetrics.dx_proc_20230523  where type_desc in ('LB 5 Cancer')) 
      AND svc_dt  BETWEEN DATEADD(YEAR, -5, A.min_dt) AND A.min_dt -- Within the 5-year period prior to A.min_dt
)
)

select distinct patient_id from #temp2

create table #temp4 as
select * from  laad_data.dx_claim where 
patient_id in (select distinct patient_id from #temp3 where diag_cd='K8301')
and patient_id in (select distinct patient_id from #temp3 where diag_cd = '5761')

select extract(year from A.min_dt) , count(distinct B.patient_id) from (select distinct patient_id , min(svc_dt::date) as min_dt from #temp4 where 
diag_cd='5761' group by 1) A inner join #temp4 B
on A.patient_id = B.patient_id
group by 1 order by 1;


create table #temp5 as
select * from laad_data.dx_claim where 
patient_id in (select distinct patient_id from #temp3 where diag_cd='K8301')
and patient_id not in (select distinct patient_id from #temp3 where diag_cd='5761')

select extract(year from A.min_dt) , count(distinct B.patient_id) from (select distinct patient_id , min(svc_dt::date) as min_dt from #temp5 where 
diag_cd='K8301'  group by 1) A inner join #temp5 B
on A.patient_id = B.patient_id
group by 1 order by 1


