/*
create table pharmetrics.ipf_claims
as
select * from pharmetrics.claims c where pat_id in (select pat_id from pharmetrics.ipf_diag)

insert into pharmetrics.ipf_claims 
select * from pharmetrics.claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='IPF'));
*/
/*
drop table if exists pharmetrics.psc_claims;
create table pharmetrics.psc_claims as
select * from pharmetrics.claims 
where (ndc in (select distinct ndc from pharmetrics.ndc_codes where prod_custom_lvl1_desc='PSC') or
proc_cde in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc1 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc2 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc3 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc4 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc5 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc6 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc7 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc8 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc9 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc10 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc11 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
or icdprc12 in ('0F753DZ', '0F753ZZ','0F754DZ', '0F757DZ', '0F758DZ', '0F763DZ', '0F763ZZ', '0F764DZ', '0F767DZ', '0F768DZ','0F773DZ', '0F773ZZ', '0F774DZ', '0F777DZ', '0F778DZ', '0F783DZ', '0F783ZZ', '0F784DZ','0F787DZ', '0F788DZ', '0F793DZ', '0F793ZZ', '0F794DZ', '0F797DZ', '0F798DZ', '0F7C3ZZ','0F7C4DZ', '0F7C7DZ', '0F7C8DZ', '5187', '43274', '47538', '47539', '47540', '47542', '0F9530Z','0F9630Z', '0F9730Z', '0F9830Z', '0F9930Z')
 ) or pat_id in (select pat_id from pharmetrics.PSC_diag);
*/
/*
drop table if exists pharmetrics.PSC_diag;
create table pharmetrics.PSC_diag as 
select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.psc_claims where (diag_admit = '5761' or diag1 ='5761' or diag2 ='5761' or diag3 ='5761' or diag4 ='5761' or diag5 ='5761' or diag6 ='5761' or diag7 ='5761' or diag8 ='5761' or diag9 ='5761' or diag10 ='5761' or diag11 ='5761' or diag12 ='5761'
or diag_admit = 'K8301' or diag1 ='K8301' or diag2 ='K8301' or diag3 ='K8301' or diag4 ='K8301' or diag5 ='K8301' or diag6 ='K8301' or diag7 ='K8301' or diag8 ='K8301' or diag9 ='K8301' or diag10 ='K8301' or diag11 ='K8301' or diag12 ='K8301')
group by pat_id;
*/
/*
drop table if exists pharmetrics.ipf_diag;
create  table pharmetrics.ipf_diag as 
select distinct pat_id,min(from_dt) as min_from_dt from pharmetrics.ipf_claims where (diag_admit = '51631' or diag1 ='51631' or diag2 ='51631' or diag3 ='51631' or diag4 ='51631' or diag5 ='51631' or diag6 ='51631' or diag7 ='51631' or diag8 ='51631' or diag9 ='51631' or diag10 ='51631' or diag11 ='51631' or diag12 ='51631'
or diag_admit = 'J84112' or diag1 ='J84112' or diag2 ='J84112' or diag3 ='J84112' or diag4 ='J84112' or diag5 ='J84112' or diag6 ='J84112' or diag7 ='J84112' or diag8 ='J84112' or diag9 ='J84112' or diag10 ='J84112' or diag11 ='J84112' or diag12 ='J84112')  
group by pat_id;
*/