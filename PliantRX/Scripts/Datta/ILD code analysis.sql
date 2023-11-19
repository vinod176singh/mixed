--on all treatement date_part
 
SELECT *  into #temp FROM pharmetrics.claims  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )
    

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
SELECT  distinct pat_id,diag12 FROM #temp1) where diag_admit <> '' and diag_admit in 
()group by 1;
