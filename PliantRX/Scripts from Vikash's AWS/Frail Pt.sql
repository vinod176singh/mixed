select * from laad_data.diagnosis where diag_short_desc  ilike '%debility%'-- limit 10

select * from laad_data.patient limit 10

select count(distinct patient_id) from #ipf 

drop table #11

create  temp table #ipf as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('J84112', '51631') and patient_id in (select patient_id from laad_data.patient where 2022-pat_brth_yr_nbr>=65 )

create  temp table #wt_loss as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('R634', '7832') and patient_id in (select * from #ipf) ---41733 for abnormal weight loss

create  temp table #weakness as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('72887', 'M6281', 'R531') and patient_id in (select * from #ipf) ---134352 for weakness

create  temp table #fatigue as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('R5383', 'R53', '78079', '7807', 'R5382','R538'   ) and patient_id in (select * from #ipf) ---131181 for fatigue & malaise

create  temp table #walking as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('7197', 'R262'   ) and patient_id in (select * from #ipf) ---55100 for difficulty walking

create  temp table #frail as
select distinct patient_id from laad_data.dx_claim dc where diag_cd in ('R54'   ) and patient_id in (select * from #ipf) ---8845 frailty

create temp table #10 as
select distinct patient_id from #ipf where patient_id in 
(select * from #frail)  
and patient_id in (select * from #weakness)
and patient_id in (select * from #wt_loss)
--and patient_id in (select * from #fatigue)

create temp table #frail_pts as
select * from #1
union   select * from #2
union   select * from #3
union    select * from #4
union    select * from #5
union    select * from #6
union    select * from #7
union    select * from #8
union    select * from #9
union    select * from #10


select * from #frail_pts where patient_id in (select patient_id from laad_data.rx_claim rc where product_id in (select product_id from laad_data.products p where mkted_prod_nm = 'OFEV'))

select * from laad_data.products p limit 10

select * from 
select distinct pts

