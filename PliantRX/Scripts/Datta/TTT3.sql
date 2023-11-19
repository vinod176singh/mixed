
----Ipf patient takinng Rx


--------------------------------------------------------------------------------
 --IPF patient taking Rxs after Dxs

SELECT count(distinct a.pat_id)--, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
) b ON a.pat_id = b.pat_id where  a.diag_dt < b.rx_dt;

-------------------------------------------------------------------------
--IPF patient taking Rxs before Dxs


SELECT count(distinct a.pat_id)--, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt > b.rx_dt;
------------------------------------------------------
drop table if exists #temp1;
create table #temp1 as 
select c.pat_id ,from_dt ,diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11,
diag12 from pharmetrics.claims c 
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
) b ON a.pat_id = b.pat_id  ) d on d.pat_id=c.pat_id and c.from_dt = d.rx_dt;


select diag_admit,count(distinct pat_id) from #temp1 group by diag_admit;



select distinct diag_admit ,count(distinct pat_id)from(
SELECT distinct pat_id,diag_admit FROM #temp1
UNION 
SELECT  distinct pat_id,diag1 FROM #temp1
UNION 
SELECT  distinct pat_id,diag2 FROM #temp1
UNION 
SELECT distinct pat_id,diag3 FROM #temp1
UNION 
SELECT  distinct pat_id,diag4 FROM #temp1
UNION 
SELECT distinct pat_id,diag5 FROM #temp1
UNION 
SELECT distinct pat_id,diag6 FROM #temp1
UNION 
SELECT distinct pat_id,diag7 FROM #temp1
UNION 
SELECT distinct pat_id,diag8 FROM #temp1
UNION 
SELECT distinct pat_id,diag9 FROM #temp1
UNION 
SELECT distinct pat_id,diag10 FROM #temp1
UNION 
SELECT  distinct pat_id,diag11 FROM #temp1
UNION 
SELECT  distinct pat_id,diag12 FROM #temp1) where diag_admit <> '' group by 1;

-----------------------------------------------------------------------------------------------------------------------
select extract (year from diag_dt) as Diag_year,extract (year from rx_dt)  as rx_dt ,count(distinct pat_id)from(
SELECT a.pat_id, a.diag_dt, b.rx_dt
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
) b ON a.pat_id = b.pat_id ) group by 1,2;

---------------------------------------------------------------------------------------------

--months wise

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
  ON a.pat_id = b.pat_id and b.rx_dt>=a.diag_dt
) t
GROUP BY 1;
--------------------------------------------------------

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
  ON a.pat_id = b.pat_id and b.rx_dt<a.diag_dt
) t
GROUP BY 1;
---------------------------------------------------------------------
SELECT 
  Diag_year, 
  RX_year, 
  COUNT(DISTINCT CASE WHEN RX_month = 1 THEN pat_id ELSE NULL END) AS Jan_count,
  COUNT(DISTINCT CASE WHEN RX_month = 2 THEN pat_id ELSE NULL END) AS Feb_count,
  COUNT(DISTINCT CASE WHEN RX_month = 3 THEN pat_id ELSE NULL END) AS Mar_count,
  COUNT(DISTINCT CASE WHEN RX_month = 4 THEN pat_id ELSE NULL END) AS Apr_count,
  COUNT(DISTINCT CASE WHEN RX_month = 5 THEN pat_id ELSE NULL END) AS May_count,
  COUNT(DISTINCT CASE WHEN RX_month = 6 THEN pat_id ELSE NULL END) AS Jun_count,
  COUNT(DISTINCT CASE WHEN RX_month = 7 THEN pat_id ELSE NULL END) AS Jul_count,
  COUNT(DISTINCT CASE WHEN RX_month = 8 THEN pat_id ELSE NULL END) AS Aug_count,
  COUNT(DISTINCT CASE WHEN RX_month = 9 THEN pat_id ELSE NULL END) AS Sep_count,
  COUNT(DISTINCT CASE WHEN RX_month = 10 THEN pat_id ELSE NULL END) AS Oct_count,
  COUNT(DISTINCT CASE WHEN RX_month = 11 THEN pat_id ELSE NULL END) AS Nov_count,
  COUNT(DISTINCT CASE WHEN RX_month = 12 THEN pat_id ELSE NULL END) AS Dec_count
FROM (SELECT  extract(year from diag_dt) AS Diag_year, extract(year from rx_dt) AS RX_year, extract(month from rx_dt) AS RX_month,
    pat_id FROM ( SELECT  a.pat_id, a.diag_dt,b.rx_dt FROM (SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt FROM pharmetrics.claims  
      WHERE (
        '51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
        OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
      ) 
      GROUP BY 1
    ) a
    INNER JOIN (
      SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt FROM pharmetrics.claims  WHERE ndc IN (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes nc 
        WHERE mkted_prod_nm = 'OFEV')
      GROUP BY 1) b ON a.pat_id = b.pat_id and b.rx_dt>=a.diag_dt
  ) t
) t2 
GROUP BY 1, 2
ORDER BY 1, 2;


