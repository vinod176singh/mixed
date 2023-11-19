select * into #temp2 from laad_data.rx_claim rc2 
where product_id in(select distinct product_id from laad_data.products p where mkted_prod_nm in('ESBRIET') );

--221 ESBRIET continuous patient for more than 5 years
create table #temp3 as 
select patient_id,min_rx_dt,max_rx_dt,day_gap,dayssup from (select * from ( 
select distinct t.*
FROM (
select a.*,b.dayssup from(
(select distinct patient_id,min(to_date(svc_dt,'YYYYMMDD'))min_rx_dt,max(to_date(svc_dt,'YYYYMMDD'))as max_rx_dt,datediff(day,min_rx_dt,max_rx_dt) as day_gap from #temp2 where product_id 
in(select distinct product_id from laad_data.products p where mkted_prod_nm in('ESBRIET') )group by 1 )a
inner join 
(select distinct patient_id,sum(days_supply_cnt) as dayssup from(select distinct patient_id, to_date(svc_dt,'YYYYMMDD'),days_supply_cnt from #temp2) group by 1)b 
on a.patient_id=b.patient_id)
) t
INNER JOIN (
select c.patient_id,(to_date(c.svc_dt,'YYYYMMDD')) as max_from_dt ,c.days_supply_cnt as dayssup from #temp2 c
inner join 
(SELECT patient_id, max(to_date(svc_dt,'YYYYMMDD')) AS max_from_dt
FROM #temp2
GROUP BY patient_id)d on c.patient_id=d.patient_id and TO_DATE(c.svc_dt, 'YYYYMMDD') = d.max_from_dt
) t2 
ON t.patient_id = t2.patient_id AND t.max_rx_dt = t2.max_from_dt
WHERE isnull(cast(t.dayssup as BIGINT),0) > (isnull(t.day_gap ,0) + isnull(cast(t2.dayssup as BIGINT),0)-15))) 
where dayssup>=1800


create table #temp7 as
select B.*,A.min_rx_dt,A.max_rx_dt from #temp3 A
inner join 
(select distinct patient_id,svc_dt as pre_dt,claim_id as pre_claim,product_id as pre,days_supply_cnt as pre_dayssup from 
laad_data.rx_claim where patient_id in (select distinct patient_id from #temp3) 
and product_id in( select distinct product_id from laad_data.products p 
where mkted_prod_nm in('PREDNISONE'))) B on A.patient_id=B.patient_id

create table #temp8 as
select * from #temp7 where to_date(pre_dt,'YYYYMMDD') between min_rx_dt and max_rx_dt order by patient_id

create table #temp9 as
(select distinct patient_id,svc_dt as esb_dt,claim_id as esb_claim,product_id as esb,days_supply_cnt as esb_dayssup from laad_data.rx_claim 
where patient_id in (select distinct patient_id from #temp8) 
and product_id in ( select distinct product_id from laad_data.products p 
where mkted_prod_nm in('ESBRIET')) order by patient_id,svc_dt) 


select A.patient_id,B.min_esb_dt,B.max_esb_dt,B.esb_cnt,C.min_pre_dt,C.max_pre_dt,C.pre_cnt,D.sum_esb_dayssup,E.sum_pre_dayssup from 
(select distinct patient_id from #temp9 )A 
left join
(select patient_id,min(to_date(esb_dt,'YYYYMMDD')) as min_esb_dt,max(to_date(esb_dt,'YYYYMMDD')) as max_esb_dt,
count(distinct esb_claim) as esb_cnt from #temp9 group by 1) B on A.patient_id=B.patient_id
left join
(select patient_id, min(to_date(pre_dt,'YYYYMMDD')) as min_pre_dt ,max(to_date(pre_dt,'YYYYMMDD')) as max_pre_dt,
count(distinct pre_claim) as pre_cnt from #temp8 group by 1) C on A.patient_id=C.patient_id
left join 
(select patient_id,sum(esb_dayssup) as sum_esb_dayssup from #temp9 group by 1) D on A.patient_id=D.patient_id
left join 
(select patient_id,sum(pre_dayssup) as sum_pre_dayssup from #temp8 group by 1) E on A.patient_id = E.patient_id
order by patient_id

select distinct * from #TEMP9



