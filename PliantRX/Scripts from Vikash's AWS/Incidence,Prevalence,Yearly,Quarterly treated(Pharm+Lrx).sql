--Prevelance(Lrx)
select extract(year from Ofev_dt), count(distinct patient_id) from 
(select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET'))
group by 1 order by 1

--Prevelance(Pharmeterics)
select extract(year from Ofev_dt), count(distinct pat_id) from
(select distinct pat_id,from_dt as Ofev_dt from pharmetrics.esbriet_table where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='ESBRIET')) group by 1 order by 1

--Trx(Pharmeterics)
select extract(year from Ofev_dt), count(distinct claimno) from
(select distinct claimno,min(from_dt) as Ofev_dt from pharmetrics.claims where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='PIRFENIDONE') group by 1) group by 1 order by 1

--Prevalence Lrx(2022)
select extract(month from Ofev_dt), count(distinct patient_id) from 
(select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'OFEV')) where extract(year from Ofev_dt)='2022'
and patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))
group by 1 order by 1

--Prevalence Pharm(2022)
select extract(month from Ofev_dt), count(distinct pat_id) from
(select distinct pat_id,from_dt as Ofev_dt from pharmetrics.esbriet_table where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='ESBRIET'))  where extract(year from Ofev_dt)='2022'
group by 1 order by 1

--Incidence Lrx(2022)
select extract(month from Ofev_dt), count(distinct patient_id) from 
(select distinct patient_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'PIRFENIDONE') group by 1) where extract(year from Ofev_dt)='2022'
and patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))
group by 1 order by 1

--Incidence Pharm(2022)
select extract(month from Ofev_dt), count(distinct pat_id) from
(select distinct pat_id,min(from_dt) as Ofev_dt from pharmetrics.ofev_table where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='OFEV') group by 1)  where extract(year from Ofev_dt)='2022'
group by 1 order by 1

--Incidence Lrx(2022) First Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct patient_id) from 
(select distinct patient_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET')  and 
patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))
group by 1) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1

--Incidence Pharm(2022) First Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct pat_id) from
(select distinct pat_id,min(from_dt) as Ofev_dt from pharmetrics.esbriet_table where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='ESBRIET') group by 1)  where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1

--Prevalence Lrx(2022) First Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct patient_id) from 
(select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET')
and 
patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1

--Prevalence Pharm(2022) Second Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct pat_id) from
(select distinct pat_id,from_dt as Ofev_dt from pharmetrics.ofev_table where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='OFEV'))  where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1

--Trx Lrx(2022)
select extract(month from Ofev_dt), count(distinct claim_id) from 
(select distinct claim_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET') group by 1) where extract(year from Ofev_dt)='2022'
group by 1 order by 1

--Trx Pharm(2022)
select extract(month from Ofev_dt), count(distinct claimno) from
(select distinct claimno,min(from_dt) as Ofev_dt from pharmetrics.claims  where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='PIRFENIDONE') group by 1)  where extract(year from Ofev_dt)='2022'
group by 1 order by 1


--Trx Lrx(2022) First Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct claim_id) from 
(select distinct claim_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET') group by 1) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1,2

--Trx Pharm(2022) Second Half
select extract(year from Ofev_dt),CASE
    WHEN DATE_PART(MONTH, Ofev_dt) <= 6 THEN 'First Half'
    ELSE 'Second Half'
  END AS half, count(distinct claimno) from
(select distinct claimno,min(from_dt) as Ofev_dt from pharmetrics.claims where 
ndc in (select distinct ndc from pharmetrics.ndc_codes nc 
where mkted_prod_nm='PIRFENIDONE') group by 1)  where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1,2

-----------------------------------------------------------------------------------------------------------------

--Incidence Lrx(2022) Quarter
select extract(year from Ofev_dt),date_part(quarter,Ofev_dt), count(distinct patient_id) from 
(select distinct patient_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'PIRFENIDONE') 
and 
patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))group by 1) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1,2

--Prevalence Lrx(2022) Quarter
select extract(year from Ofev_dt),date_part(quarter,Ofev_dt), count(distinct patient_id) from 
(select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'OFEV')
and 
patient_id in(select distinct patient_id from laad_data.dx_claim dc where diag_cd in('J84112','51631'))) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1,2

--Trx Lrx(2022) Quarter
select extract(year from Ofev_dt),date_part(quarter,Ofev_dt), count(distinct claim_id) from 
(select distinct claim_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'ESBRIET') group by 1) where extract(year from Ofev_dt)='2022'
group by 1,2 order by 1,2