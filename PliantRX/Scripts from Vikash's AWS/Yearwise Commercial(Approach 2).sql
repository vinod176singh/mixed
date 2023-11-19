create table #temp as
select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) >= 65
and patient_id in (SELECT distinct patient_id
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE 
     product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('ESBRIET'))) where pay_typ_desc='THIRD PARTY')
 and patient_id in (SELECT distinct patient_id AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     where
      product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('ESBRIET')) ) where pay_typ_desc in ('MEDICARE', 'MEDICARE PART D')) 
    
  
 drop table #temp    
    
 SELECT 
          CASE 
        WHEN pay_typ_desc IN ('MEDICARE', 'MEDICARE PART D') THEN 'MEDICARE'
        WHEN pay_typ_desc = 'THIRD PARTY' THEN 'COMMERCIAL'
        ELSE pay_typ_desc
    END AS pay_type,
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2013 THEN patient_id END) AS "2013",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2014 THEN patient_id END) AS "2014",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2015 THEN patient_id END) AS "2015",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2016 THEN patient_id END) AS "2016",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2017 THEN patient_id END) AS "2017",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2018 THEN patient_id END) AS "2018",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2019 THEN patient_id END) AS "2019",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2020 THEN patient_id END) AS "2020",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2021 THEN patient_id END) AS "2021",
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM svc_dt) = 2022 THEN patient_id END) AS "2022"
FROM     
((select distinct patient_id,svc_dt,pay_typ_desc from (SELECT DISTINCT patient_id, TO_DATE(svc_dt, 'YYYYMMDD') AS svc_dt, pay_typ_desc
FROM laad_data.rx_claim where product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('ESBRIET')) )
where patient_id not in (SELECT patient_id FROM #temp)
and pay_typ_desc='THIRD PARTY'))
group by 1


