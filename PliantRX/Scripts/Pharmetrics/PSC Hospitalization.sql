select count(distinct pat_id)  from pharmetrics.psc_claims c 
where pat_id in (select pat_id  from pharmetrics.psc_diag) 
and isnull(conf_num,'')<>''
and date_diff('day',from_dt,to_dt)>1;--16665

drop table if exists   pharmetrics.hospitalized_psc;
create table pharmetrics.hospitalized_psc as 
select distinct a.pat_id,a.min_from_dt as psc_dt,b.first_hosp_dt,b.last_hosp_dt  from pharmetrics.psc_diag a 
inner join
(select pat_id ,min(from_dt) as  first_hosp_dt,max(to_dt) as  last_hosp_dt  from pharmetrics.psc_claims c 
where pat_id in (select pat_id  from pharmetrics.psc_diag) and isnull(conf_num,'')<>'' and date_diff('day',from_dt,to_dt)>1
group by pat_id) b on a.pat_id =b.pat_id;

select count(*) from pharmetrics.hospitalized_psc where psc_dt>=first_hosp_dt;


--cross validation data
select a.*,b.days,b.freq from pharmetrics.hospitalized_psc a inner join 
(select pat_id,sum(days) as days ,count(*) as freq from  (select distinct pat_id,date_diff('day',min(from_dt),max(to_dt)) as days  from pharmetrics.psc_claims c 
where pat_id in (select pat_id  from pharmetrics.psc_diag) and isnull(conf_num,'')<>'' and date_diff('day',from_dt,to_dt)>1 group by pat_id,conf_num)
group by pat_id)
b on a.pat_id=b.pat_id
order by a.pat_id;

select *  from pharmetrics.psc_claims c where pat_id ='019z89xyd9eyiyxp'
--and  date_diff('day',from_dt,to_dt)>1;


select count(distinct a.pat_id)  from pharmetrics.psc_diag a 
inner join
(select pat_id ,from_dt as  from_hosp_dt,to_dt as  to_hosp_dt  from pharmetrics.psc_claims c 
where pat_id in (select pat_id  from pharmetrics.psc_diag) and isnull(conf_num,'')<>'' 
and date_diff('day',from_dt,to_dt)>1) b 
on a.pat_id =b.pat_id 
where a.min_from_dt between dateadd('day',-7,from_hosp_dt) and dateadd('day',7,to_hosp_dt);