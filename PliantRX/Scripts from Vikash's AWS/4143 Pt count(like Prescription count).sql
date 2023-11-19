select distinct * into #temp from(
select * from(
SELECT distinct pat_id,from_dt,diag_admit FROM pharmetrics.ofev_table
UNION 
SELECT  distinct pat_id,from_dt,diag1 FROM pharmetrics.ofev_table
UNION 
SELECT  distinct pat_id,from_dt,diag2 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag3 FROM pharmetrics.ofev_table
UNION 
SELECT  distinct pat_id,from_dt,diag4 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag5 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag6 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag7 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag8 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag9 FROM pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,from_dt,diag10 FROM pharmetrics.ofev_table
UNION 
SELECT  distinct pat_id,from_dt,diag11 FROM pharmetrics.ofev_table
UNION 
SELECT  distinct pat_id,from_dt,diag12 FROM pharmetrics.ofev_table)) 

where diag_admit  IN('J84112','J84170','M3481','J8410','51631')



-------------------------------------------------------------------------------------------------

drop table  if exists #temp2;
SELECT distinct a.* into #temp2
FROM (
  SELECT DISTINCT pat_id, from_dt AS diag_dt ,diag_admit from #temp  where diag_admit   IN('J84112','J84170','M3481','J8410','51631')
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.ofev_table  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id where  a.diag_dt=b.rx_dt; 


select distinct pat_id from #temp2 t ;

drop table  if exists #temp2;
drop table  if exists #temp4;


SELECT 
  *,
  CASE diag_admit
    WHEN 'J84112' THEN 4
    WHEN '51631' THEN 4
     WHEN 'J8410' THEN 3
    WHEN 'M3481' THEN 2
    WHEN 'J84170' THEN 1
  END AS diag_priority into #temp3
FROM #temp2;

select pat_id,diag_dt,min(diag_priority) as priority_no  into #temp4 from #temp3 group by 1,2;

select extract(year from diag_dt),count(distinct pat_id) as pts_count from #temp4 where priority_no=1 group by 1 order by 1;

------+-----------------------------------------------------------------------------------------------------------------------------------------------------------
--+/ 30,45,60 days gap
drop table if exists #temp2;
drop table if exists #temp4;
drop table if exists #temp55;

SELECT distinct a.*,b.rx_dt into #temp2
FROM (
  SELECT DISTINCT pat_id, from_dt AS diag_dt ,diag_admit from #temp where diag_admit  IN('J84112','J84170','M3481','J8410','51631')
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.ofev_table  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id where  a.diag_dt between dateadd(day,-60,b.rx_dt) and dateadd(day,60,b.rx_dt)

select distinct * ,ABS(DATEDIFF(day, rx_dt, diag_dt)) into #temp3 from #temp2;

select distinct a.* into #temp4 from #temp3 a
inner join
(select pat_id,rx_dt,min(distinct abs)  from #temp3 group by 1,2)b on a.pat_id=b.pat_id and a.rx_dt=b.rx_dt and b.min=a.abs;


select a.* into #temp55 from #temp4 a
inner join
(select distinct pat_id,rx_dt,min(distinct diag_dt) diag_dt from #temp4 t  group by 1,2)b on a.pat_id=b.pat_id and a.rx_dt=b.rx_dt and a.diag_dt=b.diag_dt;


drop table  if exists #temp5;
drop table  if exists #temp66;

SELECT 
  *,
  CASE diag_admit
    WHEN 'J84112' THEN 4
    WHEN '51631' THEN 4
    WHEN 'J8410' THEN 3
    WHEN 'M3481' THEN 2
    WHEN 'J84170' THEN 1
  END AS diag_priority into #temp5
FROM #temp55;

select pat_id,rx_dt,diag_dt,min(diag_priority) as priority_no  into #temp66 from #temp5 group by 1,2,3;

select extract(year from rx_dt),count(distinct pat_id)as priority_no from #temp66 where priority_no=4 group by 1 order by 1;


--select priority_no,count(distinct pat_id) from #temp66 group by 1 order by 2 desc

  SELECT DISTINCT pat_id from pharmetrics.ofev_table ot  where pat_id not in( select distinct pat_id from #temp where diag_admit   IN('J84112','J84170','M3481','J8410','51631'))
 
  
 


