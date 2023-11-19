--create table pharmetrics.ipf_diag as 
--select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.ipf_claims c 
--where pat_id in (select pat_id from pharmetrics.ipf_diag)
--group by pat_id 

create table pharmetrics.ipf_diag_treatment as 
select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag) and
ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF')
group by pat_id 


--select date_part('year',min_from_dt) ,count(distinct pat_id) from pharmetrics.ipf_diag group by 1 order by 1;
--
--select date_part('year',from_dt),count(distinct pat_id) from (
--select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
--where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2020)
--group by pat_id)
--group by date_part('year',from_dt)
--order by 1;
select A.diag_yr,coalesce(B.surv_dt,C.surv_dt,D.surv_dt,E.surv_dt,F.surv_dt,G.surv_dt,H.surv_dt,I.surv_dt,J.surv_dt) as surv_dt,
coalesce(B.surv_pt_cnt,C.surv_pt_cnt,D.surv_pt_cnt,E.surv_pt_cnt,F.surv_pt_cnt,G.surv_pt_cnt,H.surv_pt_cnt,I.surv_pt_cnt,J.surv_pt_cnt) as surv_pt_cnt  from 
(select date_part('year',min_from_dt) as diag_yr ,count(distinct pat_id) as diag_pt_cnt from pharmetrics.ipf_diag group by 1) A
left join 
(select 2014 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2014)
group by pat_id)
group by date_part('year',from_dt)) B on A.diag_yr=B.diag_yr
left join 
(select 2015 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2015)
group by pat_id)
group by date_part('year',from_dt)) C on A.diag_yr=C.diag_yr
left join 
(select 2016 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2016)
group by pat_id)
group by date_part('year',from_dt)) D on A.diag_yr=D.diag_yr
left join 
(select 2017 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2017)
group by pat_id)
group by date_part('year',from_dt)) E on A.diag_yr=E.diag_yr
left join 
(select 2018 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2018)
group by pat_id)
group by date_part('year',from_dt)) F on A.diag_yr=F.diag_yr
left join 
(select 2019 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2019)
group by pat_id)
group by date_part('year',from_dt)) G on A.diag_yr=G.diag_yr
left join 
(select 2020 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2020)
group by pat_id)
group by date_part('year',from_dt)) H on A.diag_yr=H.diag_yr
left join 
(select 2021 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2021)
group by pat_id)
group by date_part('year',from_dt)) I on A.diag_yr=I.diag_yr
left join 
(select 2022 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag where date_part('year',min_from_dt)=2022)
group by pat_id)
group by date_part('year',from_dt)) J on A.diag_yr=J.diag_yr;



select A.diag_yr,coalesce(B.surv_dt,C.surv_dt,D.surv_dt,E.surv_dt,F.surv_dt,G.surv_dt,H.surv_dt,I.surv_dt,J.surv_dt) as surv_dt,
coalesce(B.surv_pt_cnt,C.surv_pt_cnt,D.surv_pt_cnt,E.surv_pt_cnt,F.surv_pt_cnt,G.surv_pt_cnt,H.surv_pt_cnt,I.surv_pt_cnt,J.surv_pt_cnt) as surv_pt_cnt  from 
(select date_part('year',min_from_dt) as diag_yr ,count(distinct pat_id) as diag_pt_cnt from pharmetrics.ipf_diag_treatment group by 1) A
left join 
(select 2014 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2014)
group by pat_id)
group by date_part('year',from_dt)) B on A.diag_yr=B.diag_yr
left join 
(select 2015 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2015)
group by pat_id)
group by date_part('year',from_dt)) C on A.diag_yr=C.diag_yr
left join 
(select 2016 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2016)
group by pat_id)
group by date_part('year',from_dt)) D on A.diag_yr=D.diag_yr
left join 
(select 2017 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2017)
group by pat_id)
group by date_part('year',from_dt)) E on A.diag_yr=E.diag_yr
left join 
(select 2018 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2018)
group by pat_id)
group by date_part('year',from_dt)) F on A.diag_yr=F.diag_yr
left join 
(select 2019 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2019)
group by pat_id)
group by date_part('year',from_dt)) G on A.diag_yr=G.diag_yr
left join 
(select 2020 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2020)
group by pat_id)
group by date_part('year',from_dt)) H on A.diag_yr=H.diag_yr
left join 
(select 2021 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2021)
group by pat_id)
group by date_part('year',from_dt)) I on A.diag_yr=I.diag_yr
left join 
(select 2022 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.ipf_claims c 
where pat_id in (select pat_id from pharmetrics.ipf_diag_treatment where date_part('year',min_from_dt)=2022)
group by pat_id)
group by date_part('year',from_dt)) J on A.diag_yr=J.diag_yr;