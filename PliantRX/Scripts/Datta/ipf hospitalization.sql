select * from pharmetrics.claims c2 where conf_num <>'' limit 100;

select count(distinct pat_id)  from pharmetrics.claims c 
where pat_id in (select pat_id  from pharmetrics.ipf_diag) 
and isnull(conf_num,'')<>''
and date_diff('day',from_dt,to_dt)>1;--26715

with hosp_pat as (
select pat_id,min(from_dt) as from_dt  from pharmetrics.claims c 
where pat_id in (select pat_id  from pharmetrics.ipf_diag) 
and isnull(conf_num,'')<>'' and date_diff('day',from_dt,to_dt)>1
group by pat_id)
select extract(year from from_dt),count(distinct pat_id)  from hosp_pat 
group by 1 order by 1;




drop table if exists   pharmetrics.hospitalized_ipf;
create table pharmetrics.hospitalized_ipf as 
select distinct a.pat_id,a.min_from_dt as ipf_dt,b.first_hosp_dt,b.last_hosp_dt  from pharmetrics.ipf_diag a 
inner join
(select pat_id ,min(from_dt) as  first_hosp_dt,max(to_dt) as  last_hosp_dt  from pharmetrics.claims c 
where pat_id in (select pat_id  from pharmetrics.ipf_diag) and isnull(conf_num,'')<>'' and date_diff('day',from_dt,to_dt)>1
group by pat_id) b on a.pat_id =b.pat_id;

select extract(year from first_hosp_dt),count(distinct pat_id)  from pharmetrics.hospitalized_ipf group by 1 order by 1;
---before
select extract(year from first_hosp_dt),count(distinct pat_id)  from pharmetrics.hospitalized_ipf
where ipf_dt>=first_hosp_dt group by 1 order by 1;
--after
select extract(year from first_hosp_dt),count(distinct pat_id)  from pharmetrics.hospitalized_ipf
where ipf_dt<first_hosp_dt group by 1 order by 1;


select a.*,b.days,b.freq from pharmetrics.hospitalized_ipf a inner join 
(select pat_id,sum(days) as days ,count(*) as freq from  (select distinct pat_id,date_diff('day',min(from_dt),max(to_dt)) as days  from pharmetrics.ipf_claims c 
where pat_id in (select pat_id  from pharmetrics.ipf_diag) and isnull(conf_num,'')<>'' and date_diff('day',from_dt,to_dt)>1 group by pat_id,conf_num)
group by pat_id)
b on a.pat_id=b.pat_id
order by a.pat_id;



select count(distinct a.pat_id)  from pharmetrics.ipf_diag a 
inner join
(select pat_id ,from_dt as  from_hosp_dt,to_dt as  to_hosp_dt  from pharmetrics.ipf_claims c 
where pat_id in (select pat_id  from pharmetrics.ipf_diag) and isnull(conf_num,'')<>'' 
and date_diff('day',from_dt,to_dt)>1) b 
on a.pat_id =b.pat_id 
where a.min_from_dt between dateadd('day',-7,from_hosp_dt) and dateadd('day',7,to_hosp_dt);