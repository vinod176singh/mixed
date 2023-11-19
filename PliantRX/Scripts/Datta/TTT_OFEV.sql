--What is the distribution of patients for each of the 4 ICD codes at Min OFEV Tx 
--(split from the 3875 patient pool)

--drop table #temp403;
select p.* into #temp403 from pharmetrics.ipf_claims p
inner join
(
SELECT distinct b.pat_id,b.rx_dt,a.diag_dt
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
) b ON a.pat_id = b.pat_id  )q 
on p.pat_id =q.pat_id  where p.from_dt > q.rx_dt

select p.* into #temp403 from pharmetrics.ipf_claims p
inner join
(
SELECT distinct b.pat_id,b.rx_dt,a.diag_dt
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt 
  FROM pharmetrics.ipf_claims ic  
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
) b ON a.pat_id = b.pat_id  )q 
on p.pat_id =q.pat_id  where p.from_dt between dateadd('day',-30,q.rx_dt )and  dateadd('day',30,q.rx_dt )

select count(distinct pat_id) from #temp403

--drop table #temp403;
select p.* into #temp403 from pharmetrics.claims  p
inner join
(
SELECT distinct b.pat_id,b.rx_dt,a.diag_dt
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt 
  FROM pharmetrics.ipf_claims  
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
) b ON a.pat_id = b.pat_id  where  b.rx_dt <  dateadd('day',-30,a.diag_dt) )q 
on p.pat_id =q.pat_id  where p.from_dt <= q.rx_dt


select p.* into #temp403 from pharmetrics.ipf_claims  p
inner join
(
SELECT distinct b.pat_id,b.rx_dt,a.diag_dt
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt 
  FROM pharmetrics.ipf_claims  
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
) b ON a.pat_id = b.pat_id  where  b.rx_dt >  dateadd('day',30,a.diag_dt) )q 
on p.pat_id =q.pat_id  where p.from_dt >dateadd('day',30,q.diag_dt)

--drop table #temp403;
select p.* into #temp403 from pharmetrics.ipf_claims  p
inner join
(
SELECT distinct b.pat_id,b.rx_dt,a.diag_dt
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt 
  FROM pharmetrics.ipf_claims  
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
) b ON a.pat_id = b.pat_id  where  b.rx_dt <  dateadd('day',-30,a.diag_dt) )q 
on p.pat_id =q.pat_id  where p.from_dt =q.rx_dt

