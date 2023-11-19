

(select * into #drug from pharmetrics.claims c2  where ndc  in(
select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV') group by 1);

--drop table #diag_code;
create table #diag_code as 
select distinct c.pat_id ,a.min_dt ,c.from_dt ,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6,
diag7, diag8, diag9, diag10, diag11, diag12 from pharmetrics.claims c 
inner join #drug a 
on a.pat_id=c.pat_id and  a.min_dt =c.from_dt
and  dateadd('day',-30,a.min_dt) <= c.from_dt and min_dt >=c.from_dt 

 

select distinct c.pat_id ,a.min_dt ,c.from_dt ,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6,
diag7, diag8, diag9, diag10, diag11, diag12 from pharmetrics.claims c 
inner join #drug a 
on a.pat_id=c.pat_id 

SELECT pat_id, from_dt,
	   LAG(diag_admit) OVER (order by pat_id,from_dt asc) AS diag_admit,
	   LAG(diag1) OVER (order by pat_id,from_dt asc) AS diag1,
	  LAG(diag2) OVER (order by pat_id,from_dt asc) AS diag2,
	 LAG(diag3) OVER (order by pat_id,from_dt asc) AS diag3,
	  LAG(diag4) OVER (order by pat_id,from_dt asc) AS diag4,
	   LAG(diag5) OVER (order by pat_id,from_dt asc) AS diag5,
	   LAG(diag6) OVER (order by pat_id,from_dt asc) AS diag6,
	    LAG(diag7) OVER (order by pat_id,from_dt asc) AS diag7,
	    LAG(diag8) OVER (order by pat_id,from_dt asc) AS diag8,
	   LAG(diag9) OVER (order by pat_id,from_dt asc) AS diag9,
	    LAG(diag10) OVER (order by pat_id,from_dt asc) AS diag10,
  	   LAG(diag11) OVER (order by pat_id,from_dt asc) AS diag11,
  	   LAG(diag12) OVER (order by pat_id,from_dt asc ) AS diag12
into #drug1 from pharmetrics.claims c2 where pat_id in(select distinct pat_id from pharmetrics.claims c where ndc  in(
select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')) 

drop table #drug1;
select * from #drug1 limit 1000;

select distinct pat_id,listagg(distinct TRIM(BOTH ',' FROM COALESCE(diag_admit || ',' ||COALESCE(diag1, '') || ',' ||COALESCE(diag2, '') || ',' ||COALESCE(diag3, '') || ',' ||
    COALESCE(diag4, '') || ',' ||COALESCE(diag5, '') || ',' ||COALESCE(diag6, '') || ',' ||COALESCE(diag7, '') || ',' ||COALESCE(diag8, '') || ',' ||COALESCE(diag9, '') || ',' ||
    COALESCE(diag10, '') || ',' ||COALESCE(diag11, '') || ',' ||COALESCE(diag12, '')
  )),',') from #diag_code where pat_id in (
  SELECT distinct a.pat_id
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt 
  FROM pharmetrics.claims  
  WHERE ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
  OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) 
  GROUP BY 1
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt > b.rx_dt)group by 1




















--
--SELECT extract (year from min_dt)  as year, diag_admit, COUNT( distinct pat_id) as count
--FROM #temp1
----where diag_admit <> '' -- and diag_admit in('515','5160','5161','5162','51630','51631','51632','51633','51634','51635','51636','51637','5164','5165','51661','51662','51663','51664','51669','5169','J8410','J8489','J8401','J8403','J8402','J84111','J84112','J84113','J84114','J84115','J842','J84116','J84117','J8481','J8482','J84841','J84842','J8483','J84843','J84848','J849')
--GROUP BY year, diag_admit
--ORDER BY year, count DESC;

--drop table #temp1
--
create table #temp1 as
SELECT distinct pat_id,min_dt,diag_admit FROM #diag_code
UNION 
SELECT  distinct pat_id,min_dt,diag1 FROM #diag_code
UNION 
SELECT  distinct pat_id,min_dt,diag2 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag3 FROM #diag_code
UNION 
SELECT  distinct pat_id,min_dt,diag4 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag5 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag6 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag7 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag8 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag9 FROM #diag_code
UNION 
SELECT distinct pat_id,min_dt,diag10 FROM #diag_code
UNION 
SELECT  distinct pat_id,min_dt,diag11 FROM #diag_code
UNION 
SELECT  distinct pat_id,min_dt,diag12 FROM #diag_code