-----------------------------------------------------------------------
select pat_id,diag_dt,rx_dt,days,listagg(distinct dx_code,',') from(
select distinct c.pat_id ,d.diag_dt,d.rx_dt,d.days,TRIM(BOTH ',' FROM COALESCE(diag_admit || ',' ||COALESCE(diag1, '') || ',' ||COALESCE(diag2, '') || ',' ||COALESCE(diag3, '') || ',' ||
    COALESCE(diag4, '') || ',' ||COALESCE(diag5, '') || ',' ||COALESCE(diag6, '') || ',' ||COALESCE(diag7, '') || ',' ||COALESCE(diag8, '') || ',' ||COALESCE(diag9, '') || ',' ||
    COALESCE(diag10, '') || ',' ||COALESCE(diag11, '') || ',' ||COALESCE(diag12, '')
  ))
  AS Dx_code  from pharmetrics.claims c 
inner join
(SELECT a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt > b.rx_dt)d on c.pat_id =d.pat_id and d.rx_dt =c.from_dt ) group by 1,2,3,4;

--------------------------------------------------------------------------------
select pat_id,diag_dt,rx_dt,days,listagg(distinct dx_code,',') from(
select distinct c.pat_id ,d.diag_dt,d.rx_dt,d.days,TRIM(BOTH ',' FROM COALESCE(diag_admit || ',' ||COALESCE(diag1, '') || ',' ||COALESCE(diag2, '') || ',' ||COALESCE(diag3, '') || ',' ||
    COALESCE(diag4, '') || ',' ||COALESCE(diag5, '') || ',' ||COALESCE(diag6, '') || ',' ||COALESCE(diag7, '') || ',' ||COALESCE(diag8, '') || ',' ||COALESCE(diag9, '') || ',' ||
    COALESCE(diag10, '') || ',' ||COALESCE(diag11, '') || ',' ||COALESCE(diag12, '')
  ))
  AS Dx_code  from pharmetrics.claims c 
inner join
(SELECT a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
) b ON a.pat_id = b.pat_id  where  a.diag_dt <= b.rx_dt)d on c.pat_id =d.pat_id and d.rx_dt =c.from_dt ) group by 1,2,3,4;


------------------------------------------------------------
--diagnosis code associated with # pts

--drop table #temp2;
create table #temp2 as
select c.* from pharmetrics.claims c 
inner join
 (select  pat_id,min(from_dt) as rx_dt FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV')group by 1)b on c.pat_id =b.pat_id where c.from_dt =b.rx_dt

--select * from #temp1 where diag_admit='';
--select * from #temp1 where pat_id='2t5cvn5kvhg0e1wt'
    select * from #temp2
    
--    select * from pharmetrics.dx_lookup dl ;

select  distinct dx_cd , diagnosis_desc  from pharmetrics.dx_lookup dc where dx_cd in(
select distinct diag_admit from(
SELECT diag_admit FROM #temp2
UNION 
SELECT diag1 FROM #temp2
UNION 
SELECT  diag2 FROM #temp2
UNION 
SELECT diag3 FROM #temp2
UNION 
SELECT  diag4 FROM #temp2
UNION 
SELECT diag5 FROM #temp2
UNION 
SELECT diag6 FROM #temp2
UNION 
SELECT diag7 FROM #temp2
UNION 
select diag8 FROM #temp2
UNION 
SELECT diag9 FROM #temp2
UNION 
select diag10 FROM #temp2
UNION 
SELECT  diag11 FROM #temp2
UNION 
SELECT  diag12 FROM #temp2) where diag_admit <> ' ');




select distinct diag_admit ,count(distinct pat_id)from(
SELECT distinct pat_id,diag_admit FROM #temp2
UNION 
SELECT  distinct pat_id,diag1 FROM #temp2
UNION 
SELECT  distinct pat_id,diag2 FROM #temp2
UNION 
SELECT distinct pat_id,diag3 FROM #temp2
UNION 
SELECT  distinct pat_id,diag4 FROM #temp2
UNION 
SELECT distinct pat_id,diag5 FROM #temp2
UNION 
SELECT distinct pat_id,diag6 FROM #temp2
UNION 
SELECT distinct pat_id,diag7 FROM #temp2
UNION 
SELECT distinct pat_id,diag8 FROM #temp2
UNION 
SELECT distinct pat_id,diag9 FROM #temp2
UNION 
SELECT distinct pat_id,diag10 FROM #temp2
UNION 
SELECT  distinct pat_id,diag11 FROM #temp2
UNION 
SELECT  distinct pat_id,diag12 FROM #temp2) where  diag_admit 
in('515','5160','5161','5162','51630','51631','51632','51633','51634','51635','51636','51637','5164','5165','51661','51662','51663','51664','51669','5169','J8410','J8489','J8401','J8403','J8402','J84111','J84112','J84113','J84114','J84115','J842','J84116','J84117','J8481','J8482','J84841','J84842','J8483','J84843','J84848','J849')
group by 1 order by 2 desc;



















