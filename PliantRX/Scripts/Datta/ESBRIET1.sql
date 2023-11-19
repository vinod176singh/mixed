--Time To Treatment Analysis

select count(distinct pat_id) from pharmetrics.claims c where ndc in(select distinct ndc from pharmetrics.ndc_codes nc where 
mkted_prod_nm = 'ESBRIET')

----IPF patient taking ESBRIET tratement

SELECT distinct a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id ;
--------------------------------------------------------------------------------
 --No's pf patient taking Rxs after Dxs

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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt = b.rx_dt;




SELECT distinct a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt > b.rx_dt;
------------------------------------------------------


SELECT distinct a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt > b.rx_dt;

---30/-30 window

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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id   where  b.rx_dt between  dateadd('day',-30,a.diag_dt) and dateadd('day',30,a.diag_dt)


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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id   where  b.rx_dt <  dateadd('day',-30,a.diag_dt) 


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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id   where  b.rx_dt >  dateadd('day',30,a.diag_dt) 
--------------------------------------------------------------------------------------------------------------------



create table #temp1 as 
select c.pat_id ,from_dt ,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12 from pharmetrics.claims c 
inner join
(SELECT a.pat_id, a.diag_dt, b.rx_dt
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt < b.rx_dt) d on d.pat_id=c.pat_id where c.from_dt <= d.rx_dt;

--drop table #temp11;
create table #temp11 as 
select c.pat_id ,from_dt ,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12 from pharmetrics.claims c 
inner join
(SELECT a.pat_id, a.diag_dt, b.rx_dt
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  a.diag_dt =b.rx_dt) d on d.pat_id=c.pat_id where c.from_dt = d.rx_dt;

select count(distinct pat_id) from #temp1;

select distinct diag_admit ,count(distinct pat_id)from(
SELECT distinct pat_id,diag_admit FROM #temp11
UNION 
SELECT  distinct pat_id,diag1 FROM #temp11
UNION 
SELECT  distinct pat_id,diag2 FROM #temp11
UNION 
SELECT distinct pat_id,diag3 FROM #temp11
UNION 
SELECT  distinct pat_id,diag4 FROM #temp11
UNION 
SELECT distinct pat_id,diag5 FROM #temp11
UNION 
SELECT distinct pat_id,diag6 FROM #temp11
UNION 
SELECT distinct pat_id,diag7 FROM #temp11
UNION 
SELECT distinct pat_id,diag8 FROM #temp11
UNION 
SELECT distinct pat_id,diag9 FROM #temp11
UNION 
SELECT distinct pat_id,diag10 FROM #temp11
UNION 
SELECT  distinct pat_id,diag11 FROM #temp11
UNION 
SELECT  distinct pat_id,diag12 FROM #temp11) where diag_admit <> '' group by 1;

-------------------------------------------------------------------------------------------------------------------
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
    where ndc IN (SELECT distinct ndc from pharmetrics.ndc_codes nc where  mkted_prod_nm = 'ESBRIET')
    GROUP BY 1
  ) b
  ON a.pat_id = b.pat_id and b.rx_dt<a.diag_dt
) t
GROUP BY 1;
------------------------------------------------------------------------------------------------------------------

--drop table #temp22;
select p.* into #temp22 from pharmetrics.claims  p
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  b.rx_dt >  dateadd('day',30,a.diag_dt) )q 
on p.pat_id =q.pat_id  where p.from_dt between dateadd('day',30,q.diag_dt) and q.rx_dt

--drop table #temp22;
select p.* into #temp222 from pharmetrics.claims  p
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
    WHERE mkted_prod_nm = 'ESBRIET'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id  where  b.rx_dt between  dateadd('day',30,a.diag_dt) and dateadd('day',-30,a.diag_dt) )q 
on p.pat_id =q.pat_id  



select diag_admit,count(distinct pat_id) from(
SELECT distinct pat_id,diag_admit FROM #temp22
UNION 
SELECT  distinct pat_id,diag1 FROM #temp22
UNION 
SELECT  distinct pat_id,diag2 FROM #temp22
UNION 
SELECT distinct pat_id,diag3 FROM #temp22
UNION 
SELECT  distinct pat_id,diag4 FROM #temp22
UNION 
SELECT distinct pat_id,diag5 FROM #temp22
UNION 
SELECT distinct pat_id,diag6 FROM #temp22
UNION 
SELECT distinct pat_id,diag7 FROM #temp22
UNION 
SELECT distinct pat_id,diag8 FROM #temp22
UNION 
SELECT distinct pat_id,diag9 FROM #temp22
UNION 
SELECT distinct pat_id,diag10 FROM #temp22
UNION 
SELECT  distinct pat_id,diag11 FROM #temp22
UNION 
SELECT  distinct pat_id,diag12 FROM #temp22)   group by 1;
--------------------------------------------

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
    where ndc IN (SELECT distinct ndc from pharmetrics.ndc_codes nc where  mkted_prod_nm = 'ESBRIET')
    GROUP BY 1
  ) b
  ON a.pat_id = b.pat_id and b.rx_dt<dateadd('day',-30,a.diag_dt)
) t
GROUP BY 1;
