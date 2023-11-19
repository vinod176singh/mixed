select count(distinct pat_id) from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and (to_dt-from_dt=0) 
 
 select * from pharmetrics.pos_lookup pl 
 
select * from pharmetrics.pos_lookup 
where place_of_svc_cd in (select distinct pos from pharmetrics.claims where (to_dt-from_dt>1) 
and ('51631' IN (diag_admit) OR 'J84112' IN (diag_admit)))

--------7893/7883
select count( pat_id)  from pharmetrics.claims 
where ((to_dt-from_dt>0) 
and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
      
and rectype in ('A', 'J', 'F', 'M', 'S')     

-----place of service (POS)
select * from pharmetrics.pos_lookup 
where place_of_svc_cd in (select distinct pos from pharmetrics.claims 
where (to_dt-from_dt>1) 
and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
      
      
------rectype
select count (distinct pat_id)  from pharmetrics.claims 
where (to_dt-from_dt>1) 
and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and rectype in ('P')
  

SELECT a.pat_id, a.min_diag_date, b.all_hospitalized_dt
FROM (
SELECT pat_id, MIN(from_dt) AS min_diag_date
FROM pharmetrics.claims
WHERE to_dt - from_dt > 1
AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12))
GROUP BY pat_id
) a
INNER JOIN (
SELECT pat_id, LISTAGG(from_dt, ',') AS all_hospitalized_dt
FROM (
SELECT DISTINCT pat_id, from_dt
FROM pharmetrics.claims c
WHERE (to_dt - from_dt > 1)
AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
) AND from_dt <= (
SELECT min(from_dt)
FROM pharmetrics.claims
WHERE pat_id = c.pat_id
AND to_dt - from_dt > 1
AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
))
ORDER BY 2
) t
GROUP BY pat_id
) b ON a.pat_id = b.pat_id
WHERE b.all_hospitalized_dt <= a.min_diag_date ;
