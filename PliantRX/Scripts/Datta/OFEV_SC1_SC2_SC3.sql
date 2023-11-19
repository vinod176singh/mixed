--
--select * into pharmetrics.ofev_table  FROM pharmetrics.claims  WHERE pat_id IN (SELECT DISTINCT pat_id   FROM pharmetrics.claims c   WHERE ndc 
--in(SELECT DISTINCT ndc   FROM pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV'))

-- overall pts journey
select count(distinct pat_id) from pharmetrics.ofev_table where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from pharmetrics.ofev_table where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from pharmetrics.ofev_table where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from pharmetrics.ofev_table where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);



--on min rx date
create table #temp1 as 
select c.* from pharmetrics.claims c 
inner join
(select pat_id,min(from_dt) as rx_dt from pharmetrics.ofev_table  c2 where ndc in(select ndc from pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV') group by 1)a 
on a.pat_id=c.pat_id where rx_dt = from_dt

select * from #temp1;


--
--SELECT ic.* from pharmetrics.ipf_claims ic 
--inner join
--(select * from #tepmp)b on ic.pat_id=b.pat_id where ic.from_dt =b.min_from_dt

--  create table #tepmp as select a.* from(
--  select pat_id,min_from_dt from pharmetrics.ipf_diag id 
--) a
--INNER JOIN (
--  SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
--  FROM pharmetrics.ofev_table ot  
--  WHERE ndc IN (
--    SELECT DISTINCT ndc  
--    FROM pharmetrics.ndc_codes nc 
--    WHERE mkted_prod_nm = 'OFEV'
--    )GROUP BY 1
--) b ON a.pat_id = b.pat_id  where  a.min_from_dt = b.rx_dt;

 SELECT DISTINCT pat_id, MIN(from_dt) AS rx_dt 
  FROM pharmetrics.ofev_table ot  
  WHERE ndc IN (
    SELECT DISTINCT ndc  
    FROM pharmetrics.ndc_codes nc 
    WHERE mkted_prod_nm = 'OFEV'
    )GROUP BY 1

------------------------------------------------------

select count(distinct pat_id) from #temp1 where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp1 where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp1 where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp1 where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);

--on rx date
create table #temp2 as 
select c.* from pharmetrics.claims c 
inner join
(select pat_id,from_dt as rx_dt from pharmetrics.ofev_table  c2 where ndc in(select ndc from pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV') )a 
on a.pat_id=c.pat_id where rx_dt = from_dt


select count(distinct pat_id) from #temp2 where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp2 where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp2 where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp2 where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);


--on +-30 days

create table #temp3 as 
select c.* from pharmetrics.claims c 
inner join
(select pat_id,min(from_dt) as rx_dt from pharmetrics.ofev_table  c2 where ndc in(select ndc from pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV') group by 1 )a 
on a.pat_id=c.pat_id where from_dt between dateadd(day,-30,rx_dt) and dateadd(day,30,rx_dt)

--select * from #temp3


select count(distinct pat_id) from #temp3 where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp3 where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp3 where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp3 where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);


create table #temp4 as 
select c.* from pharmetrics.claims c 
inner join
(select pat_id,min(from_dt) as rx_dt from pharmetrics.ofev_table  c2 where ndc in(select ndc from pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV') group by 1 )a 
on a.pat_id=c.pat_id where from_dt between dateadd(day,-45,rx_dt) and dateadd(day,45,rx_dt)

--select * from #temp3


select count(distinct pat_id) from #temp4 where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp4 where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp4 where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp4 where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);


create table #temp5 as 
select c.* from pharmetrics.claims c 
inner join
(select pat_id,min(from_dt) as rx_dt from pharmetrics.ofev_table  c2 where ndc in(select ndc from pharmetrics.ndc_codes nc WHERE mkted_prod_nm = 'OFEV') group by 1 )a 
on a.pat_id=c.pat_id where from_dt between dateadd(day,-60,rx_dt) and dateadd(day,60,rx_dt)

--select * from #temp3


select count(distinct pat_id) from #temp5 where 'M3481' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp5 where 'J84112' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp5 where 'J84170' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);
select count(distinct pat_id) from #temp5 where 'J8410' in(diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12);




