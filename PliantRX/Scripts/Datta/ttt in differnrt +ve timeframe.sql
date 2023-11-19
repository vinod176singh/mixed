select 
CASE 
    WHEN diag_dt > rx_dt+90 and diag_dt <= DATEADD(day, 180, rx_dt+90) THEN '180 '
    WHEN diag_dt > DATEADD(day, 180, rx_dt+90) and  diag_dt<=DATEADD(day, 360, rx_dt+90) THEN '360 '
    WHEN diag_dt > DATEADD(day, 360, rx_dt+90) and diag_dt<=DATEADD(day, 540, rx_dt+90) THEN '540'
    WHEN diag_dt > DATEADD(day, 540, rx_dt+90) and diag_dt<=DATEADD(day, 720, rx_dt+90) THEN '720'
    WHEN diag_dt > DATEADD(day, 720, rx_dt+90) and  diag_dt<= DATEADD(day, 900, rx_dt+90) THEN '900'
    WHEN diag_dt > DATEADD(day, 900, rx_dt+90) and  diag_dt<= DATEADD(day, 1080, rx_dt+90) THEN '1080'
    WHEN diag_dt > DATEADD(day, 1080, rx_dt+90) and  diag_dt<= DATEADD(day, 1260, rx_dt+90) THEN '1260'
    WHEN diag_dt > DATEADD(day, 1260, rx_dt+90) and  diag_dt<= DATEADD(day, 1440, rx_dt+90) THEN '1440'
    when  diag_dt > DATEADD(day, 1440, rx_dt+90)then ' greater 1440' 
  END AS treatment_category
  ,count(distinct pat_id)
  from(SELECT distinct a.pat_id, a.diag_dt,a.max_diagdt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
FROM (
  SELECT DISTINCT pat_id, MIN(from_dt) AS diag_dt ,max(from_dt) as max_diagdt
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
) b ON a.pat_id = b.pat_id) group by 1;