select diag_admit,count(distinct pat_id) from(
SELECT distinct pat_id,diag_admit FROM #temp403
UNION 
SELECT  distinct pat_id,diag1 FROM #temp403
UNION 
SELECT  distinct pat_id,diag2 FROM #temp403
UNION 
SELECT distinct pat_id,diag3 FROM #temp403
UNION 
SELECT  distinct pat_id,diag4 FROM #temp403
UNION 
SELECT distinct pat_id,diag5 FROM #temp403
UNION 
SELECT distinct pat_id,diag6 FROM #temp403
UNION 
SELECT distinct pat_id,diag7 FROM #temp403
UNION 
SELECT distinct pat_id,diag8 FROM #temp403
UNION 
SELECT distinct pat_id,diag9 FROM #temp403
UNION 
SELECT distinct pat_id,diag10 FROM #temp403
UNION 
SELECT  distinct pat_id,diag11 FROM #temp403
UNION 
SELECT  distinct pat_id,diag12 FROM #temp403) group by 1;

--------------------------------------------------------------------------------------------

--  How many of the patients with min OFEV Tx date had IPF diagnosis existing? 


--select count(distinct c2.pat_id )from (  
--select distinct pat_id,min(from_dt) as min_dt  from pharmetrics.ipf_claims ic   
--where ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')group by 1)a
--inner join 
--(select distinct pat_id ,from_dt,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6,
--diag7, diag8, diag9, diag10, diag11, diag12 from pharmetrics.ipf_claims ic2   where 
--'51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
--             or 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
-- )c2 on a.pat_id=c2.pat_id where a.min_dt>c2.from_dt;
-----------------------------------------------
-- drop table #temp403;

select p.* into #temp403 from pharmetrics.claims  p
inner join
(
SELECT b.pat_id, b.rx_dt
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt < b.rx_dt)q on p.pat_id =q.pat_id where p.from_dt
between dateadd('day',-30,q.rx_dt )and  dateadd('day',30,q.rx_dt );



select p.* into #temp403 from pharmetrics.claims  p
inner join
(
SELECT b.pat_id, b.rx_dt
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt < b.rx_dt)q on p.pat_id =q.pat_id where p.from_dt=q.rx_dt



select diag_admit,count(distinct pat_id) from(
SELECT distinct pat_id,diag_admit FROM #temp403
UNION 
SELECT  distinct pat_id,diag1 FROM #temp403
UNION 
SELECT  distinct pat_id,diag2 FROM #temp403
UNION 
SELECT distinct pat_id,diag3 FROM #temp403
UNION 
SELECT  distinct pat_id,diag4 FROM #temp403
UNION 
SELECT distinct pat_id,diag5 FROM #temp403
UNION 
SELECT distinct pat_id,diag6 FROM #temp403
UNION 
SELECT distinct pat_id,diag7 FROM #temp403
UNION 
SELECT distinct pat_id,diag8 FROM #temp403
UNION 
SELECT distinct pat_id,diag9 FROM #temp403
UNION 
SELECT distinct pat_id,diag10 FROM #temp403
UNION 
SELECT  distinct pat_id,diag11 FROM #temp403
UNION 
SELECT  distinct pat_id,diag12 FROM #temp403)   group by 1;

-------------------------------------------------------------------------------------------------------------------------

--how many patient taking ofeb in +30,-30 days timeframe 800

SELECT count(distinct a.pat_id)
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt between dateadd('day',-30,b.rx_dt)and  dateadd('day',30,b.rx_dt);
--------------------------------------------------------------

-----------------------------------------------------------
create table #temp3 as
select  c.* from pharmetrics.claims c   
inner join
(select  pat_id,min(from_dt) as min_dt from pharmetrics.claims  ic where ndc in 
(select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV') group by 1) a 
on a.pat_id=c.pat_id 
where min_dt between dateadd('day',-30,c.from_dt)and  dateadd('day',30,c.from_dt) 






select diag_admit,count(distinct pat_id) from(
SELECT distinct pat_id,diag_admit FROM #temp3
UNION 
SELECT  distinct pat_id,diag1 FROM #temp3
UNION 
SELECT  distinct pat_id,diag2 FROM #temp3
UNION 
SELECT distinct pat_id,diag3 FROM #temp3
UNION 
SELECT  distinct pat_id,diag4 FROM #temp3
UNION 
SELECT distinct pat_id,diag5 FROM #temp3
UNION 
SELECT distinct pat_id,diag6 FROM #temp3
UNION 
SELECT distinct pat_id,diag7 FROM #temp3
UNION 
SELECT distinct pat_id,diag8 FROM #temp3
UNION 
SELECT distinct pat_id,diag9 FROM #temp3
UNION 
SELECT distinct pat_id,diag10 FROM #temp3
UNION 
SELECT  distinct pat_id,diag11 FROM #temp3
UNION 
SELECT  distinct pat_id,diag12 FROM #temp3) where diag_admit in('J84112','51631')group by 1;


--------------------------------------------------------------------------
--drop table #temp403;
--select p.* into #temp403 from pharmetrics.ipf_claims p
--inner join
----(
SELECT count(distinct b.pat_id)
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
) b ON a.pat_id = b.pat_id  where  b.rx_dt between  dateadd('day',-30,a.diag_dt) and dateadd('day',30,a.diag_dt)--)q on p.pat_id =q.pat_id and q.rx_dt=p.from_dt;

select count(distinct pat_id) from #temp403;
select diag_admit,count(distinct pat_id) from(
SELECT distinct pat_id,diag_admit FROM #temp403
UNION 
SELECT  distinct pat_id,diag1 FROM #temp403
UNION 
SELECT  distinct pat_id,diag2 FROM #temp403
UNION 
SELECT distinct pat_id,diag3 FROM #temp403
UNION 
SELECT  distinct pat_id,diag4 FROM #temp403
UNION 
SELECT distinct pat_id,diag5 FROM #temp403
UNION 
SELECT distinct pat_id,diag6 FROM #temp403
UNION 
SELECT distinct pat_id,diag7 FROM #temp403
UNION 
SELECT distinct pat_id,diag8 FROM #temp403
UNION 
SELECT distinct pat_id,diag9 FROM #temp403
UNION 
SELECT distinct pat_id,diag10 FROM #temp403
UNION 
SELECT  distinct pat_id,diag11 FROM #temp403
UNION 
SELECT  distinct pat_id,diag12 FROM #temp403)  group by 1;

-------------------------------------------------------------

SELECT
  extract(year from diag_dt) AS Diag_year,count(distinct pat_id) as Pat_count,
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2014 THEN pat_id END) AS "2014",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2015 THEN pat_id END) AS "2015",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2016 THEN pat_id END) AS "2016",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2017 THEN pat_id END) AS "2017",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2018 THEN pat_id END) AS "2018",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2019 THEN pat_id END) AS "2019",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2020 THEN pat_id END) AS "2020",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2021 THEN pat_id END) AS "2021",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2022 THEN pat_id END) AS "2022"
FROM (select a.pat_id,a.diag_dt,b.rx_dt FROM (SELECT distinct pat_id,MIN(from_dt) AS diag_dt from pharmetrics.claims  
 where ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
      OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) 
    GROUP BY 1
  ) a
  INNER JOIN (
    SELECT distinct pat_id, MIN(from_dt) AS rx_dt from pharmetrics.claims  
    where ndc IN (SELECT distinct ndc from pharmetrics.ndc_codes nc where  mkted_prod_nm = 'OFEV')
    GROUP BY 1
  ) b
  ON a.pat_id = b.pat_id and b.rx_dt>dateadd('day',30,a.diag_dt)
) t
GROUP BY 1;

SELECT
  extract(year from diag_dt) AS Diag_year,count(distinct pat_id) as Pat_count,
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2014 THEN pat_id END) AS "2014",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2015 THEN pat_id END) AS "2015",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2016 THEN pat_id END) AS "2016",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2017 THEN pat_id END) AS "2017",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2018 THEN pat_id END) AS "2018",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2019 THEN pat_id END) AS "2019",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2020 THEN pat_id END) AS "2020",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2021 THEN pat_id END) AS "2021",
  COUNT(DISTINCT CASE WHEN extract(year from rx_dt) = 2022 THEN pat_id END) AS "2022"
FROM (select a.pat_id,a.diag_dt,b.rx_dt FROM (SELECT distinct pat_id,MIN(from_dt) AS diag_dt from pharmetrics.claims  
 where ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
      OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) 
    GROUP BY 1
  ) a
  INNER JOIN (
    SELECT distinct pat_id, MIN(from_dt) AS rx_dt from pharmetrics.claims  
    where ndc IN (SELECT distinct ndc from pharmetrics.ndc_codes nc where  mkted_prod_nm = 'OFEV')
    GROUP BY 1
  ) b
  ON a.pat_id = b.pat_id and b.rx_dt < a.diag_dt
) t
GROUP BY 1;