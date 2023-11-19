select 'select * from pharmetrics.'||tablename||';'  from pg_catalog.pg_tables where schemaname='pharmetrics';

select * from pharmetrics.pos_lookup;
select * from pharmetrics.pr_lookup where procedure_desc like '%OXYGEN%' and (procedure_cd like '33%' or procedure_cd like '5A%');
select * from pharmetrics.rev_lookup;
select * from pharmetrics.dx_lookup;
select * from pharmetrics.rx_lookup;
select * from pharmetrics.enroll limit 10;
select * from pharmetrics.enroll2 limit 1;
select * from pharmetrics.claims limit 10;

select count(distinct rend_id) from pharmetrics.claims;
select distinct  from pharmetrics.claims;


select * from pharmetrics.cpt_codes where prc_custom_lvl1_desc='PSC';
select * from  pharmetrics.dx_codes;
select * from pharmetrics.hcpcs_code;
select * from pharmetrics.icdproc_codes where prc_custom_lvl1_desc='PSC';
select * from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC'


select 'select * from pharmetrics.'||tablename||';'  from pg_catalog.pg_tables where schemaname='pharmetrics';
grant all on schema laad_data to dhake,vdas;
select * from pharmetrics.pos_lookup;
select * from pharmetrics.pr_lookup where procedure_desc like '%OXYGEN%' and (procedure_cd like '33%' or procedure_cd like '5A%');
select * from pharmetrics.rev_lookup;
select * from pharmetrics.dx_lookup;
select * from pharmetrics.rx_lookup;
select * from pharmetrics.enroll limit 10;
select * from pharmetrics.enroll2 limit 10;
select count(distinct rend_id) from pharmetrics.claims limit 10;

select count(distinct rend_id) from pharmetrics.claims;
select *  from pharmetrics.claims limit 10;
select distinct pay_type  from pharmetrics.enroll2 limit 10;

select * from pharmetrics.cpt_codes where prc_custom_lvl1_desc='IPF';
select * from  pharmetrics.dx_codes;
select * from pharmetrics.hcpcs_code;
select * from pharmetrics.icdproc_codes where prc_custom_lvl1_desc='IPF';
select * from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'
