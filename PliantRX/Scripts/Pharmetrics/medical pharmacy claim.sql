------Identify and Segregate patients based on Medical and Pharmacy Claims
select 
	case 
		when rectype in('M','S','F','A','J') then 'medical_claim'
		when rectype ='P' then 'Pharmacy_claim'
		else 'unknown'
		end as classification,
		date_trunc('month',from_dt) as Months, 
		COUNT(DISTINCT pat_id + '-'+ from_dt ) AS claim_cnt 
		 from 
(select * from pharmetrics.ipf_claims c where (
diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112'
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')))
group by classification,Months
order by classification,Months;

--classification	pnt_cnt
--Pharmacy_claim	10,619
--medical_claim	    372,963
--unknown	        264
	

-------------------------------------------------------------------------------------------------------------
 select 
	case 
		when rectype in('M','S','F','A','J') then 'medical_claim'
		when rectype ='P' then 'Pharmacy_claim'
		else 'unknown'
		end as classification,
		date_trunc('month',from_dt) as Months, 
		COUNT(DISTINCT pat_id + '-'+ from_dt ) AS claim_cnt 
		 from 
		(select distinct pat_id,from_dt,rectype from pharmetrics.claims c where (diag_admit = '5761' or diag1 ='5761' or diag2 ='5761' or diag3 ='5761' or diag4 ='5761' or diag5 ='5761' or diag6 ='5761' or diag7 ='5761' or diag8 ='5761' or diag9 ='5761' or diag10 ='5761' or diag11 ='5761' or diag12 ='5761'
or diag_admit = '5761' or diag1 ='5761' or diag2 ='5761' 
or diag3 ='k8301' or diag4 ='k8301' or diag5 ='k8301' or diag6 ='k8301' or diag7 ='k8301' or diag8 ='k8301' or 
diag9 ='k8301' or diag10 ='k8301' or diag11 ='k8301' or diag12 ='k8301'
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
)
) group by classification,Months
order by classification,Months;

--classification	pnt_cnt
--Pharmacy_claim	7,184
--medical_claim	    88,819
--unknown	        140
