create table  pharmetrics.ofev_diag_claims as 
select pat_id,rx_dt,'OFEV' as Category from pharmetrics.ovef_rx_pat
union 
select pat_id,ipf_diag_dt,'1_IPF' as Category from pharmetrics.ovef_rx_pat
union 
select pat_id,j8410_diag_dt,'2_J8410' as Category from pharmetrics.ovef_rx_pat
union 
select pat_id,m3481_diag_dt,'4_M3481' as Category from pharmetrics.ovef_rx_pat
union 
select pat_id,j84170_diag_dt,'3_J84170' as Category from pharmetrics.ovef_rx_pat;


select * from pharmetrics.ofev_diag_claims  where pat_id='04awh6mact0rt7zz' order by rx_dt;

;with pat_journey as (
select pat_id,dense_rank() over(partition by pat_id order by rx_dt) as rank_number,rx_dt,category from 
pharmetrics.ofev_diag_claims )
,ofev
as (select pat_id, rank_number,rx_dt from pat_journey where category='OFEV')
,before_ofev as (select a.pat_id ,a.rx_dt,a.category,a.rank_number from pat_journey a inner join ofev b on a.pat_id=b.pat_id and a.rank_number+1=b.rank_number)
,after_ofev as (select a.pat_id ,a.rx_dt,a.category,a.rank_number from pat_journey a inner join ofev b on a.pat_id=b.pat_id and  a.rank_number=b.rank_number+1)
--select * from after_ofev
select distinct a.pat_id,a.rx_dt,a.rank_number,b.rx_dt as before_date,b.category,b.rank_number
,c.rx_dt as after_date,c.category,c.rank_number from ofev a 
left join before_ofev b on a.pat_id=b.pat_id
left join after_ofev c on c.pat_id=a.pat_id 
where a.pat_id is not null
--and  a.pat_id='04awh6mact0rt7zz'
--where  pat_id='04awh6mact0rt7zz';
order by a.pat_id,b.category,c.category;
select min(svc_dt) from laad_data.rx_claim rc 