--drop table #icdprc_code


  create table #trans_tb as
  SELECT DISTINCT pat_id
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       )

select proc_cde, count(distinct pat_id) from
(SELECT distinct pat_id,proc_cde from
(SELECT distinct pat_id,proc_cde FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc1 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc2 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc3 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc4 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc5 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc6 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc7 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc8 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc9 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc10 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc11 FROM #icdprc_code
UNION ALL
SELECT distinct pat_id,icdprc12 FROM #icdprc_code))a
where proc_cde in('87497','80197')group by 1 order by 2 desc;


create table #icdprc_code as
select c.pat_id , proc_cde,icdprc1,icdprc2,icdprc3,icdprc4,icdprc5,icdprc6,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12
 from pharmetrics.claims c 
 inner join
(SELECT DISTINCT pat_id,min(from_dt ) as dt
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       ) group by pat_id) a on a.pat_id=c.pat_id  where c.from_dt <a.dt;


      
      
      SELECT DISTINCT ic.procedure_cd  ,ic.procedure_desc  
FROM pharmetrics.pr_lookup ic   
select * #icdprc_code b ON ic.procedure_cd = b.proc_cde;


----------------------------------------------------------------------------------

 create table #icdprc_codee as
select c.pat_id , proc_cde,icdprc1,icdprc2,icdprc3,icdprc4,icdprc5,icdprc6,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12
 from pharmetrics.claims c 
 inner join(select distinct pat_id  from pharmetrics.ipf_diag id except
SELECT DISTINCT pat_id 
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       )) a on a.pat_id=c.pat_id 
       where 
        (proc_cde in('80197','87497','580','32856','32855','Q0510','S9975','33933')
   Or  icdprc1 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc2 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc3 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc4 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc5 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc6 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc7 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc8 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc9 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc10 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc11 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc12 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   )
      
   
select distinct proc_cde, count(proc_cde)   from
(SELECT distinct pat_id,proc_cde from
(SELECT distinct pat_id,proc_cde FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc1 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc2 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc3 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc4 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc5 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc6 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc7 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc8 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc9 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc10 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc11 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc12 FROM #icdprc_codee))a
where proc_cde in ('80197','87497','580','32856','32855','Q0510','S9975','33933')
group by 1 order by 2 desc;

--select pat_id ,proc_cde,icdprc1,icdprc2,icdprc3,icdprc4,icdprc5,icdprc6,icdprc7,icdprc8,icdprc9,icdprc10,icdprc11,icdprc12 
--from pharmetrics.claims c where pat_id ='rr8sv5qkx8b9olq4' and 
--(proc_cde in('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   Or  icdprc1 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc2 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc3 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc4 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc5 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc6 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc7 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc8 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc9 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc10 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc11 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--   OR icdprc12 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
--    )
--;
--SELECT REGEXP_COUNT(column_name, ',') + 1 AS count
--FROM table_name;


select distinct proc_cde,count(distinct pat_id)   from
(SELECT distinct pat_id,proc_cde from
(SELECT distinct pat_id,proc_cde FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc1 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc2 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc3 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc4 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc5 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc6 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc7 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc8 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc9 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc10 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc11 FROM #icdprc_codee
UNION ALL
SELECT distinct pat_id,icdprc12 FROM #icdprc_codee))a
where proc_cde in ('80197','87497','580','32856','32855','Q0510','S9975','33933')
group by 1 order by 1 desc


--2877
select count(distinct pat_id) from pharmetrics.ipf_claims ic  
  where (proc_cde in('80197','87497','580','32856','32855','Q0510','S9975','33933')
   Or  icdprc1 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc2 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc3 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc4 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc5 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc6 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc7 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc8 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc9 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc10 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc11 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933')
   OR icdprc12 IN ('80197','87497','580','32856','32855','Q0510','S9975','33933'))
   
   ------------------------------------------------
--42914
   select count(distinct pat_id) from pharmetrics.ipf_claims ic  
  where (proc_cde in('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   Or  icdprc1 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc2 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc3 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc4 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc5 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc6 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc7 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc8 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc9 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc10 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc11 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933')
   OR icdprc12 IN ('93010','93306','88305','85025','80053','36415','80061','99291','83735','85610','80197','87497','87205','36620','580','85730','32856','32855','Q0510','S9975','33933'))