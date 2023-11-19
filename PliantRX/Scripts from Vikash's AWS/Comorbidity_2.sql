select distinct pat_id, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12 from pharmetrics.claims

select * from pharmetrics.claims 
where ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))
and 'E860' in (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12)

drop table if exists #diag_code;
-------IPF: 5924 distinct comorbidity;
create temp table #diag_code as (
select pat_id, diag2 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag3 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag4 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag5 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag6 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag7 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag8 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag9 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag10 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag11 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag12 from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
union select pat_id,  diag_admit from pharmetrics.claims
where diag1 in ('51631', 'J84112') and from_dt=to_dt
)

select * from pharmetrics.claims where 'R0902' in (diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) and  diag1 in ('51631', 'J84112') 

select diag2, count(diag2) from #diag_code
group by diag2
order by count desc 



select #diag_code.diag2, #diag_code.count, pharmetrics.dx_lookup.diagnosis_desc  from #diag_code 
inner join pharmetrics.dx_lookup on #diag_code.diag2=pharmetrics.dx_lookup.dx_cd
order by count desc

-------PSC:4820 distinct comorbidities;
create temp table #diag_code_psc as (
select	diag2, count(diag2)  from (
select pat_id, diag2 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag3 from pharmetrics.claims
where diag1 in ('5761', 'K8301') 
union select pat_id,  diag4 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag5 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag6 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag7 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag8 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag9 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag10 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag11 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag12 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag_admit from pharmetrics.claims
where diag1 in ('5761', 'K8301')
)
group by diag2
order by count desc )

select #diag_code_psc.diag2, #diag_code_psc.count, pharmetrics.dx_lookup.diagnosis_desc  from #diag_code_psc 
inner join pharmetrics.dx_lookup on #diag_code_psc.diag2=pharmetrics.dx_lookup.dx_cd
order by count desc




select pat_id, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12 from pharmetrics.claims
where diag1 in ('51631', 'J84112')

select count(distinct pat_id)  from pharmetrics.claims
where diag1 in ('51631', 'J84112') 



--------Code for unique IPF pts with certain comorbid condition
select count(distinct pat_id) from  
(select pat_id, diag2 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag3 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag4 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag5 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag6 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag7 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag8 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag9 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag10 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag11 from pharmetrics.claims
where diag1 in ('51631', 'J84112')
union select pat_id,  diag12 from pharmetrics.claims
where diag1 in ('51631', 'J84112'))
where diag2 in ('G4733')


--------Code for unique PSC pts with certain comorbid condition
select count(distinct  pat_id) from  
(select pat_id, diag2 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag3 from pharmetrics.claims
where diag1 in ('5761', 'K8301') 
union select pat_id,  diag4 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag5 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag6 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag7 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag8 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag9 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag10 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag11 from pharmetrics.claims
where diag1 in ('5761', 'K8301')
union select pat_id,  diag12 from pharmetrics.claims
where diag1 in ('5761', 'K8301'))
where diag2 in ('78900', '78901')


----------------------------------------------------------------------------------------------

--------IPF-------


create temp table #tab_1 as
(select * from pharmetrics.claims
where from_dt=to_dt 
and pat_id in (select distinct pat_id from pharmetrics.claims
 where ('51631' IN (diag1) 
      OR 'J84112' IN (diag1))))
           
select count(distinct pat_id) from #tab_1 where diag1 in ('51631','J84112' )
      
drop table if exists #tab_4;

create temp table #tab_2 as (
select pat_id,  diag1, from_dt  from #tab_1 where diag1 not in ('')
union all select pat_id,  diag2, from_dt  from #tab_1 where diag2 not in ('')
union all select pat_id,  diag3, from_dt  from #tab_1 where diag3 not in ('')
union all select pat_id,  diag4, from_dt  from #tab_1 where diag4 not in ('')
union all select pat_id,  diag5, from_dt  from #tab_1 where diag5 not in ('')
union all select pat_id,  diag6, from_dt  from #tab_1 where diag6 not in ('')
union all select pat_id,  diag7, from_dt  from #tab_1 where diag7 not in ('')
union all select pat_id,  diag8, from_dt  from #tab_1 where diag8 not in ('')
union all select pat_id,  diag9, from_dt  from #tab_1 where diag9 not in ('')
union all select pat_id,  diag10, from_dt  from #tab_1 where diag10 not in ('')
union all select pat_id,  diag11, from_dt  from #tab_1 where diag11 not in ('')
union all select pat_id,  diag12, from_dt  from #tab_1 where diag12 not in ('')
)

 select count(distinct pat_id)  from #tab_1 where diag1 in ('51631','J84112' )
 
