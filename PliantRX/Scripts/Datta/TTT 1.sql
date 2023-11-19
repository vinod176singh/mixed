select 
  count(distinct CASE WHEN from_dt between dateadd('day',-30,rx_dt ) and rx_dt THEN pat_id END) AS "30 days",
 count(distinct case WHEN from_dt between dateadd('day',-45,rx_dt ) and rx_dt THEN pat_id END) AS "45 days",
 count(distinct case WHEN from_dt between dateadd('day',-60,rx_dt ) and rx_dt THEN pat_id END) AS "60 days",
count(distinct case WHEN from_dt between dateadd('day',-75,rx_dt ) and rx_dt THEN pat_id END) AS "75 days",
 count(distinct case WHEN from_dt between dateadd('day',-90,rx_dt ) and rx_dt THEN pat_id END) AS "90 days",
  count(distinct case WHEN from_dt between dateadd('day',-180,rx_dt ) and rx_dt THEN pat_id END) AS "180 days"
from(SELECT a.pat_id, a.from_dt, b.rx_dt,datediff(day,a.from_dt,b.rx_dt) as days
FROM ( 
  SELECT DISTINCT pat_id, from_dt 
  FROM pharmetrics.ipf_claims   
  WHERE ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
  OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) 
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id ) 

--where a.diag_dt  > b.rx_dt --dateadd('day',-30,b.rx_dt );
-----------------------------------------------------------------------------------------------------------------------
select 
  count(distinct CASE WHEN diag_dt between dateadd('day',-30,rx_dt ) and dateadd('day',30,rx_dt ) THEN pat_id END) AS "30 days",
 count(distinct case WHEN diag_dt between dateadd('day',-45,rx_dt ) and dateadd('day',45,rx_dt ) THEN pat_id END) AS "45 days",
 count(distinct case WHEN diag_dt between dateadd('day',-60,rx_dt ) and dateadd('day',60,rx_dt ) THEN pat_id END) AS "60 days",
count(distinct case WHEN diag_dt between dateadd('day',-75,rx_dt ) and dateadd('day',75,rx_dt ) THEN pat_id END) AS "75 days",
 count(distinct case WHEN diag_dt between dateadd('day',-90,rx_dt ) and dateadd('day',90,rx_dt ) THEN pat_id END) AS "90 days",
  count(distinct case WHEN diag_dt between dateadd('day',-180,rx_dt ) and dateadd('day',180,rx_dt ) THEN pat_id END) AS "180 days"
from(SELECT a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
FROM ( 
  SELECT DISTINCT pat_id, min(from_dt) as diag_dt 
  FROM pharmetrics.ipf_claims   
  WHERE ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
  OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) 
) a
INNER JOIN (
  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1
) b ON a.pat_id = b.pat_id )  group by 1




  
  
  
  
  
  



  
  select 
  CASE 
	  WHEN diag_dt between dateadd('day',-30,rx_dt ) and dateadd('day',30,rx_dt ) THEN '30 days'
WHEN diag_dt between dateadd('day',-45,rx_dt ) and dateadd('day',45,rx_dt ) THEN  '45 days'
WHEN diag_dt between dateadd('day',-60,rx_dt ) and dateadd('day',60,rx_dt ) THEN  '60 days'
 WHEN diag_dt between dateadd('day',-75,rx_dt ) and dateadd('day',75,rx_dt ) THEN '75 days'
WHEN diag_dt between dateadd('day',-90,rx_dt ) and dateadd('day',90,rx_dt ) THEN  '90 days'
WHEN diag_dt between dateadd('day',-180,rx_dt ) and dateadd('day',180,rx_dt ) THEN  '180 days'
else 'unk'
end as daygap,count(distinct pat_id)
from(SELECT a.pat_id, a.diag_dt, b.rx_dt,datediff(day,a.diag_dt,b.rx_dt) as days
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
    )GROUP BY 1 order by 1
) b ON a.pat_id = b.pat_id )  group by 1
	

---------------------------------------------------------------------------------------------------
select CASE 
    WHEN diag_dt < rx_dt and  diag_dt>=DATEADD(day, -180, rx_dt) THEN '-180'
    WHEN diag_dt < DATEADD(day, -180, rx_dt) and  diag_dt>=DATEADD(day, -360, rx_dt) THEN '-360'
    WHEN diag_dt < DATEADD(day, -360, rx_dt) and diag_dt>= DATEADD(day, -540, rx_dt) THEN '-540'
    WHEN diag_dt < DATEADD(day, -540, rx_dt) and diag_dt>=DATEADD(day, -720, rx_dt) THEN '-720'
    WHEN diag_dt < DATEADD(day, -720, rx_dt) and  diag_dt>=DATEADD(day, -900, rx_dt) THEN '-900'
    WHEN diag_dt < DATEADD(day, -900, rx_dt) and  diag_dt>=DATEADD(day, -1080, rx_dt) THEN '-1080'
    WHEN diag_dt < DATEADD(day, -1080, rx_dt) and  diag_dt>=DATEADD(day, -1260, rx_dt) THEN '-1260'
    WHEN diag_dt < DATEADD(day, -1260, rx_dt) and  diag_dt>=DATEADD(day, -1440, rx_dt) THEN '-1440'
    when  diag_dt < DATEADD(day, -1440, rx_dt)then 'below -1440' 
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

-----------------------------------------------------------------------------------------------------------------
select 
CASE 
    WHEN diag_dt > rx_dt and diag_dt <= DATEADD(day, 180, rx_dt) THEN '180 '
    WHEN diag_dt > DATEADD(day, 180, rx_dt) and  diag_dt<=DATEADD(day, 360, rx_dt) THEN '360 '
    WHEN diag_dt > DATEADD(day, 360, rx_dt) and diag_dt<=DATEADD(day, 540, rx_dt) THEN '540'
    WHEN diag_dt > DATEADD(day, 540, rx_dt) and diag_dt<=DATEADD(day, 720, rx_dt) THEN '720'
    WHEN diag_dt > DATEADD(day, 720, rx_dt) and  diag_dt<= DATEADD(day, 900, rx_dt) THEN '900'
    WHEN diag_dt > DATEADD(day, 900, rx_dt) and  diag_dt<= DATEADD(day, 1080, rx_dt) THEN '1080'
    WHEN diag_dt > DATEADD(day, 1080, rx_dt) and  diag_dt<= DATEADD(day, 1260, rx_dt) THEN '1260'
    WHEN diag_dt > DATEADD(day, 1260, rx_dt) and  diag_dt<= DATEADD(day, 1440, rx_dt) THEN '1440'
    when  diag_dt > DATEADD(day, 1440, rx_dt)then '> 1440' 
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

----------------------------------------------------------------------------------------

