--Creation of combined Dag code pool for PSC diagnosed patients
drop table if exists #temp;
create table #temp as
select * FROM(
select distinct  pat_id, diag_admit from(
SELECT distinct  pat_id, diag_admit FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id,diag1 from pharmetrics.ICD_10_PSC
UNION 
SELECT distinct pat_id,diag2 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct pat_id,diag3 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct pat_id,diag4 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id, diag5 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id, diag6 FROM  pharmetrics.ICD_10_PSC
UNION
SELECT distinct  pat_id,diag7 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id, diag8 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id, diag9 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id,diag10 FROM pharmetrics.ICD_10_PSC
UNION 
SELECT distinct  pat_id, diag11 FROM  pharmetrics.ICD_10_PSC
UNION 
SELECT distinct pat_id,diag12 from pharmetrics.ICD_10_PSC)) where diag_admit <>''

drop table if exists #temp2;
create table #temp2 as
select * from #temp 
where pat_id in 
(select distinct pat_id from #temp where diag_admit in 
(select distinct dx_cd from pharmetrics.dx_proc_PSC where 
type_desc in ('Abnormal LFT','Hepatic Fibrosis','Cirrhosis','Portal Hypertension', 'Varices', 'ENCEPHALOPATHY', 'ASCITES')))


drop table if exists #temp3;
create table #temp3 as
select * from pharmetrics.ICD_10_PSC where pat_id in (select distinct pat_id from pharmetrics.ICD_10_PSC where pat_id in
(select distinct pat_id from #temp2
except
select distinct pat_id from #temp2 where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where
type_desc in ('AIH', 'Overlap Syndrom', 'Carcinomas'))))

drop table if exists #temp4;
create table #temp4 as
select * from #temp 
where pat_id in 
(select distinct pat_id from #temp where diag_admit in 
(select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Abnormal LFT'))

drop table if exists #temp5;
create table #temp5 as
select * from #temp4 
where pat_id in 
(select distinct pat_id from #temp where diag_admit in 
(select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Hepatic Fibrosis'))

drop table if exists #temp6;
create table #temp6 as
select * from #temp5 
where pat_id in 
(select distinct pat_id from #temp where diag_admit in 
(select distinct dx_cd from pharmetrics.dx_proc_PSC
where type_desc in ('Cirrhosis','Portal Hypertension', 'Varices', 'ENCEPHALOPATHY', 'ASCITES')))

drop table if exists #temp7;
create table #temp7 as
select * from pharmetrics.ICD_10_PSC where pat_id in (select distinct pat_id from pharmetrics.ICD_10_PSC where pat_id in
(select distinct pat_id from #temp6
except
select distinct pat_id from #temp6 where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where
type_desc in ('AIH', 'Overlap Syndrom', 'Carcinomas'))))


--counts------------------------------------------------------------------------------------------------------------------------
select count(distinct pat_id) from #temp6 where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where
type_desc in ('AIH', 'Overlap Syndrom', 'Carcinomas'))

select count(distinct pat_id) from #temp
select count(distinct pat_id) from #temp2;
select count(distinct pat_id) from #temp3;
select count(distinct pat_id) from #temp4;
select count(distinct pat_id) from #temp5;
select count(distinct pat_id) from #temp6;
select count(distinct pat_id) from #temp7;
---------------------------------------------------------------------------------------------------------------------------------

select count(distinct pat_id) from #temp 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Abnormal LFT' )

select count(distinct pat_id) from #temp 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Hepatic Fibrosis')

select count(distinct pat_id) from #temp 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc in ('Cirrhosis','Portal Hypertension', 'Varices', 'ENCEPHALOPATHY', 'ASCITES'))

select count(distinct pat_id) from #temp6 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'AIH')

select count(distinct pat_id) from #temp6 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Overlap Syndrom')

select count(distinct pat_id) from #temp6 
where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC where type_desc = 'Carcinomas')

select count (distinct pat_id) from pharmetrics.icd_10_psc
where pat_id not in (select distinct pat_id from #temp2 
union
select distinct pat_id from #temp where diag_admit in (select distinct dx_cd from pharmetrics.dx_proc_PSC 
where type_desc in ('AIH', 'Overlap Syndrom', 'Carcinomas')))