select diag2, count(diag2)  from #tab_2
group by diag2
order by count desc

-------Distint Pts count for each comorbidity
create temp table #tab_3 as (
select pat_id, diag1, min(from_dt) from #tab_2 
group by pat_id, diag1
order by pat_id)

select pat_id, min(min) from #tab_3 where diag1 in('51631','J84112')
group  by pat_id

create temp table #tab_3_1 as 
select pat_id, diag1, min from #tab_3 where pat_id in (select pat_id from #tab_3 where diag1 in('51631','J84112') and  (min >='2016-01-01' and min <='2020-12-31'))


select count(distinct pat_id)  from #tab_4 


create temp table #tab_4 as
select #tab_3.pat_id, #tab_3.diag1, #tab_3.min, b.min as date from #tab_3 
inner join 
(select pat_id, min(min) from #tab_3 where diag1 in('51631','J84112')
group  by pat_id)b
on #tab_3.pat_id = b.pat_id


create temp table #tab_5 as
select diag1, count(diag1) from #tab_4 where min<date 
group by diag1 
order by count desc 
 
select *  from #tab_4 limit 1000

select a.diag1, a.count, pharmetrics.dx_lookup.diagnosis_desc from 
(select diag1, count(diag1) from #tab_4  
group by diag1 
order by count desc )a
inner join pharmetrics.dx_lookup on a.diag1=pharmetrics.dx_lookup.dx_cd 
order by count desc

select count(distinct  pat_id) from #tab_3 where diag1 in('51631','J84112')


--------PSC-------


create temp table #tab_1_psc as  ----- 17608
(select * from pharmetrics.claims
where from_dt=to_dt 
and pat_id in (select distinct pat_id from pharmetrics.claims
 where ('5761' IN (diag1) 
      OR 'K8301' IN (diag1))))
           
select count(distinct pat_id) from #tab_1_psc 
      
      
drop table if exists #tab_5_psc;

create temp table #tab_2_psc as (
select pat_id,  diag1, from_dt  from #tab_1_psc where diag1 not in ('')
union all select pat_id,  diag2, from_dt  from #tab_1_psc where diag2 not in ('')
union all select pat_id,  diag3, from_dt  from #tab_1_psc where diag3 not in ('')
union all select pat_id,  diag4, from_dt  from #tab_1_psc where diag4 not in ('')
union all select pat_id,  diag5, from_dt  from #tab_1_psc where diag5 not in ('')
union all select pat_id,  diag6, from_dt  from #tab_1_psc where diag6 not in ('')
union all select pat_id,  diag7, from_dt  from #tab_1_psc where diag7 not in ('')
union all select pat_id,  diag8, from_dt  from #tab_1_psc where diag8 not in ('')
union all select pat_id,  diag9, from_dt  from #tab_1_psc where diag9 not in ('')
union all select pat_id,  diag10, from_dt  from #tab_1_psc where diag10 not in ('')
union all select pat_id,  diag11, from_dt  from #tab_1_psc where diag11 not in ('')
union all select pat_id,  diag12, from_dt  from #tab_1_psc where diag12 not in ('')
)

select count(distinct pat_id) from #tab_1_psc where ('5761' IN (diag1) 
      OR 'K8301' IN (diag1))
 
select diag2, count(diag2)  from #tab_2_psc
group by diag2
order by count desc

-------Distint Pts count for each comorbidity
create temp table #tab_3_psc as (
select pat_id, diag1, min(from_dt) from #tab_2_psc 
group by pat_id, diag1
order by pat_id)

drop table if exists #tab_4_psc;

select * from #tab_2  where  pat_id = '003kladm19n9d5gi'

create temp table #tab_3_1_psc as 
select pat_id, diag1, min from #tab_3_psc where pat_id in (select pat_id from #tab_3_psc where diag1 in('5761','K8301') and  (min >='2016-01-01' and min <='2020-12-31'))

