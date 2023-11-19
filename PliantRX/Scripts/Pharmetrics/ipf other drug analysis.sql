select 'FULL DATA-(DX+TX) BUT not three drugs' as type, count(distinct pat_id) as pat_cnt from pharmetrics.ipf_claims 
where pat_id in (select pat_id from pharmetrics.ipf_diag) and pat_id  not in (
 select distinct pat_id from pharmetrics.ipf_claims  where ndc in (
select distinct ndc from pharmetrics.rx_lookup where  
generic_name  in ('NINTEDANIB ESYLATE','PIRFENIDONE','TREPROSTINIL')))
 
