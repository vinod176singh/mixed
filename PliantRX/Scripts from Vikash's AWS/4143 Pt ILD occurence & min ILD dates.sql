create table #temp as 
select distinct pat_id, min(from_dt) as min_ofev_dt,max(from_dt) as max_ofev_dt from pharmetrics.ofev_table 
where ndc in ((select distinct ndc from pharmetrics.ndc_codes nc where  mkted_prod_nm = 'OFEV'))
group by 1

create table #temp2 as 
select * FROM(
select distinct  pat_id,claimno, diag_admit,from_dt from(
SELECT distinct  pat_id,claimno, diag_admit,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno,diag1,from_dt from pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,claimno,diag2,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,claimno,diag3,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,claimno,diag4,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno, diag5,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno, diag6,from_dt FROM  pharmetrics.ofev_table
UNION
SELECT distinct  pat_id,claimno,diag7,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno, diag8,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno, diag9,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno,diag10,from_dt FROM pharmetrics.ofev_table
UNION 
SELECT distinct  pat_id,claimno, diag11,from_dt FROM  pharmetrics.ofev_table
UNION 
SELECT distinct pat_id,claimno,diag12,from_dt from pharmetrics.ofev_table)) where diag_admit<>''

create table #temp3 as 
select distinct a.*,b.max_diag_dt,b.diag_admit from 
#temp a
left join 
(select distinct  a.pat_id,b.max_diag_dt,a.diag_admit from 
(select * from #temp2) a
inner join 
(select distinct  a.pat_id,max(a.from_dt) as max_diag_dt from (
(select distinct * from #temp2 where diag_admit in ('J84112','J84170','M3481','J8410')) a
inner join
(select * from #temp) b on a.pat_id=b.pat_id and a.from_dt <b.min_ofev_dt) group by 1) b 
on a.pat_id =b.pat_id and a.from_dt=b.max_diag_dt and a.diag_admit in  ('J84112','J84170','M3481','J8410')) b 
on a.pat_id=b.pat_id

select * from #temp3

select distinct a.pat_id,a.min_ofev_dt,a.max_ofev_dt,b.J84112_cnt,c.J84170_cnt,d.M3481_cnt,e.J8410_cnt,f.min_J84112_dt,
g.min_J84170_dt,h.min_M3481_dt,i.min_J8410_dt from 
(select * from #temp3) a
left join 
(select distinct a.pat_id,count(distinct a.claimno) as J84112_cnt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit in ('J84112','51631')
group by 1) b on a.pat_id=b.pat_id
left join 
(select distinct a.pat_id,count(distinct a.claimno) as J84170_cnt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='J84170'
group by 1) c on a.pat_id=c.pat_id
left join 
(select distinct a.pat_id,count(distinct a.claimno) as M3481_cnt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='M3481'
group by 1) d on a.pat_id=d.pat_id
left join
(select distinct a.pat_id,count(distinct a.claimno) as J8410_cnt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='J8410'
group by 1) e on a.pat_id=e.pat_id
left join 
(select distinct a.pat_id,min(A.from_dt) as min_J84112_dt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit in ('J84112','51631')
group by 1) f on a.pat_id=f.pat_id
left join
(select distinct a.pat_id,min(A.from_dt) as min_J84170_dt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='J84170'
group by 1) g on a.pat_id=g.pat_id
left join 
(select distinct a.pat_id,min(A.from_dt) as min_M3481_dt from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='M3481'
group by 1) h on a.pat_id=h.pat_id
left join 
(select distinct a.pat_id,min(A.from_dt) as min_J8410_dt  from #temp2 A
inner join 
#temp3 B on A.pat_id=B.pat_id and A.from_dt between B.min_ofev_dt and B.max_ofev_dt where a.diag_admit='J8410'
group by 1) i on a.pat_id=i.pat_id

select distinct * from pharmetrics.claims  where pat_id in (select distinct pat_id from pharmetrics.ipf_claims where pat_id not in (select distinct pat_id from #temp2 where diag_admit in ('J84112','J8410','M3481','51631','J84170'))
and pat_id in (select distinct pat_id from pharmetrics.ofev_table ))

select distinct * from pharmetrics.ofev_table  where pat_id='uhapdu99m13hfrba' --and diag_admit in ('J8410')