select * from laad_data.dx_claim dc  limit 100

select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and pat_id in (select distinct pat_id from pharmetrics.claims where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC in ('IPF')))
group by pat_id 
order by 2 desc

select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and (pat_id in (select distinct pat_id from pharmetrics.claims where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
and (pat_id in (select distinct pat_id from pharmetrics.claims where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC in ('IPF'))))
group by pat_id 


order by 2 desc

select * from pharmetrics.ibd_dx_codes 

create temp table #psc_icd9 as 
select * from pharmetrics.claims
where (pat_id in (select pat_id from pharmetrics.claims where '5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))

create temp table #psc_icd9_2 as 
select * from #psc_icd9
where (pat_id not in (select pat_id from #psc_icd9 where 'K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))



select pat_id, min(from_dt)  from #psc_icd9_2 where pat_id in (select pat_id from #psc_icd9_2 where 
diag_admit  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag1  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag2  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag3  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag4  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag5  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag6  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag7  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag8  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag9  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag10  in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag11 in (select dx_code from pharmetrics.ibd_dx_codes idc  ) or
diag12 in (select dx_code from pharmetrics.ibd_dx_codes idc  ))
and '5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
group by 1


select pat_id, min(from_dt)  from #psc_icd9_2 where pat_id in (select pat_id from #psc_icd9_2 where 
 '5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by 1


select count(distinct  pat_id) from #psc_icd9

17,455

