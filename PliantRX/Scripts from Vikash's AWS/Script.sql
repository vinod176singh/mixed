select  distinct pat_id from pharmetrics.claims WHERE (from_dt >='2017-07-01' and from_dt <='2022-06-30') and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select distinct diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12 from pharmetrics.claims c;

select max(month_id), min(month_id) from pharmetrics.claims

select distinct ndc from pharmetrics.claims WHERE '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)OR 'j84112' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12);

select count(distinct pat_id) from pharmetrics.claims where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'j84112' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)) and (ndc in (select ndc from pharmetrics.rx_lookup where product_name in ('ESBRIET', 'OFEV')))

select * from pharmetrics.rx_lookup where product_name in ('ESBRIET', 'OFEV', 'PREDNISONE')

select count(distinct pat_id) from pharmetrics.claims 
where 
ndc in (select distinct ndc from pharmetrics.rx_lookup where product_name in ('ESBRIET', 'OFEV', 'PIRFENIDONE')) 
and
(month_id between 201706 and 202207);

select count( distinct pat_id) from pharmetrics.claims WHERE ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))


and
pat_id in (select distinct pat_id from pharmetrics.claims where '51631' IN ( diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))


select * from pharmetrics.rx_lookup where product_name in ('ESBRIET', 'OFEV', 'PIRFENIDONE')

select count(distinct pat_id) from pharmetrics.claims where '0F754DZ' in (icdprc1, icdprc2, icdprc3,icdprc4,icdprc5,icdprc6 ,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12);

*******************PSC*********************

select count( distinct pat_id) from pharmetrics.claims WHERE (from_dt >='2017-07-01' and from_dt <='2022-06-30') and ('K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR '5761' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select count( distinct pat_id) from pharmetrics.claims


where
(from_dt >='2017-07-01' and from_dt <='2022-06-30')
and (icdprc1 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc2 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
    or icdprc3 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc4 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc5 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc6 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc7 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc8 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc9 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z') 
    or icdprc10 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
    or icdprc11 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
    or icdprc12 in ('0F753DZ', '0F753ZZ', '0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ', '0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ', '0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ', '0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z', '0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'));


***************Enroll*****************

select pat_id, count(distinct month_id)  from pharmetrics.enroll2
where (month_id between 201707 and 202206) and (pat_id in (select distinct pat_id from pharmetrics.claims WHERE (from_dt >='2017-07-01' and from_dt <='2022-06-30') and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))))
group by pat_id
order by count(distinct month_id) desc ;

select pat_id, count(distinct month_id)  from pharmetrics.enroll2
where (month_id between 201907 and 202206) and (pat_id in (select distinct pat_id from pharmetrics.claims WHERE (from_dt >='2019-07-01' and from_dt <='2022-06-30') and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))))
group by pat_id
order by count(distinct month_id) desc;


select diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12 from pharmetrics.claims where ndc  in ('93801101', '54868459700', '60505312003', '62332008531', '60505312103', '52725049590', '57844032201', '74434290', '54868578400', '378608993', '52725049090', '54868551200', '63304044430', '58016004400', '12280032815', '93801201', '57844032301', '59651020301', '67544103398', '63304044490', '12280032830', '74644790', '12280032890', '74401390', '59630048090', '13668043801', '378608893', '55111034930', '60687062911', '57844032401', '59630048590', '62332008431', '42291029290', '68180013106', '13668043901', '59630049090', '55111039530', '55111039590', '60505312109', '74400990', '68180013006', '66869014720', '62332008631', '378608977', '58016004490', '13668044001', '74641590', '54868459500', '59630048030', '59630049590', '63304044330', '66869013720', '51079060801', '58016004430', '58016004460')


