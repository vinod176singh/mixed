--yearly MB treatment trend for ipf dignosed patient any where in journey
with IPF_TX as (
select  distinct pat_id,extract(year from min(from_dt)) as from_dt   from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('NINTEDANIB ESYLATE','PIRFENIDONE','TREPROSTINIL'))
and pat_id in (select pat_id from pharmetrics.ipf_diag id)
group by pat_id 
)
select from_dt,count(distinct pat_id) from IPF_TX group by from_dt order by 1;

--MB patient list
select  distinct pat_id into #mb_list   from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('NINTEDANIB ESYLATE','PIRFENIDONE','TREPROSTINIL'))

--Non MB patient yearly trend ipf diagnosed anywhere
with IPF_TX as (
select  distinct ic.pat_id,extract(year from min(min_from_dt)) as from_dt   from pharmetrics.ipf_claims ic
inner join pharmetrics.ipf_diag id on ic.pat_id =id.pat_id 
where  ndc in (select distinct ndc  from pharmetrics.rx_lookup where gpi2_desc in ('ANTIASTHMATIC AND BRONCHODILATOR AGENTS*',
'COUGH/COLD/ALLERGY*','RESPIRATORY AGENTS - MISC.*','CORTICOSTEROIDS*'))
and ic.pat_id not in(select distinct pat_id from #mb_list)
and ic.pat_id in (select pat_id from pharmetrics.ipf_diag id)
group by ic.pat_id 
)
select from_dt,count(distinct pat_id) from IPF_TX group by from_dt
order by 1;

drop table if exists #ipfmb_nonmb_list;
select  distinct pat_id into #ipfmb_nonmb_list   from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('NINTEDANIB ESYLATE','PIRFENIDONE','TREPROSTINIL'))
union 
select  distinct pat_id   from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc  from pharmetrics.rx_lookup where gpi2_desc in ('ANTIASTHMATIC AND BRONCHODILATOR AGENTS*',
'COUGH/COLD/ALLERGY*','RESPIRATORY AGENTS - MISC.*','CORTICOSTEROIDS*'));

select extract(year from min_from_dt),count(distinct pat_id) from pharmetrics.ipf_diag
where pat_id not in (select pat_id from #ipfmb_nonmb_list) group by 1 order by 1;
---TREPROSTINIL yearly trend anywhere ipf diagnosed
with IPF_TX as (
select  distinct pat_id,extract(year from min(from_dt)) as from_dt   from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('TREPROSTINIL'))
and pat_id in (select pat_id from pharmetrics.ipf_diag id)
group by pat_id 
)
select from_dt,count(distinct pat_id) from IPF_TX group by from_dt order by 1;
--drug wise patient count for Non MB
with IPF_Non_Mb_TX as (
select  distinct pat_id,from_dt,ndc   from pharmetrics.ipf_claims 
--where  pat_id not in (select distinct pat_id from pharmetrics.ipf_claims where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('NINTEDANIB ESYLATE','PIRFENIDONE','TREPROSTINIL')))
where pat_id in (select pat_id from #ipfmb_nonmb_list except select pat_id from #mb_list)
)
select distinct generic_name,count(distinct pat_id) as pat_cnt  from IPF_Non_Mb_TX a inner join pharmetrics.rx_lookup b on a.ndc=b.ndc
group by generic_name order by 2 desc;

--Drug wise patient count for Others
with IPF_Non_Mb_TX as (
select  distinct pat_id,from_dt,ndc   from pharmetrics.ipf_claims 
where pat_id not in (select pat_id from #ipfmb_nonmb_list union select pat_id from #mb_list)
)
select distinct generic_name,count(distinct pat_id) as pat_cnt  from IPF_Non_Mb_TX a inner join pharmetrics.rx_lookup b on a.ndc=b.ndc
group by generic_name order by 2 desc;
--IPF diagnosed yearly trend
select extract(year from min_from_dt) as Diag_yr,count(distinct pat_id) from pharmetrics.ipf_diag group by 1 order by 1;

--ipf TREPROSTINIL trend ,TREPROSTINIL any where in the journey
select extract(year from min_from_dt) as Diag_yr,count(distinct pat_id) from pharmetrics.ipf_diag
where pat_id in (
select distinct pat_id from pharmetrics.ipf_claims 
where  ndc in (select distinct ndc from pharmetrics.rx_lookup where  generic_name  in ('TREPROSTINIL'))
)group by 1 order by 1;

--MB IPF diagnosed trend
select extract(year from min_from_dt) as Diag_yr,count(distinct pat_id) from pharmetrics.ipf_diag
where pat_id in (select pat_id from #mb_list)group by 1 order by 1;

--Non MB IPF diagnosed trend
with IPF_TX as (
select  distinct ic.pat_id,extract(year from min(min_from_dt)) as from_dt   from pharmetrics.ipf_claims ic
inner join pharmetrics.ipf_diag id on ic.pat_id =id.pat_id 
where  ndc in (select distinct ndc  from pharmetrics.rx_lookup where gpi2_desc in ('ANTIASTHMATIC AND BRONCHODILATOR AGENTS*',
'COUGH/COLD/ALLERGY*','RESPIRATORY AGENTS - MISC.*','CORTICOSTEROIDS*'))
and ic.pat_id not in(select distinct pat_id from #mb_list)
and ic.pat_id in (select pat_id from pharmetrics.ipf_diag id)
group by ic.pat_id 
)
select from_dt,count(distinct pat_id) from IPF_TX group by from_dt
order by 1;
--Others IPF diagnosed yearly trend
select extract(year from min_from_dt),count(distinct pat_id) from pharmetrics.ipf_diag
where pat_id not in (select pat_id from #ipfmb_nonmb_list) group by 1 order by 1;