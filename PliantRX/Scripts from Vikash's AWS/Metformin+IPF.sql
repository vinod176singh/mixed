select extract(year from A.Ofev_dt), count(distinct A.patient_id) from 
(select distinct patient_id,to_date(svc_dt,'YYYYMMDD') as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where ndc_cd in(select distinct ndc from laad_data.metformin))) A 
inner join 
laad_data.dx_claim B on A.patient_id=B.patient_id and B.diag_cd in ('J84112','51631')
group by 1 order by 1

select extract(year from A.Ofev_dt), count(distinct A.patient_id) from 
(select distinct patient_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where ndc_cd in(select distinct ndc from laad_data.metformin)) group by 1) A 
inner join 
laad_data.dx_claim B on A.patient_id=B.patient_id and B.diag_cd in ('J84112','51631')
group by 1 order by 1

select extract(year from A.Ofev_dt), count(distinct A.n) from 
(select distinct A.*, B.ndc_cd from (select distinct product_id,min(to_date(svc_dt,'YYYYMMDD')) as Ofev_dt from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where ndc_cd in(select distinct ndc from laad_data.metformin)) group by 1) A 
inner join laad_data.products B on A.product_id=B.product_id) A 
inner join 
laad_data.dx_claim B on A.patient_id=B.patient_id and B.diag_cd in ('J84112','51631')
group by 1 order by 1

create table #temp as
select * from laad_data.rx_claim where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631'))
and patient_id in (select distinct patient_id from laad_data.rx_claim 
where product_id in (select product_id from laad_data.products p where ndc_cd in(select distinct ndc from laad_data.metformin)))


select distinct B.ndc_cd,extract(year from A.svc_dt),count(distinct A.patient_id) from (select distinct patient_id,product_id,min(to_date(svc_dt,'YYYYMMDD')) as svc_dt from #temp 
where product_id in (select product_id from laad_data.products p where ndc_cd in(select distinct ndc from laad_data.metformin)) group by 1,2) A 
inner join laad_data.products B on A.product_id=B.product_id
group by 1,2 order by 1,2

SELECT DISTINCT
    B.ndc_cd,
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2013 THEN A.patient_id END) AS "2013",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2014 THEN A.patient_id END) AS "2014",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2015 THEN A.patient_id END) AS "2015",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2016 THEN A.patient_id END) AS "2016",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2017 THEN A.patient_id END) AS "2017",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2018 THEN A.patient_id END) AS "2018",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2019 THEN A.patient_id END) AS "2019",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2020 THEN A.patient_id END) AS "2020",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2021 THEN A.patient_id END) AS "2021",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM A.svc_dt) = 2022 THEN A.patient_id END) AS "2022"
FROM (
    SELECT DISTINCT
        patient_id,
        product_id,
        MIN(TO_DATE(svc_dt, 'YYYYMMDD')) AS svc_dt
    FROM #temp
    WHERE product_id IN (
        SELECT product_id FROM laad_data.products p WHERE ndc_cd IN (SELECT DISTINCT ndc FROM laad_data.metformin)
    )
    GROUP BY 1, 2
) A
INNER JOIN laad_data.products B ON A.product_id = B.product_id
GROUP BY 1
ORDER BY 1;

select count(distinct patient_id) from #temp where product_id IN (
        SELECT product_id FROM laad_data.products p WHERE ndc_cd='00597014860')

