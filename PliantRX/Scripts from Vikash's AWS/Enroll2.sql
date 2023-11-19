
drop table if exists #ipf_diag;
create temp table #ipf_diag as 
select distinct pat_id from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

create temp table #ipf_tx as 
select distinct pat_id from pharmetrics.claims 
where (from_dt >='2017-07-01' and from_dt <='2022-06-30')
	and ndc in (select distinct ndc from pharmetrics.ndc_codes  WHERE PROD_CUSTOM_LVL1_DESC in ('IPF'))

create temp table #ipf_diag_tx as 
select distinct pat_id from #ipf_diag 
where pat_id in (select pat_id from #ipf_tx)	
      
drop table if exists #psc_tx;
create temp table #psc_diag as 
select distinct pat_id from pharmetrics.claims 
where (from_dt >='2017-07-01' and from_dt <='2022-06-30')
       and ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))


       
create  temp table #psc_tx as
select distinct pat_id from pharmetrics.claims
where (ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('ACTIGALL','RELTONE','URSODIOL/SYRSPEND SF PH4','URSODIOL','URSO 250','URSO FORTE','RIFAMPIN','RIFADIN','RIFAMPIN/SYRSPEND SF PH4','FENOFIBRATE','FENOGLIDE','LOFIBRA','LIPOFEN','TRIGLIDE','TRICOR''FIRVANQ','FIRST-VANCOMYCIN 25','FIRST-VANCOMYCIN 50','VANCOCIN','VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND','VANCOMYCIN HCL','VANCOMYCIN HYDROCHLORIDE')) 
    or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))
    and (from_dt >='2017-07-01' and from_dt <='2022-06-30')
    
create temp table #psc_diag_tx as 
select distinct pat_id from #psc_diag 
where pat_id in (select pat_id from #psc_tx)



            

------------------Y: Med+Rx--------------------
create temp table #5yr_enroll_Y as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201707 and 202206) and mstr_enroll_cd in ('Y'))
group by pat_id)

create temp table #3yr_enroll_Y as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201907 and 202206) and mstr_enroll_cd in ('Y'))
group by pat_id)

----IPF Dx: 5yr Y--->3150
select count(distinct pat_id) from #ipf_diag
where  pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)

----IPF Dx: 3yr Y--->4035
select count(distinct pat_id) from #ipf_diag
where  pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)

----IPF Tx: 5yr Y--->994
select count(distinct pat_id) from #ipf_tx
where pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)


----IPF Tx: 3yr Y--->1320
select count(distinct pat_id) from #ipf_tx
where pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)

----IPF Dx+Tx: 5yr Y--->702
select count(distinct pat_id) from #ipf_diag_tx
where pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)

----IPF Dx+Tx: 3yr Y--->931
select count(distinct pat_id) from #ipf_diag_tx
where pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)
      
----PSC Dx: 5yr Y---->1490
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)
      
----PSC Dx: 3yr Y---->2186
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)

----PSC Tx: 5yr Y---->154667
select count(distinct pat_id) from #psc_tx
where pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)
      
----PSC Tx: 3yr Y----> 222107
select count(distinct pat_id) from #psc_tx
      where pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)
      
 ----PSC Dx+Tx: 5yr Y---->1003
