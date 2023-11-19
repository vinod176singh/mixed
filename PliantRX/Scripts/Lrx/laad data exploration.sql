select 'select * from '||schemaname ||'.'||tablename||' limit 10;'  from pg_catalog.pg_tables where schemaname ='laad_data';
select * from laad_data.patient limit 10;
select count(*) from laad_data.provider limit 10;
select * from laad_data.products limit 10;
select * from laad_data.plan limit 10;
select * from laad_data.procedure limit 10;
select * from laad_data.procedure_modifier limit 10;
select * from laad_data.rx_claim limit 10;
select * from laad_data.diagnosis limit 10;
select * from laad_data.patient_act limit 10;
select * from laad_data.dx_p_provider limit 10;
select * from laad_data.dx_claim limit 10;
--delete  from laad_data.rx_claim where month_id='MONTH_ID';
--select min(month_id),max(month_id) from laad_data.dx_claim limit 10;
--select min(month_id),max(month_id) from laad_data.rx_claim limit 10;
--delete from laad_data.diagnosis where diag_cd ='DIAG_CD';
--select * from laad_data.procedure where prc_modr_cd='PRC_MODR_CD';

