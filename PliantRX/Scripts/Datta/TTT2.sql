 select a.pat_id,a.min_from_dt,b.rx_dt ,datediff(day,a.min_from_dt,b.rx_dt) as days from(
 (select * from pharmetrics.ipf_diag id where extract(year from min_from_dt) = '2015' )a
 inner join 
 (select pat_id,min(from_dt)  as rx_dt from pharmetrics.ipf_claims ic where ndc in
 (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes nc WHERE mkted_prod_nm ='OFEV')  group by pat_id)b
 on a.pat_id=b.pat_id) where days<0 --extract(year from b.rx_dt) = '2015'
 
 
  
SELECT 
  EXTRACT(YEAR FROM id.min_from_dt) AS year,count(distinct id.pat_id),
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >=0and  datediff(day,id.min_from_dt,ac.from_dt) <=180 THEN ac.pat_id END) AS pts_cnt_180,
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >180 and datediff(day,id.min_from_dt,ac.from_dt) <=360 THEN ac.pat_id END) AS pts_cnt_360,
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >360 and datediff(day,id.min_from_dt,ac.from_dt) <=540 THEN ac.pat_id END) AS pts_cnt_540,
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >540 and datediff(day,id.min_from_dt,ac.from_dt) <=720 THEN ac.pat_id END) AS pts_cnt_720,
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >720 and datediff(day,id.min_from_dt,ac.from_dt) <=900 THEN ac.pat_id END) AS pts_cnt_900,
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >900 and datediff(day,id.min_from_dt,ac.from_dt) <=1080 THEN ac.pat_id END) AS pts_cnt_1080,
	COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) >1080 THEN  ac.pat_id END) AS ">1080"
  FROM 
  pharmetrics.ipf_diag id
  LEFT JOIN (SELECT DISTINCT pat_id, MIN(from_dt) AS from_dt FROM pharmetrics.ipf_claims 
    WHERE 
      ndc IN (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE mkted_prod_nm = 'OFEV')GROUP BY pat_id) ac ON ac.pat_id = id.pat_id
GROUP BY year
ORDER BY year;

------------------------------------------------


SELECT 
  EXTRACT(YEAR FROM id.min_from_dt) AS year,count(distinct id.pat_id),
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <0 and  datediff(day,id.min_from_dt,ac.from_dt) >= -180 THEN ac.pat_id END) AS "-180",
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-180 and datediff(day,id.min_from_dt,ac.from_dt) >= -360 THEN ac.pat_id END) AS "-360",
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-360 and datediff(day,id.min_from_dt,ac.from_dt) >= -540 THEN ac.pat_id END) AS "-540",
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-540 and datediff(day,id.min_from_dt,ac.from_dt) >=-720 THEN ac.pat_id END) AS "-720",
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-720 and datediff(day,id.min_from_dt,ac.from_dt) >=-900 THEN ac.pat_id END) AS "-900",
  COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-900 and datediff(day,id.min_from_dt,ac.from_dt) >=-1080 THEN ac.pat_id END) AS "-1080",
	COUNT(DISTINCT CASE WHEN datediff(day,id.min_from_dt,ac.from_dt) <-1080 THEN  ac.pat_id END) AS ">-1080"
  FROM 
  pharmetrics.ipf_diag id
  LEFT JOIN (SELECT DISTINCT pat_id, MIN(from_dt) AS from_dt FROM pharmetrics.ipf_claims 
    WHERE 
      ndc IN (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE mkted_prod_nm = 'OFEV')GROUP BY pat_id) ac ON ac.pat_id = id.pat_id
GROUP BY year
ORDER BY year;



------------------------------------------------------------------------
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
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id where a.diag_dt between  dateadd('day',-30,b.rx_dt) and dateadd('day',30,b.rx_dt)
) d on d.pat_id=c.pat_id --where c.from_dt between  dateadd('day',-30,d.rx_dt) and dateadd('day',30,d.rx_dt);

 
select * from #temp11;

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



