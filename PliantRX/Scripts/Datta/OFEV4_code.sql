--TPS
select extract(year from from_dt),count(distinct pat_id) from pharmetrics.claims c2  where ndc  in(
select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV') group by 1 order by 1;


--NPS
select extract(year from min_dt),count(distinct pat_id) from
(select pat_id ,min(from_dt) as min_dt from pharmetrics.claims c2  where ndc  in(
select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV') group by 1) group by 1 order by 1;




--overall pt count
select count(distinct pat_id) from pharmetrics.claims c where ndc 
in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV');


        
----------------------------------------------------------------------------------------------------------------
--the patients taking OFEV had ILD diagnosis(including ipf)

--'J84112' ,'M3481' ,'J84170','J8410' 


--TPS

select extract(year from a.from_dt),count(distinct a.pat_id) from (  
select *  from pharmetrics.claims c where ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))a
inner join 
(select * from pharmetrics.claims c2  where 
diag_admit 
in('J84112' ,'M3481' ,'J84170','J8410') OR
 diag1 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag2 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag3 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag4 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag5 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag6 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag7 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag8 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag9 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag10 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag11 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag12 
in('J84112' ,'M3481' ,'J84170','J8410'))b on a.pat_id=b.pat_id group by 1 order by 1;

--NPS
select extract(year from a.min_dt),count(distinct a.pat_id) from (  
select distinct pat_id,min(from_dt) as min_dt  from pharmetrics.claims c 
where ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')group by 1)a
inner join 
(select distinct pat_id ,from_dt from pharmetrics.claims c2  where 
diag_admit 
in('J84112' ,'M3481' ,'J84170','J8410') OR
 diag1 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag2 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag3 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag4 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag5 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag6 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag7 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag8 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag9 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag10 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag11 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag12 
in('J84112' ,'M3481' ,'J84170','J8410'
))b on a.pat_id=b.pat_id group by 1 order by 1;


--all ptn count

select  count(distinct pat_id) from pharmetrics.claims c2 where pat_id in(
select distinct pat_id from pharmetrics.claims c where ndc 
in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))  and   
(diag_admit 
in('J84112' ,'M3481' ,'J84170','J8410') OR
 diag1 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag2 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag3 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag4 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag5 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag6 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag7 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag8 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag9 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag10 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag11 
in('J84112' ,'M3481' ,'J84170','J8410') OR
diag12 
in('J84112' ,'M3481' ,'J84170','J8410'));

---------------------------------------------------------------------------------------------------------------------
--OFEV had ipf 
select distinct pat_id from pharmetrics.claims c2 where pat_id in(select distinct pat_id from pharmetrics.claims c where ndc 
in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')) and (--'51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
         'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12))
    
 --tps
 SELECT year, COUNT(DISTINCT pat_id)
FROM (
    SELECT EXTRACT(YEAR FROM a.from_dt) AS year, a.pat_id
    FROM (
        SELECT DISTINCT pat_id, from_dt
        FROM pharmetrics.claims
        WHERE ndc IN (
            SELECT ndc
            FROM pharmetrics.ndc_codes
            WHERE mkted_prod_nm = 'OFEV'
        )
    ) AS a
    inner JOIN (
        SELECT DISTINCT pat_id
        FROM pharmetrics.claims
        WHERE --'51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
             'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
    ) AS b
    ON a.pat_id = b.pat_id
) AS c
GROUP BY year
ORDER BY year;
        --NPS


        SELECT year, COUNT(DISTINCT pat_id)
FROM (
    SELECT EXTRACT(YEAR FROM a.from_dt) AS year, a.pat_id
    FROM (
        SELECT DISTINCT pat_id, min(from_dt) as from_dt
        FROM pharmetrics.claims
        WHERE ndc IN (
            SELECT ndc
            FROM pharmetrics.ndc_codes
            WHERE mkted_prod_nm = 'OFEV'
        ) group by 1
    ) AS a
    inner JOIN (
        SELECT DISTINCT pat_id
        FROM pharmetrics.claims
        WHERE --'51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
             'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
    ) AS b
    ON a.pat_id = b.pat_id
) AS c
GROUP BY year
ORDER BY year;



        --------------------------------------------------------------------------------------------------------------------------------
       --
       
        
 ---- OFEV patient with no ipf and no ILD
        ---- OFEV without ipf and ILD
 
 --Tps
select extract(year from from_dt),count(distinct pat_id) from( 
select  distinct pat_id ,from_dt    from pharmetrics.claims c where 
ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))
where pat_id  not in  
(select distinct pat_id from pharmetrics.claims c2  where
(diag_admit  
in('J84112' ,'M3481' ,'J84170','J8410') or
 diag1 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag2 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag3 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag4 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag5 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag6 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag7 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag8 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag9 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag10 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag11 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag12 
 in('J84112' ,'M3481' ,'J84170','J8410'))) group by 1 order by 1;



 
 
 
 
 ---NPS
select extract(year from min_dt),count(distinct pat_id) from( 
select  distinct pat_id ,min(from_dt) as min_dt    from pharmetrics.claims c where 
ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')group by 1)
where pat_id  not in  
(select distinct pat_id from pharmetrics.claims c2  where
(diag_admit  
in('J84112' ,'M3481' ,'J84170','J8410') or
 diag1 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag2 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag3 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag4 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag5 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag6 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag7 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag8 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag9 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag10 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag11 
 in('J84112' ,'M3481' ,'J84170','J8410') or
diag12 
 in('J84112' ,'M3481' ,'J84170','J8410'))) group by 1 order by 1;

---total cnt

select count(distinct pat_id) from (
select pat_id from pharmetrics.claims c where ndc in(select distinct ndc from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))
 where pat_id  not in
(select distinct pat_id from pharmetrics.claims c2 where
(diag_admit 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag1 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag2 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag3 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag4 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag5 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag6 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag7 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag8 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag9 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag10 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag11 
in('J84112' ,'M3481' ,'J84170','J8410') or
diag12 
in('J84112' ,'M3481' ,'J84170','J8410')));


-------------OFEV pts with ILD(excluding ipf)
--TPS

select extract(year from a.from_dt),count(distinct a.pat_id) from (  
select *  from pharmetrics.claims c where ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))a
inner join 
(select * from pharmetrics.claims c2  where 
diag_admit 
in('M3481' ,'J84170','J8410') OR
 diag1 
in('M3481' ,'J84170','J8410') OR
diag2 
in('M3481' ,'J84170','J8410') OR
diag3 
in('M3481' ,'J84170','J8410') OR
diag4 
in('M3481' ,'J84170','J8410') OR
diag5 
in('M3481' ,'J84170','J8410') OR
diag6 
in('M3481' ,'J84170','J8410') OR
diag7 
in('M3481' ,'J84170','J8410') OR
diag8 
in('M3481' ,'J84170','J8410') OR
diag9 
in('M3481' ,'J84170','J8410') OR
diag10 
in('M3481' ,'J84170','J8410') OR
diag11 
in('M3481' ,'J84170','J8410') OR
diag12 
in('M3481' ,'J84170','J8410'))b on a.pat_id=b.pat_id group by 1 order by 1;

--NPS
select extract(year from a.min_dt),count(distinct a.pat_id) from (  
select distinct pat_id,min(from_dt) as min_dt  from pharmetrics.claims c where ndc in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV')group by 1)a
inner join 
(select distinct pat_id ,from_dt from pharmetrics.claims c2  where 
diag_admit 
in('M3481' ,'J84170','J8410') OR
 diag1 
in('M3481' ,'J84170','J8410') OR
diag2 
in('M3481' ,'J84170','J8410') OR
diag3 
in('M3481' ,'J84170','J8410') OR
diag4 
in('M3481' ,'J84170','J8410') OR
diag5 
in('M3481' ,'J84170','J8410') OR
diag6 
in('M3481' ,'J84170','J8410') OR
diag7 
in('M3481' ,'J84170','J8410') OR
diag8 
in('M3481' ,'J84170','J8410') OR
diag9 
in('M3481' ,'J84170','J8410') OR
diag10 
in('M3481' ,'J84170','J8410') OR
diag11 
in('M3481' ,'J84170','J8410') OR
diag12 
in('M3481' ,'J84170','J8410'))b on a.pat_id=b.pat_id group by 1 order by 1;


--all ptn count

select count(distinct pat_id) from pharmetrics.claims c2 where pat_id in(select distinct pat_id from pharmetrics.claims c where ndc 
in(select distinct ndc  from pharmetrics.ndc_codes nc where mkted_prod_nm='OFEV'))  and   
(diag_admit 
in('M3481' ,'J84170','J8410') OR
 diag1 
in('M3481' ,'J84170','J8410') OR
diag2 
in('M3481' ,'J84170','J8410') OR
diag3 
in('M3481' ,'J84170','J8410') OR
diag4 
in('M3481' ,'J84170','J8410') OR
diag5 
in('M3481' ,'J84170','J8410') OR
diag6 
in('M3481' ,'J84170','J8410') OR
diag7 
in('M3481' ,'J84170','J8410') OR
diag8 
in('M3481' ,'J84170','J8410') OR
diag9 
in('M3481' ,'J84170','J8410') OR
diag10 
in('M3481' ,'J84170','J8410') OR
diag11 
in('M3481' ,'J84170','J8410') OR
diag12 
in('M3481' ,'J84170','J8410'));