select distinct product_name from pharmetrics.rx_lookup rl where ndc in ('93801101', '54868459700', '60505312003', '62332008531', '60505312103', '52725049590', '57844032201', '74434290', '54868578400', '378608993', '52725049090', '54868551200', '63304044430', '58016004400', '12280032815', '93801201', '57844032301', '59651020301', '67544103398', '63304044490', '12280032830', '74644790', '12280032890', '74401390', '59630048090', '13668043801', '378608893', '55111034930', '60687062911', '57844032401', '59630048590', '62332008431', '42291029290', '68180013106', '13668043901', '59630049090', '55111039530', '55111039590', '60505312109', '74400990', '68180013006', '66869014720', '62332008631', '378608977', '58016004490', '13668044001', '74641590', '54868459500', '59630048030', '59630049590', '63304044330', '66869013720', '51079060801', '58016004430', '58016004460')

select count(distinct pat_id) from pharmetrics.claims where ndc in ('60687066611', '68788766203', '68788766209', '72189017290', '50268033811', '50268033812', '69315029005', '69315028909', '70934022330', '71205094960', '71205094972', '70934063830', '60219552205', '68788793209', '50268031012', '62559030590', '50090337301', '60760031830', '50090622700', '50090515801', '50090622701', '70868001315', '70199013300', '58118552209', '50090127500', '50090127501', '71205005090', '67263026790', '54868522401', '47463080730', '68071080030', '68258600503', '71205019090', '50090304400', '54569653500', '54569668400', '54569575002', '33261096660', '50090269200', '55700031930', '50090337300', '60760041130', '60760066030', '50090254600', '33261090690', '33261096690', '68788700001', '55048080730', '62332036090', '68258610303', '68258605209', '68258610309', '68788757903', '68788757901', '68788757906', '68788725403', '68788725409', '68788734009', '68788734003', '68788734001', '68788781603', '69315028709', '69315028809', '71335074102', '68788725406', '63629109904', '72189017230', '68788810606', '68788810601', '71205066630', '60687066621', '68788766201', '68788766206', '69315029009', '71205094978', '63629110101', '50090388700', '50090585400', '50090585401', '50268031011', '50090254601', '60687065521', '68788793201', '68788793203', '68788793206', '60219551109', '60687065511', '179010380') 

select distinct pat_id from pharmetrics.claims where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookupwhere product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')exceptSELECT trim(ndc)FROM pharmetrics.ndc_codes ncWHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))


SELECT trim(ndc) FROM pharmetrics.rx_lookup where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')

select count(distinct pat_id) from pharmetrics.claims where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookup where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')) 

***41749 unique pts*****

select distinct  route from pharmetrics.rx_lookup rl where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookup where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))

*****41509 

select count(distinct pat_id) from pharmetrics.claims where ndc in ((SELECT trim(ndc) FROM pharmetrics.rx_lookup where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') and route in ('INTRAVENOUS')) except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')) 

select * from pharmetrics.claims where ('J84112' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR '5761' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and (ndc in ((SELECT trim(ndc) FROM pharmetrics.rx_lookup where product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') and route in ('INTRAVENOUS')) except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')))


*****diag codes for pts with vancomycin NDC and IV ROA******
select distinct diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12 from pharmetrics.claims 
where ndc in (select ndc  from pharmetrics.rx_lookup rl where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookup where (product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') and route in ('INTRAVENOUS')) except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE')))

 select ndc  from pharmetrics.rx_lookup rl where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookup where (product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') and route in ('INTRAVENOUS')) except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))

select count (distinct pat_id) from pharmetrics.claims 
where 
     (ndc in (select ndc  from pharmetrics.rx_lookup 
              where ndc in (SELECT trim(ndc) FROM pharmetrics.rx_lookup where 
                           (product_name IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE') 
             )
              except SELECT trim(ndc)FROM pharmetrics.ndc_codes WHERE mkted_prod_nm IN ('FIRVANQ', 'FIRST-VANCOMYCIN 25', 'FIRST-VANCOMYCIN 50', 'VANCOCIN', 'VANCOCIN HCL', 'VANCOMYCIN HCL + SYRSPEND', 'VANCOMYCIN HCL', 'VANCOMYCIN HYDROCHLORIDE'))))

              
and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)OR 'j84112' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)));

or ('K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR '5761' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

SELECT


