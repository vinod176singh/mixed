  
select distinct pat_id ,ndc ,proc_cde,coalesce(icdprc1,icdprc2,icdprc3,icdprc4,icdprc5,icdprc6,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12)as icdprc,diag_admit,
coalesce(diag1,diag2,diag3,diag4,diag5,diag6,diag7,diag8,diag8,diag10,diag11,diag12) as diag_code,from_dt ,to_dt,month_id  from pharmetrics.claims c where pat_id in(select 
distinct pat_id  from pharmetrics.claims c2 where ndc in(
SELECT trim(ndc)FROM pharmetrics.rx_lookup
where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN',
'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')
except 
SELECT trim(ndc)FROM pharmetrics.ndc_codes nc
WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 
'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))limit 10) order by 1,from_dt; 

  

  
select distinct pat_id ,ndc ,proc_cde,coalesce(icdprc1,icdprc2,icdprc3,icdprc4,icdprc5,icdprc6,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12)as icdprc,diag_admit,
coalesce(diag1,diag2,diag3,diag4,diag5,diag6,diag7,diag8,diag8,diag10,diag11,diag12) as diag_code,from_dt ,to_dt,month_id  from pharmetrics.claims c where pat_id in(select 
distinct pat_id  from pharmetrics.claims c2 where ndc in(
SELECT trim(ndc)FROM pharmetrics.rx_lookup
where product_name IN ('FENOFIBRATE', 'FENOGLIDE', 'LOFIBRA', 'LIPOFEN', 'TRIGLIDE', 'TRICOR')
except 
SELECT trim(ndc)FROM pharmetrics.ndc_codes nc
WHERE mkted_prod_nm IN ('FENOFIBRATE', 'FENOGLIDE', 'LOFIBRA', 'LIPOFEN', 'TRIGLIDE', 'TRICOR'))limit 10) order by 1,from_dt; 

--55--14,889 d-patient count
select distinct pat_id from pharmetrics.claims c where ndc in(
SELECT trim(ndc)FROM pharmetrics.rx_lookup
where product_name IN ('FENOFIBRATE', 'FENOGLIDE', 'LOFIBRA', 'LIPOFEN', 'TRIGLIDE', 'TRICOR')
except 
SELECT trim(ndc)FROM pharmetrics.ndc_codes nc
WHERE mkted_prod_nm IN ('FENOFIBRATE', 'FENOGLIDE', 'LOFIBRA', 'LIPOFEN', 'TRIGLIDE', 'TRICOR'))

--219--167,129 d-pat_count

select distinct pat_id from pharmetrics.claims c where ndc in(
SELECT trim(ndc)FROM pharmetrics.rx_lookup
where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN',
'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))
except 
SELECT trim(ndc)FROM pharmetrics.ndc_codes nc
WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 
'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE');