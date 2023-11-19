select a.pat_id, a.ipf_diag, b.min_date  from 
(select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where from_dt=to_dt 
and  ( '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id
order by 2 desc)a
inner join 
(select pat_id, min(from_dt) as min_date from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
      OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id)b  
on a.pat_id = b.pat_id


---------------------------------
---------------------------------



drop table if exists #ipf_diag;
create temp table #ipf_diag as 
select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id 
order by 2 desc
	

select date_part(year, ipf_diag) as diag_year, count(pat_id) from #ipf_diag 
where pat_id in (select distinct pat_id from pharmetrics.enroll2)
group by diag_year
order by 1 asc

select count(distinct  pat_id) from pharmetrics.enroll2 where pat_id in (select distinct pat_id from #ipf_diag )

select count(distinct pat_id) from pharmetrics.claims where date_part(year, from_dt) = '2014' and  ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

--------------
create temp table #psc_diag1 as 
select pat_id, from_dt from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select ipf_diag_year, count(pat_id) from ( 
select pat_id, min(from_dt) as ipf_diag, date_part(year,ipf_diag) as ipf_diag_year  from  #psc_diag1
group by pat_id)
group by ipf_diag_year
order by 1 asc 


create temp table #psc_diag2 as 
select pat_id, from_dt from pharmetrics.claims
where ('K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR '5761' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select psc_diag_year, count(pat_id) from ( 
select pat_id, min(from_dt) as psc_diag, date_part(year,psc_diag) as psc_diag_year  from  #psc_diag2
group by pat_id)
group by psc_diag_year
order by 1 asc 


------------------
drop table if exists #psc_tx;

create temp table #psc_diag as 
select pat_id, min(from_dt) as psc_diag from pharmetrics.claims
where ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id 
order by 2 desc

select date_part(year, psc_diag) as diag_year, count(pat_id) from #psc_diag
group by diag_year
order by 2 desc

select date_part(year,min(from_dt)), count(pat_id)  from (select pat_id, from_dt from pharmetrics.claims
where ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
group by date_part(year,min(from_dt)) 
                

------------------Y: Med+Rx--------------------

create temp table #enroll_Y as 
(select pat_id, min(month_id) as first_enroll, max(month_id) as last_enroll, count(distinct month_id) as month_count from pharmetrics.enroll2
where (mstr_enroll_cd in ('Y'))
group by pat_id )

drop table if exists #enroll_M

select * from pharmetrics.enroll2 where pat_id = '2wt0alg8ygegbs72'

select date_part(year, a.ipf_diag) as diag_year, a.pat_id, a.ipf_diag, min(month_id) as first_enroll, max(month_id) as last_enroll, count(distinct month_id) as month_count from 
(select * from #ipf_diag )a
inner join 
pharmetrics.enroll2
on a.pat_id=pharmetrics.enroll2.pat_id
group by diag_year, a.pat_id, a.ipf_diag
order by 1 asc


select a.pat_id, a.ipf_diag, b.first_enroll, b.last_enroll, b.month_count from 
(select * from #ipf_diag where date_part(year, ipf_diag) = '2017')a
inner join 
(select * from #enroll_R)b
on a.pat_id=b.pat_id



select a.pat_id, a.ipf_diag, b.first_enroll, b.last_enroll, b.month_count from 
(select * from #ipf_diag)a
inner join 
(select * from #enroll_Y)b
on a.pat_id=b.pat_id



select pat_id from #ipf_diag where date_part(year, ipf_diag) = '2020'




      
     
------------------R: Rx--------------------
create temp table #enroll_R as 
(select pat_id, min(month_id) as first_enroll,max(month_id) as last_enroll, count(distinct month_id) as month_count  from pharmetrics.enroll2
where ( mstr_enroll_cd in ('R'))
group by pat_id)

      
---------------------M: Med----------------
create temp table #enroll_M as 
(select pat_id, min(month_id) as first_enroll,max(month_id) as last_enroll, count(distinct month_id) as month_count  from pharmetrics.enroll2
where ( mstr_enroll_cd in ('M'))
group by pat_id)



 
------------------------------------------------------
------------------------------------------------------


drop table if exists #psc_diag_icd10;
create temp table #ipf_diag as 
select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
group by pat_id 
order by 2 desc


select count(distinct pat_id) from #psc_diag_icd10 

create temp table #psc_diag_icd10 as 
select pat_id, min(from_dt) as psc_diag from pharmetrics.icd_10_psc
where 'K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) or '5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)
group by pat_id 
order by 2 desc



--final Dx_tx table
create temp table #ipf_dx_tx as 
select pat_id, min(from_dt) as ipf_diag from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and (pat_id in (select distinct pat_id from pharmetrics.claims where '51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
and (pat_id in (select distinct pat_id from pharmetrics.claims where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC in ('IPF'))))
group by pat_id


	

select date_part(year, ipf_diag) as diag_year, count(pat_id) from #ipf_diag 
where pat_id in (select distinct pat_id from pharmetrics.enroll2)
group by diag_year
order by 1 asc

select count(distinct  pat_id) from pharmetrics.enroll2 where pat_id in (select distinct pat_id from #ipf_diag )

select count(distinct pat_id) from pharmetrics.claims where date_part(year, from_dt) = '2014' and  ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

--------------
create temp table #psc_diag1 as 
select pat_id, from_dt from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select ipf_diag_year, count(pat_id) from ( 
select pat_id, min(from_dt) as ipf_diag, date_part(year,ipf_diag) as ipf_diag_year  from  #psc_diag1
group by pat_id)
group by ipf_diag_year
order by 1 asc 


create temp table #psc_diag2 as 
select pat_id, from_dt from pharmetrics.claims
where ('K8301' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR '5761' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))

select psc_diag_year, count(pat_id) from ( 
select pat_id, min(from_dt) as psc_diag, date_part(year,psc_diag) as psc_diag_year  from  #psc_diag2
group by pat_id)
group by psc_diag_year
order by 1 asc 


------------------
drop table if exists #psc_tx;

create temp table #psc_diag as 
select pat_id, min(from_dt) as psc_diag from pharmetrics.claims
where ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
group by pat_id 
order by 2 desc

select date_part(year, psc_diag) as diag_year, count(pat_id) from #psc_diag
group by diag_year
order by 2 desc

select date_part(year,min(from_dt)), count(pat_id)  from (select pat_id, from_dt from pharmetrics.claims
where ('5761' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'K8301' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)))
group by date_part(year,min(from_dt)) 
                

------------------Y: Med+Rx--------------------

create temp table #enroll_Y as 
(select pat_id, min(month_id) as first_enroll, max(month_id) as last_enroll, count(distinct month_id) as month_count from pharmetrics.enroll2
where (mstr_enroll_cd in ('Y'))
group by pat_id )

drop table if exists #enroll_Y

create temp table #enroll_Y_102 as 
(select pat_id, count(distinct month_id) as month_count from pharmetrics.enroll2
where ((month_id between 201401 and 202206) and mstr_enroll_cd in ('Y'))
group by pat_id)


select count(pat_id) from #ipf_diag where pat_id in (select pat_id from #enroll_Y_102 where month_count >100)





select * from pharmetrics.enroll2 where pat_id = '2wt0alg8ygegbs72'

select date_part(year, a.psc_diag) as diag_year, a.pat_id, a.psc_diag, min(month_id) as first_enroll, max(month_id) as last_enroll, count(distinct month_id) as month_count from 
(select * from #psc_diag_icd10 )a
inner join 
pharmetrics.enroll2
on a.pat_id=pharmetrics.enroll2.pat_id
group by diag_year, a.pat_id, a.psc_diag
order by 1 asc

drop table if exists #ipf_ce

create temp table #ipf_ce as
select pat_id, ipf_diag from #ipf_diag where pat_id in (select pat_id from #enroll_Y_102 where month_count=102)
 
create temp table #ipf_mb as 
select distinct pat_id from pharmetrics.claims where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE PROD_CUSTOM_LVL1_DESC in ('IPF'))

select count(distinct pat_id)  from #ipf_ce

select count( distinct pat_id) from pharmetrics.claims where pat_id in (select  pat_id from #ipf_ce)

---create temp table #ipf_ce_all as
---select * from pharmetrics.claims where pat_id in (select  pat_id from #ipf_ce)

select pat_id, min(from_dt) from  pharmetrics.claims c  
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and pat_id in (select pat_id from #ipf_ce )
group by 1


select pat_id, min(from_dt) from  pharmetrics.claims  where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and pat_id in (select pat_id from #ipf_ce )
and pat_id in (select pat_id from pharmetrics.claims  where ndc in (SELECT DISTINCT ndc FROM pharmetrics.ndc_codes WHERE MKTED_PROD_NM in ('PIRFENIDONE')))
group by 1

select pat_id, min(from_dt) from  pharmetrics.claims  where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and pat_id in (select pat_id from #ipf_ce )
and pat_id in (select pat_id from #ipf_mb)
group by 1

select count( distinct dist_pts_count), generic_name from (
select a.ndc, a.counts, a.dist_pts_count , b.product_name, b.generic_name from 
(select ndc, count(ndc) as counts, count(distinct pat_id) as dist_pts_count  from pharmetrics.claims 
where pat_id in (select pat_id from #ipf_ce )
and pat_id not in (select pat_id from #ipf_mb)
group by 1)a
inner join
(select ndc, product_name, generic_name from pharmetrics.rx_lookup)b
on a.ndc=b.ndc)
where generic_name in ( 'PREDNISONE')
group  by 2



select a.pat_id, a.ipf_diag, b.first_enroll, b.last_enroll, b.month_count from 
(select * from #ipf_dx_tx )a
inner join 
(select * from #enroll_Y)b
on a.pat_id=b.pat_id



select a.pat_id, a.ipf_diag, b.first_enroll, b.last_enroll, b.month_count from 
(select * from #ipf_diag)a
inner join 
(select * from #enroll_Y)b
on a.pat_id=b.pat_id



select pat_id from #ipf_diag where date_part(year, ipf_diag) = '2020'




      
     
------------------R: Rx--------------------
create temp table #enroll_R as 
(select pat_id, min(month_id) as first_enroll,max(month_id) as last_enroll, count(distinct month_id) as month_count  from pharmetrics.enroll2
where ( mstr_enroll_cd in ('R'))
group by pat_id)

      
---------------------M: Med----------------
create temp table #enroll_M as 
(select pat_id, min(month_id) as first_enroll,max(month_id) as last_enroll, count(distinct month_id) as month_count  from pharmetrics.enroll2
where ( mstr_enroll_cd in ('M'))
group by pat_id)



 
