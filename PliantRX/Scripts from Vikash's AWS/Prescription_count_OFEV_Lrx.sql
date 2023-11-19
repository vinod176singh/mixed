create table #temp as 
select * from laad_data.dx_claim where patient_id in ( select distinct patient_id from laad_data.dx_claim where 
diag_cd in ('J84170','51631','J84112','M3481','J8410'))
and patient_id in (select distinct patient_id from laad_data.rx_claim where product_id in 
(select distinct product_id from laad_data.products where mkted_prod_nm='ESBRIET' ))


select * into #temp2 from laad_data.rx_claim where product_id in
(select distinct product_id from laad_data.products where mkted_prod_nm='ESBRIET')

----------------------------------------------------------------------------------------------------------------------
select A.*,B.ndc_cd as ndc into #temp3 from 
(select distinct a.patient_id,a.claim_id,a.product_id,a.svc_dt as claim_dt,b.svc_dt as diag_dt,b.diag_cd 
from #temp2 a
inner join
#temp b on a.patient_id=b.patient_id and b.svc_dt between dateadd(day,-60,to_date(a.svc_dt,'YYYYMMDD')) 
and dateadd(day,60,to_date(a.svc_dt,'YYYYMMDD'))) A 
inner join laad_data.products B on A.product_id=B.product_id
--------------------------------------------------------------------------------------------------------------------------
select A.*,B.ndc_cd as ndc into #temp3 from 
(select distinct a.patient_id,a.claim_id,a.product_id,a.svc_dt as claim_dt,b.svc_dt as diag_dt,b.diag_cd 
from #temp2 a
inner join
#temp b on a.patient_id=b.patient_id and b.svc_dt=a.svc_dt) A inner join laad_data.products B on A.product_id=B.product_id


select distinct * into #temp4 from(
select * from #temp3 where diag_cd in ('J84112','J84170','M3481','J8410','51631'))

select distinct * ,ABS(DATEDIFF(day, to_dATE(claim_dt,'YYYYMMDD'), to_dATE(diag_dt,'YYYYMMDD'))) into #temp5 from #temp4

select distinct a.* into #temp6 from #temp5 a
inner join
(select patient_id,claim_dt,min(distinct abs) from #temp5 group by 1,2)b on a.patient_id=b.patient_id and a.claim_dt=b.claim_dt and b.min=a.abs

select a.* into #temp7 from #temp6 a
inner join
(select distinct patient_id,claim_dt,min(distinct diag_dt) diag_dt from #temp4 t group by 1,2)b 
on a.patient_id=b.patient_id and a.claim_dt=b.claim_dt and a.diag_dt=b.diag_dt

SELECT 
*,
CASE diag_cd
WHEN 'J84112' THEN 1
WHEN '51631' THEN 1
WHEN 'J8410' THEN 2
WHEN 'M3481' THEN 3
WHEN 'J84170' THEN 4
END AS diag_priority into #temp8
FROM #temp7

select patient_id,claim_dt,diag_dt,claim_id,min(diag_priority) as priority_no into #temp9 from #temp8 group by 1,2,3,4

select extract(year from to_date(claim_dt,'YYYYMMDD')),count(distinct claim_id)as priority_no from #temp9 
where priority_no=1 group by 1 order by 1;

select priority_no,count(distinct claim_id) from #temp9 group by 1 order by 2 desc;

select distinct patient_id,claim_dt,diag_dt,abs from #temp7

select * from #temp9

select distinct
  patient_id,
  claim_dt,
  diag_dt,
  claim_id,
  CASE
    WHEN priority_no = 1 THEN 'J84112'
    WHEN priority_no = 2 THEN 'J8410'
    WHEN priority_no = 3 THEN 'M3481'
    WHEN priority_no = 4 THEN 'J84170'
  END AS code
FROM
  #temp9;


drop table #temp3;
drop table #temp4;
drop table #temp5;
drop table #temp6;
drop table #temp7;
drop table #temp8;
drop table #temp9;




select extract(year from to_date(svc_dt,'YYYYMMDD')),count(distinct claim_id) from laad_data.rx_claim where product_id in
(select distinct product_id from laad_data.products where mkted_prod_nm='ESBRIET')
 group by 1 order by 1

 select count( claim_id) from laad_data.rx_claim  where product_id in
(select distinct product_id from laad_data.products where mkted_prod_nm='ESBRIET')
 

create table #temp100 as
select distinct patient_id , claim_id,'' as product_id ,svc_dt,diag_cd from laad_data.dx_claim 
union
select distinct patient_id , claim_id,product_id,svc_dt,'' as diag_cd from laad_data.rx_claim

select * from laad_data.rx_claim rc  limit 10