select count(distinct pat_id) from #psc_diag_tx
      where pat_id in (select pat_id from #5yr_enroll_Y where month_count=60)
      
----PSC Dx+Tx: 3yr Y---->1350
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2019-07-01' and from_dt <='2022-06-30') 
      and ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
      and pat_id in (select pat_id from #psc_tx)
      and pat_id in (select pat_id from #3yr_enroll_Y where month_count=36)

      
     
------------------R: Rx--------------------
create temp table #5yr_eroll_R as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201707 and 202206) and mstr_enroll_cd in ('R'))
group by pat_id)

create temp table #3yr_eroll_R as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201907 and 202206) and mstr_enroll_cd in ('R'))
group by pat_id)

----IPF Dx: 5yr R--->2
select count(distinct pat_id) from #ipf_diag
where  pat_id in (select pat_id from #5yr_eroll_R where month_count=60)

----IPF Dx: 3yr R--->4
select count(distinct pat_id) from #ipf_diag
where  pat_id in (select pat_id from #3yr_eroll_R where month_count=36)

----IPF Tx: 5yr R--->2
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2017-07-01' and from_dt <='2022-06-30') 
      and ndc in (select ndc from pharmetrics.rx_lookup where product_name in ('OFEV', 'ESBRIET', 'PIRFENIDONE'))
      and pat_id in (select pat_id from #5yr_eroll_R where month_count=60)

----IPF Tx: 3yr R--->5
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2019-07-01' and from_dt <='2022-06-30') 
      and ndc in (select ndc from pharmetrics.rx_lookup where product_name in ('OFEV', 'ESBRIET', 'PIRFENIDONE'))  
      and pat_id in (select pat_id from #3yr_eroll_R where month_count=36)      

----IPF Dx+Tx: 5yr R--->1
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2017-07-01' and from_dt <='2022-06-30') 
      and pat_id in (select pat_id from #ipf_diag)  
      and ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
      and pat_id in (select pat_id from #5yr_eroll_R where month_count=60)

----IPF Dx+Tx: 3yr R--->2
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2019-07-01' and from_dt <='2022-06-30') 
      and pat_id in (select pat_id from #ipf_diag) 
      and ndc in (select ndc from pharmetrics.ndc_codes  where prod_custom_lvl1_desc='IPF')  
      and pat_id in (select pat_id from #3yr_eroll_R where month_count=36)
      
      
----PSC Dx: 5yr R---->0
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #5yr_eroll_R where month_count=60)
      
----PSC Dx: 3yr R---->2
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #3yr_eroll_R where month_count=36)

----PSC Tx: 5yr R---->392
select count(distinct pat_id) from #psc_tx
      where pat_id in (select pat_id from #5yr_eroll_R where month_count=60)
      
----PSC Tx: 3yr R----> 843
select count(distinct pat_id) from #psc_tx
      where pat_id in (select pat_id from #3yr_eroll_R where month_count=36)   
      
----PSC Dx+Tx: 5yr R---->0
select count(distinct pat_id) from #psc_diag_tx
      where pat_id in (select pat_id from #5yr_eroll_R where month_count=60)
      
----PSC Dx+Tx: 3yr R---->1
select count(distinct pat_id) from #psc_diag_tx
      where pat_id in (select pat_id from #5yr_eroll_R where month_count=36)

      
---------------------M: Med----------------
create temp table #5yr_eroll_M as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id >=201707 and month_id<=202206) and mstr_enroll_cd in ('M'))
group by pat_id)


create temp table #3yr_eroll_M as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201907 and 202206) and mstr_enroll_cd in ('M'))
group by pat_id)


----IPF Dx: 5yr M--->3193
select count(distinct pat_id) from #ipf_diag
where  pat_id in (select pat_id from #5yr_eroll_M where month_count=60)

----IPF Dx: 3yr M--->4116
select count(distinct pat_id) from #ipf_diag
where pat_id in (select pat_id from #3yr_eroll_M where month_count=36)

----IPF Tx: 5yr M--->18
select count(distinct pat_id) from #ipf_tx
where pat_id in (select pat_id from #5yr_eroll_M where month_count=60)

----IPF Tx: 3yr M--->30
select count(distinct pat_id) from #ipf_tx
where pat_id in (select pat_id from #3yr_eroll_M where month_count=36)     

----IPF Dx+Tx: 5yr M--->12
select count(distinct pat_id) from #ipf_diag_tx
where pat_id in (select pat_id from #5yr_eroll_M where month_count=60)

----IPF Dx+Tx: 3yr M--->21
select count(distinct pat_id) from #ipf_diag_tx
where pat_id in (select pat_id from #3yr_eroll_M where month_count=36)
      
----PSC Dx: 5yr M---->1049
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #5yr_eroll_M where month_count=60)
      
----PSC Dx: 3yr M---->1488
select count(distinct pat_id) from #psc_diag
where pat_id in (select pat_id from #3yr_eroll_M where month_count=36)

----PSC Tx: 5yr M---->13047
select count(distinct pat_id) from #psc_tx
      where  pat_id in (select pat_id from #5yr_eroll_M where month_count=60)
      
----PSC Tx: 3yr M---->20603
select count(distinct pat_id) from #psc_tx
where pat_id in (select pat_id from #3yr_eroll_M where month_count=36)

----PSC Dx+Tx: 5yr M---->256
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2017-07-01' and from_dt <='2022-06-30') 
      and ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
      and pat_id in (select pat_id from #psc_tx)
      and pat_id in (select pat_id from #5yr_eroll_M where month_count=60)
      
----PSC Dx+Tx: 3yr M---->336
select count(distinct pat_id) from pharmetrics.claims
where (from_dt >='2019-07-01' and from_dt <='2022-06-30') 
      and ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
      and pat_id in (select pat_id from #psc_tx)
      and pat_id in (select pat_id from #3yr_eroll_M where month_count=36)
 
 
