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
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm = 'ESBRIET')
    )
GROUP BY 1
order by 2 desc;


select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) >= 65
and patient_id in (SELECT distinct patient_id
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm = 'OFEV')
    ) where pay_typ_desc='THIRD PARTY')
 and patient_id in (SELECT distinct patient_id AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm = 'OFEV')
    ) where pay_typ_desc in ('MEDICARE', 'MEDICARE PART D') )
    
    
    
select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) >= 65
and patient_id in (SELECT distinct patient_id
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('OFEV','ESBRIET','PIRFENIDONE'))
    and patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631'))) where pay_typ_desc='THIRD PARTY')
 and patient_id in (SELECT distinct patient_id AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.rx_claim 
     WHERE product_id IN (SELECT product_id FROM laad_data.products p WHERE mkted_prod_nm in ('OFEV','ESBRIET','PIRFENIDONE'))
  and patient_id in (select distinct patient_id from laad_data.dx_claim where diag_cd in ('J84112','51631'))  ) 
  where pay_typ_desc in ('MEDICARE', 'MEDICARE PART D')) 
 
  
  
select distinct patient_id from laad_data.patient dc where (2023 - pat_brth_yr_nbr) >= 65
and patient_id in (SELECT distinct patient_id
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.dx_claim 
     WHERE diag_cd in ('J84112','51631')) where pay_typ_desc='THIRD PARTY')
 and patient_id in (SELECT distinct patient_id AS patient_count
FROM 
    (SELECT DISTINCT patient_id, pay_typ_desc
     FROM laad_data.dx_claim 
     WHERE diag_cd in ('J84112','51631') ) where pay_typ_desc in ('MEDICARE', 'MEDICARE PART D')) 
   
  
 