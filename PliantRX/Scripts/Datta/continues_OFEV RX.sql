select 
case when day_gap >=0 and day_gap<=360 then '1_yr'
when day_gap >360 and day_gap<=720 then '2_yr'
when day_gap >720 and day_gap<=1080 then '3_yr'
when day_gap >1080 and day_gap<=1440 then '4_yr'
when day_gap >1440 and day_gap<=1800 then '5_yr'
when day_gap>1440 then  'more than 5_yr'
end as Years,
count(distinct pat_id) from(
SELECT DISTINCT pat_id, MIN(from_dt) AS min_rx_dt,max(from_dt) AS max_rx_dt ,datediff(day,min_rx_dt,max_rx_dt) as day_gap
  FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1) group by 1;
    
   
   
select * from pharmetrics.ipf_claims ic where pat_id='5pj2qbspvzwbansq'
   
    
   
--   select distinct  dayssup,quan from #temp where ndc IN (
--    SELECT DISTINCT ndc
--    FROM pharmetrics.ndc_codes nc 
--    WHERE mkted_prod_nm = 'OFEV'
    )
    
SELECT *  into #temp FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )
   
  
   
--    select count(distinct pat_id) from (
--   select  pat_id,from_dt as pr_dt,lead(from_dt) over(partition by pat_id order by pr_dt asc) as nxt_dt ,datediff(day,pr_dt,nxt_dt) as day_gap 
--  from #temp
--  where ndc IN (
--    SELECT DISTINCT ndc  
--    FROM pharmetrics.ndc_codes nc 
--    WHERE mkted_prod_nm = 'OFEV') ) where day_gap < 30
    
    select * from (
    SELECT DISTINCT pat_id, MIN(from_dt) AS min_rx_dt,max(from_dt) AS max_rx_dt ,sum(dayssup) as dayssup
    ,datediff(day,min_rx_dt,max_rx_dt) as day_gap
    FROM #temp 
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV' 
    )   GROUP BY 1 ) where day_gap <> 0 and dayssup < day_gap + 30
    
    --------------------------------------------------
    
  SELECT t.*
FROM (
    SELECT DISTINCT pat_id, MIN(from_dt) AS min_rx_dt, MAX(from_dt) AS max_rx_dt, SUM(dayssup) AS dayssup,
           DATEDIFF(day, MIN(from_dt), MAX(from_dt)) AS day_gap
    FROM #temp 
    WHERE ndc IN (
        SELECT DISTINCT ndc  
        FROM pharmetrics.ndc_codes nc 
        WHERE mkted_prod_nm = 'OFEV' 
    )   
    GROUP BY pat_id
) t
INNER JOIN (
	select  c.pat_id,c.from_dt as max_from_dt,c.dayssup from #temp c
	inner join 
    (SELECT pat_id, MAX(from_dt) AS max_from_dt
    FROM #temp 
    GROUP BY pat_id)d on c.pat_id=d.pat_id and c.from_dt=d.max_from_dt
) t2 
ON t.pat_id = t2.pat_id AND t.max_rx_dt = t2.max_from_dt
WHERE t.day_gap <> 0 AND t.dayssup  >(t.day_gap + t2.dayssup)

   



select * from #temp where pat_id='48zkbieczlxyfphw'
   
--   SELECT
--  pat_id,
--  MIN(from_dt) AS min_rx_dt,
--  MAX(from_dt) AS max_rx_dt,
--  SUM(dayssup) AS dayssup,
--  DATEDIFF(day, MIN(from_dt), MAX(from_dt)) AS day_gap
--FROM #temp 
--WHERE ndc IN (
--  SELECT DISTINCT ndc  
--  FROM pharmetrics.ndc_codes nc 
--  WHERE mkted_prod_nm = 'OFEV'
--)
--GROUP BY pat_id
--HAVING day_gap <> 0 
--  AND SUM(dayssup) < day_gap + (
--    SELECT dayssup
--    FROM (
--      SELECT 
--        pat_id,
--        from_dt,
--        dayssup,
--        ROW_NUMBER() OVER (PARTITION BY pat_id ORDER BY from_dt DESC) AS row_num
--      FROM #temp
--    ) last_rx
--    WHERE last_rx.pat_id = #temp.pat_id AND last_rx.row_num = 1
--  );
--
--
--      
--select * from #temp where pat_id='5lbzg974r16hbu2k' order by from_dt desc