drop table if exists pharmetrics.psc_diag_10;
create  table pharmetrics.psc_diag_10 as 
select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.psc_claims c 
where diag_admit = 'K8301' or diag1 ='K8301' or diag2 ='K8301' or diag3 ='K8301' or diag4 ='K8301' or diag5 ='K8301' or diag6 ='K8301' or diag7 ='K8301' or diag8 ='K8301' or diag9 ='K8301' or diag10 ='K8301' or diag11 ='K8301' or diag12 ='K8301'
group by pat_id;

SELECT count(distinct pat_id) FROM pharmetrics.psc_diag_treatment_10;

drop table if exists pharmetrics.psc_diag_treatment_10;
create table pharmetrics.psc_diag_treatment_10 as 
select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.psc_claims c  
where (
diag_admit = 'K8301' or diag1 ='K8301' or diag2 ='K8301' or diag3 ='K8301' or diag4 ='K8301' or diag5 ='K8301' or diag6 ='K8301' or diag7 ='K8301' or diag8 ='K8301' or diag9 ='K8301' or diag10 ='K8301' or diag11 ='K8301' or diag12 ='K8301'
)
and (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC')
or proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc1 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc2 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc3 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc4 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc5 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc6 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc7 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc8 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc9 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc10 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc11 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc12 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
)
group by pat_id;

select A.diag_yr,coalesce(B.surv_dt,C.surv_dt,D.surv_dt,E.surv_dt,F.surv_dt,G.surv_dt,H.surv_dt,I.surv_dt,J.surv_dt) as surv_dt,
coalesce(B.surv_pt_cnt,C.surv_pt_cnt,D.surv_pt_cnt,E.surv_pt_cnt,F.surv_pt_cnt,G.surv_pt_cnt,H.surv_pt_cnt,I.surv_pt_cnt,J.surv_pt_cnt) as surv_pt_cnt  from 
(select date_part('year',min_from_dt) as diag_yr ,count(distinct pat_id) as diag_pt_cnt from pharmetrics.psc_diag_10 group by 1) A
left join 
(select 2014 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2014)
group by pat_id)
group by date_part('year',from_dt)) B on A.diag_yr=B.diag_yr
left join 
(select 2015 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2015)
group by pat_id)
group by date_part('year',from_dt)) C on A.diag_yr=C.diag_yr
left join 
(select 2016 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2016)
group by pat_id)
group by date_part('year',from_dt)) D on A.diag_yr=D.diag_yr
left join 
(select 2017 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2017)
group by pat_id)
group by date_part('year',from_dt)) E on A.diag_yr=E.diag_yr
left join 
(select 2018 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2018)
group by pat_id)
group by date_part('year',from_dt)) F on A.diag_yr=F.diag_yr
left join 
(select 2019 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2019)
group by pat_id)
group by date_part('year',from_dt)) G on A.diag_yr=G.diag_yr
left join 
(select 2020 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2020)
group by pat_id)
group by date_part('year',from_dt)) H on A.diag_yr=H.diag_yr
left join 
(select 2021 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2021)
group by pat_id)
group by date_part('year',from_dt)) I on A.diag_yr=I.diag_yr
left join 
(select 2022 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_10 where date_part('year',min_from_dt)=2022)
group by pat_id)
group by date_part('year',from_dt)) J on A.diag_yr=J.diag_yr;



select A.diag_yr,coalesce(B.surv_dt,C.surv_dt,D.surv_dt,E.surv_dt,F.surv_dt,G.surv_dt,H.surv_dt,I.surv_dt,J.surv_dt) as surv_dt,
coalesce(B.surv_pt_cnt,C.surv_pt_cnt,D.surv_pt_cnt,E.surv_pt_cnt,F.surv_pt_cnt,G.surv_pt_cnt,H.surv_pt_cnt,I.surv_pt_cnt,J.surv_pt_cnt) as surv_pt_cnt  from 
(select date_part('year',min_from_dt) as diag_yr ,count(distinct pat_id) as diag_pt_cnt from pharmetrics.psc_diag_treatment_10 group by 1) A
left join 
(select 2014 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2014)
group by pat_id)
group by date_part('year',from_dt)) B on A.diag_yr=B.diag_yr
left join 
(select 2015 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2015)
group by pat_id)
group by date_part('year',from_dt)) C on A.diag_yr=C.diag_yr
left join 
(select 2016 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2016)
group by pat_id)
group by date_part('year',from_dt)) D on A.diag_yr=D.diag_yr
left join 
(select 2017 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2017)
group by pat_id)
group by date_part('year',from_dt)) E on A.diag_yr=E.diag_yr
left join 
(select 2018 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2018)
group by pat_id)
group by date_part('year',from_dt)) F on A.diag_yr=F.diag_yr
left join 
(select 2019 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2019)
group by pat_id)
group by date_part('year',from_dt)) G on A.diag_yr=G.diag_yr
left join 
(select 2020 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2020)
group by pat_id)
group by date_part('year',from_dt)) H on A.diag_yr=H.diag_yr
left join 
(select 2021 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2021)
group by pat_id)
group by date_part('year',from_dt)) I on A.diag_yr=I.diag_yr
left join 
(select 2022 as diag_yr,date_part('year',from_dt) as surv_dt,count(distinct pat_id) surv_pt_cnt from (
select pat_id ,max(from_dt) as from_dt from pharmetrics.psc_claims c 
where pat_id in (select pat_id from pharmetrics.psc_diag_treatment_10 where date_part('year',min_from_dt)=2022)
group by pat_id)
group by date_part('year',from_dt)) J on A.diag_yr=J.diag_yr;