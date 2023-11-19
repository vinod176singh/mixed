SELECT 
    CASE 
        WHEN pay_typ_desc IN ('MEDICARE', 'MEDICARE PART D') THEN 'MEDICARE'
        WHEN pay_typ_desc = 'THIRD PARTY' THEN 'COMMERCIAL'
        ELSE pay_typ_desc
    END AS pay_type,
    COUNT(DISTINCT patient_id) AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_datrx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_datproducts p WHERE mkted_prod_nm = 'ESBRIET')
    )
GROUP BY 1
order by 2 desc;

SELECT 
    CASE 
        WHEN pay_typ_desc IN ('MEDICARE', 'MEDICARE PART D') THEN 'MEDICARE'
        WHEN pay_typ_desc = 'THIRD PARTY' THEN 'COMMERCIAL'
        ELSE pay_typ_desc
    END AS pay_type,
    COUNT(DISTINCT patient_id) AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631') ) 
     and product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('ESBRIET','OFEV','PIRFENIDONE'))
    )
GROUP BY 1
order by 2 desc;

SELECT        CASE 
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
    (SELECT DISTINCT patient_id, to_date(svc_dt,'YYYYMMDD') as svc_dt ,pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm = 'OFEV')
    )
GROUP BY 1
order by 1 desc;

-------------------------------------------------------------------------------------

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
    (SELECT DISTINCT patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt, pay_typ_desc
     FROM laad_data.rx_claim 
     where patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631') ) 
     and product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('ESBRIET'))
    )
GROUP BY 1
order by 2 desc;


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
    (SELECT DISTINCT patient_id,to_date(svc_dt,'YYYYMMDD') as svc_dt, pay_typ_desc
     FROM laad_data.dx_claim 
     where diag_cd in ('J84112','51631')  
    )
GROUP BY 1
order by 2 desc;

select distinct patient_id,svc_dt,pay_typ_desc from laad_data.dx_claim where diag_cd in ('J84112','51631')
and patient_id='10005845653'