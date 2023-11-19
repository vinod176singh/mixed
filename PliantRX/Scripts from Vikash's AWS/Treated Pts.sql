select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC IN ('PSC'))
      or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('FENOFIBRATE'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('VANCOMYCIN HCL'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('RIFAMPIN'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('URSODIOL'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
group by yrs
order by yrs asc

---------------------------

select count(distinct pat_id)  from pharmetrics.claims 
where (ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC IN ('PSC'))
      or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))
      and ((from_dt)>='2014-01-01' and (from_dt) <='2014-12-31')  

group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('FENOFIBRATE'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('VANCOMYCIN HCL'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('RIFAMPIN'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE GPI10_DESC IN ('URSODIOL'))
group by yrs
order by yrs asc

select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
group by yrs
order by yrs asc


select date_part(year, from_dt) as yrs, count(distinct pat_id)  from pharmetrics.claims 
where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC IN ('PSC'))
      or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
group by yrs
order by yrs asc

-----------------------------------------------------------
-----------------------------------------------------------

select * from pharmetrics.rx_lookup rl  limit 1000


select date_part(year, from_dt) as year, count(distinct pat_id) from pharmetrics.claims where (pat_id in (select distinct pat_id from pharmetrics.claims  where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
      and ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC IN ('IPF')))
group by year 
order by year asc


select count(distinct pat_id) from pharmetrics.claims
where (('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)) 
      OR ('J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
and (from_dt >='2021-01-01' and from_dt <='2021-12-31') 

and ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC IN ('PSC'))

create temp table #ipf_diag as 
select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id 
order by 2 desc

select count(distinct  pat_id) from (select distinct pat_id from pharmetrics.claims where pat_id in (select distinct pat_id from pharmetrics.claims c where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
except 
(select distinct pat_id from pharmetrics.claims where (pat_id in (select distinct pat_id from pharmetrics.claims  where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
and ndc  in (SELECT DISTINCT ndc FROM pharmetrics.rx_lookup rl where product_name IN ('OFEV', 'ESBRIET', 'PIRFENIDONE', 'TREPROSTINIL'))))

select * from pharmetrics.rx_lookup rl where generic_name  = 'TREPROSTINIL'

select count(distinct pat_id) from pharmetrics.claims where (pat_id in (select distinct pat_id from pharmetrics.claims  where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
and  ndc  in (SELECT DISTINCT ndc FROM pharmetrics.rx_lookup rl where 'TREPROSTINIL' in (product_name, generic_name))



