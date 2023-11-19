SELECT 
  CASE 
    WHEN (2022 - e.der_yob) <18 THEN '0-17' 
    WHEN (2022 - e.der_yob) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2022 - e.der_yob) BETWEEN 30 AND 49 THEN '30-49'
    WHEN (2022 - e.der_yob) BETWEEN 50 AND 64 THEN '45-64'
    WHEN (2022 - e.der_yob) >64 THEN '65-74'
    WHEN e.der_yob is null then   'Unknown'
    ELSE 'Over 85+'
  END AS age_group, 
  COUNT(DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.ipf_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
--and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
left JOIN 
  pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
GROUP BY 
  age_group 
ORDER BY 
  age_group;

 
SELECT  der_sex,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.ipf_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
LEFT JOIN 
pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
GROUP BY 
der_Sex
ORDER BY 
der_sex;

SELECT  case when pay_type in ('C') then 'Commercial'
			 when pay_type in ('M','K') then 'Medicaid'
			 when pay_type in ('A','T','R','S','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.ipf_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
left JOIN 
(select a.pat_id,pay_type from pharmetrics.enroll2 a inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2 group by pat_id) b on a.pat_id =b.pat_id and a.month_id=b.month_id)
e  ON c.pat_id  = e.pat_id  
GROUP BY 
pay_tpe
ORDER BY 
pay_tpe; 
 
 
SELECT 
  CASE 
    WHEN (2022 - e.der_yob) <18 THEN '0-17' 
    WHEN (2022 - e.der_yob) BETWEEN 18 AND 29 THEN '18-29' 
    WHEN (2022 - e.der_yob) BETWEEN 30 AND 49 THEN '30-49'
    WHEN (2022 - e.der_yob) BETWEEN 50 AND 64 THEN '45-64'
    WHEN (2022 - e.der_yob) >64 THEN '65-74'
    WHEN e.der_yob is null then   'Unknown'
    ELSE 'Over 85+'
  END AS age_group, 
  COUNT(DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.psc_claims c where 
('5761' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
OR 'K8301' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))  
--and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
LEFT JOIN 
pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
GROUP BY 
age_group 
ORDER BY 
age_group;
  
 
SELECT 
der_sex, 
  COUNT(DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.psc_claims c where 
('5761' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
OR 'K8301' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))    
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
LEFT JOIN 
  pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
GROUP BY 
  der_sex
ORDER BY 
  der_sex; 
 

 
SELECT  case when pay_type in ('C') then 'Commercial'
			 when pay_type in ('M','K') then 'Medicaid'
			 when pay_type in ('A','R','T','X','S') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.psc_claims c where 
('5761' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
OR 'K8301' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))  
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
LEFT JOIN  
(select a.pat_id,pay_type from pharmetrics.enroll2 a inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2 group by pat_id) b on a.pat_id =b.pat_id and a.month_id=b.month_id)
e  ON c.pat_id  = e.pat_id  
GROUP BY 
pay_tpe
ORDER BY 
pay_tpe; 



----New logic-----
SELECT  case when pay_type in ('C') then 'Commercial'
			 when pay_type in ('M','K') then 'Medicaid'
			 when pay_type in ('A','T','R','S','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.ipf_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
left JOIN 
(select a.pat_id,pay_type from pharmetrics.enroll2 a inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2 group by pat_id) b on a.pat_id =b.pat_id and a.month_id=b.month_id)
e  ON c.pat_id  = e.pat_id  
GROUP BY 
pay_tpe
ORDER BY 
pay_tpe; 

--select * from pharmetrics.enroll where pat_id ='001176lgghf0idl5'; 
select * into pharmetrics.enroll2_ipf from pharmetrics.enroll2
where pat_id  in (select count(distinct pat_id) from pharmetrics.ipf_claims pc);

drop table if exists  #last_payer;
select a.pat_id,pay_type into #last_payer from pharmetrics.enroll2_ipf a 
inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2_ipf group by pat_id) b 
on a.pat_id =b.pat_id and a.month_id=b.month_id;

SELECT  case when pay_type in ('C','S','T') then 'Commercial'
			 when pay_type in ('M','K','R') then 'Medicaid'
--			 when pay_type in ('A','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients  
from pharmetrics.ipf_claims ic 
left join  #last_payer  c  on c.pat_id =ic.pat_id
left join  pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
where  
(diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
--and month_id between '201707' and '202206' 
and 2022-der_yob<65
GROUP BY 
1
ORDER BY 
1;
---PSC--------------
select * into pharmetrics.enroll2_psc from pharmetrics.enroll2
where pat_id  in (select distinct pat_id from pharmetrics.psc_claims pc);

drop table if exists #last_payer_psc;
select a.pat_id,pay_type,a.month_id  into #last_payer_psc from pharmetrics.enroll2_psc a 
inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2_psc group by pat_id) b 
on a.pat_id =b.pat_id and a.month_id=b.month_id;


SELECT  case when pay_type in ('C','S','T') then 'Commercial'
			 when pay_type in ('M','K','R') then 'Medicaid'
--			 when pay_type in ('A','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
left(c.month_id,4) as Yr			 ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
from pharmetrics.psc_claims ic 
left join  #last_payer_psc  c  on c.pat_id =ic.pat_id
left join  pharmetrics.enroll e  ON c.pat_id  = e.pat_id  
where  
('5761' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
OR 'K8301' IN (diag_admit ,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))    
--and from_dt between '2017-07-01' and '2022-06-30'
and 2022-der_yob<65
GROUP BY 
1,2
ORDER BY 
1,2;

----optimized version --------
SELECT  case when pay_type in ('C','S','T') then 'Commercial'
			 when pay_type in ('M','K','R') then 'Medicaid'
			 when pay_type in ('A','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.ipf_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' 
or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or 
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'))
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
left JOIN 
(select a.pat_id,pay_type from pharmetrics.enroll2_ipf a inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2_ipf group by pat_id) b on a.pat_id =b.pat_id and a.month_id=b.month_id)
e  ON c.pat_id  = e.pat_id  
left join pharmetrics.enroll e2 on e.pat_id =e2.pat_id
where 2022-e2.der_yob<65 
GROUP BY 
pay_tpe
ORDER BY 
pay_tpe; 


SELECT  case when pay_type in ('C','S','T') then 'Commercial'
			 when pay_type in ('M','K','R') then 'Medicaid'
			 when pay_type in ('A','X') then 'Medicare'
			 else 'Unknown' end as pay_tpe ,
COUNT (DISTINCT c.pat_id) AS diagnosed_patients 
FROM 
(select distinct pat_id,min(distinct from_dt) as from_dt from pharmetrics.psc_claims c where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or 
diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112' or ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z'))    
and from_dt between '2017-07-01' and '2022-06-30'
group by pat_id)c
left JOIN 
(select a.pat_id,pay_type from pharmetrics.enroll2_psc a inner join
(select pat_id,max(month_id) as month_id from pharmetrics.enroll2_psc group by pat_id) b on a.pat_id =b.pat_id and a.month_id=b.month_id)
e  ON c.pat_id  = e.pat_id  
left join pharmetrics.enroll e2 on e.pat_id =e2.pat_id
where 2022-e2.der_yob<65 
GROUP BY 
pay_tpe
ORDER BY 
pay_tpe; 