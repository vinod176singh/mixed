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
SELECT  distinct pat_id,from_dt,diag12 FROM pharmetrics.ofev_table)) where diag_admit<>''

SELECT distinct a.* into #temp2
FROM (
  SELECT DISTINCT pat_id, from_dt AS diag_dt ,diag_admit from #temp  where pat_id not in (select distinct pat_id from #temp where  
  diag_admit   IN('J84112','J84170','M3481','J8410','51631'))
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


SELECT distinct a.*,b.rx_dt into #temp2
FROM (SELECT DISTINCT pat_id, from_dt AS diag_dt ,diag_admit from #temp  where pat_id not in (select distinct pat_id from #temp where  
  diag_admit   IN('J84112','J84170','M3481','J8410','51631'))
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.ofev_table  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id where  a.diag_dt between dateadd(day,-30,b.rx_dt) and dateadd(day,30,b.rx_dt)