----Create #tab_3_1 for analysis for a particular period and then create tab_4 from 3_1

create temp table #tab_4_psc as
select #tab_3_psc.pat_id, #tab_3_psc.diag1, #tab_3_psc.min, b.min as date from #tab_3_psc
inner join 
(select pat_id, min(min) from #tab_3_psc where diag1 in('5761','K8301')
group  by pat_id)b
on #tab_3_psc.pat_id = b.pat_id

select *  from #tab_3_psc

drop table if exists #tab_3_1_psc;
create temp table #tab_5_psc as
select diag1, count(diag1) from #tab_4_psc  
group by diag1 
order by count desc 
 


select a.diag1, a.count, pharmetrics.dx_lookup.diagnosis_desc from 
(select diag1, count(diag1) from #tab_4_psc where min<date
group by diag1 
order by count desc )a
inner join pharmetrics.dx_lookup on a.diag1=pharmetrics.dx_lookup.dx_cd 
order by count desc




select a.diag1, a.count, pharmetrics.dx_lookup.diagnosis_desc from 
(select diag1, count( diag1) from #tab_3_psc
group by diag1
order by count desc )a
inner join pharmetrics.dx_lookup on a.diag1=pharmetrics.dx_lookup.dx_cd 
order by count desc

select *  from #tab_4_psc  limit 100


select count(distinct pat_id) from (select pat_id,date, min(min)  from #tab_4_psc
where diag1 in ('R945', '7824', 'K7460', 'K7689', 'K769', '7948', 'R17', 'K760', 'R188', '5738', '5715', 'K766', '78959', '5739', 'K7469', 'K7290', 'K754')
group by pat_id, date )
where  min<date

group by pat_id 
order by min desc


--------------------------------

create temp table #tab_1_transplant as  
(select * from pharmetrics.claims
where ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12) ))


drop table if exists #tab_4_transplant;

create temp table #tab_2_transplant as (
select pat_id,  proc_cde, from_dt  from #tab_1_transplant where icdprc1 IS NOT NULL
union all select pat_id,  icdprc1, from_dt  from #tab_1_transplant where icdprc1 IS NOT NULL
union all select pat_id,  icdprc2, from_dt  from #tab_1_transplant where icdprc2 IS NOT NULL
union all select pat_id,  icdprc3, from_dt  from #tab_1_transplant where icdprc3 IS NOT NULL
union all select pat_id,  icdprc4, from_dt  from #tab_1_transplant where icdprc4 IS NOT NULL
union all select pat_id,  icdprc5, from_dt  from #tab_1_transplant where icdprc5 IS NOT NULL
union all select pat_id,  icdprc6, from_dt  from #tab_1_transplant where icdprc6 IS NOT NULL
union all select pat_id,  icdprc7, from_dt  from #tab_1_transplant where icdprc7 IS NOT NULL
union all select pat_id,  icdprc8, from_dt  from #tab_1_transplant where icdprc8 IS NOT NULL
union all select pat_id,  icdprc9, from_dt  from #tab_1_transplant where icdprc9 IS NOT NULL
union all select pat_id,  icdprc10, from_dt  from #tab_1_transplant where icdprc10 IS NOT NULL
union all select pat_id,  icdprc11, from_dt  from #tab_1_transplant where icdprc11 IS NOT NULL
union all select pat_id,  icdprc12, from_dt  from #tab_1_transplant where icdprc12 IS NOT NULL
)

create temp table #tab_3_transplant as (
select pat_id, proc_cde, min(from_dt) from #tab_2_transplant 
group by pat_id, proc_cde
order by pat_id)


create temp table #tab_4_transplant as
select #tab_3_transplant.pat_id, #tab_3_transplant.proc_cde, #tab_3_transplant.min as proc_date, b.min as ipf_date from #tab_3_transplant 
inner join 
(select pat_id, min(min) from #tab_3 where diag1 in('51631','J84112')
group  by pat_id)b
on #tab_3_transplant.pat_id = b.pat_id

select * from #tab_4_transplant limit 100

select count(distinct pat_id) from #tab_4_transplant
where proc_cde in ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1', '3352', '32853', '3351', '0BYL0Z1', '3350', '32854', '32852')
