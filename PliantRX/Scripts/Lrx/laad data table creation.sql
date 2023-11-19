select schemaname ||'.'||tablename||','  from pg_catalog.pg_tables where schemaname ='laad_data';
grant select on
laad_data.patient,
laad_data.provider,
laad_data.products,
laad_data.plan,
laad_data.procedure,
laad_data.procedure_modifier,
laad_data.rx_claim,
laad_data.diagnosis,
laad_data.patient_act,
laad_data.dx_p_provider,
laad_data.dx_claim to vdas,dhake;


drop table if exists laad_data.patient;
CREATE TABLE laad_data.patient (
  PATIENT_ID VARCHAR(18),
  PAT_BRTH_YR_NBR VARCHAR(4),
  PAT_GENDER_CD VARCHAR(1)
);
--491020
copy laad_data.patient from 's3://commdata/CommData/LRxData/Patient.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
region 'us-west-2';

drop table if exists laad_data.provider;
CREATE TABLE laad_data.provider (
  provider_id VARCHAR(20),
  provider_typ_id VARCHAR(20),
  org_nm VARCHAR(70),
  ims_rxer_id VARCHAR(7),
  last_nm VARCHAR(50),
  first_nm VARCHAR(50),
  addr_line1_txt VARCHAR(150),
  addr_line2_txt VARCHAR(150),
  city_nm VARCHAR(50),
  st_cd VARCHAR(2),
  zip VARCHAR(5),
  pri_spcl_cd VARCHAR(4),
  pri_spcl_desc VARCHAR(150),
  me_nbr VARCHAR(20),
  npi VARCHAR(10)
  );
--5001
copy laad_data.provider from 's3://commdata/CommData/LRxData/Provider.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
IGNOREHEADER 1
region 'us-west-2';

drop table if exists laad_data.products;
CREATE TABLE laad_data.products (
  PRODUCT_ID VARCHAR(20),
  NDC_CD CHAR(11),
  MKTED_PROD_NM VARCHAR(35),
  STRNT_DESC VARCHAR(60),
  DOSAGE_FORM_NM VARCHAR(80),
  CMF_PROD_NBR VARCHAR(7),
  CMF_PACK_NBR VARCHAR(3),
  USC_CD VARCHAR(5),
  USC_DESC VARCHAR(50)
);

--88564
truncate  table laad_data.products;
copy laad_data.products from 's3://commdata/CommData/LRxData/Product.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
ignoreheader 1
region 'us-west-2';

drop table if exists laad_data.plan;
CREATE TABLE laad_data.plan (
  PLAN_ID varchar(20),
  IMS_PLN_ID VARCHAR(4),
  IMS_PLN_NM VARCHAR(32),
  IMS_PAYER_ID VARCHAR(6),
  IMS_PAYER_NM VARCHAR(32),
  PLANTRAK_ID VARCHAR(10),
  MODEL_TYP_CD VARCHAR(15),
  MODEL_TYP_NM VARCHAR(100)
);

--14637
truncate table laad_data.plan;
copy laad_data.plan from 's3://commdata/CommData/LRxData/Plan.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
ignoreheader 1
region 'us-west-2';


drop table if exists laad_data.procedure;
CREATE TABLE laad_data.procedure (
PRC_CD  VARCHAR(10)PRIMARY key,
PRC_VERS_TYP_ID  varchar(10),
PRC_SHORT_DESC  VARCHAR(100),
PRC_TYP_CD  VARCHAR(1)
);

--32737
truncate table laad_data."procedure";
copy laad_data.procedure from 's3://commdata/CommData/LRxData/Procedure.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
IGNOREHEADER 1
region 'us-west-2';

CREATE TABLE laad_data.procedure_modifier(
PRC_MODR_CD  VARCHAR(2)PRIMARY key,
PRC_MODR_DESC  VARCHAR(2000)
);

--479
copy laad_data.procedure_modifier from 's3://commdata/CommData/LRxData/ProcedureModifier.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
region 'us-west-2';


drop table if exists laad_Data.diagnosis;
CREATE TABLE laad_data.diagnosis(
DIAG_CD VARCHAR(10)	,
DIAG_VERS_TYP_ID varchar(10),	
DIAG_SHORT_DESC	VARCHAR(100)
);

--54761
copy laad_data.diagnosis from 's3://commdata/CommData/LRxData/Diagnosis.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
region 'us-west-2';

drop table if exists laad_data.rx_claim;
CREATE TABLE laad_data.Rx_claim (
  MONTH_ID VARCHAR(20),
  SVC_DT varchar(10),
  PATIENT_ID VARCHAR(20),
  PAT_ZIP3 VARCHAR(3),
  CHNL_CD CHAR(1),
  CLAIM_ID VARCHAR(20) PRIMARY KEY,
  RX_TYP_CD VARCHAR(1),
  PROVIDER_ID VARCHAR(10),
  PLAN_ID varchar(10),
  PAY_TYP_DESC VARCHAR(50),
  PRODUCT_ID varchar(10),
  DSPNSD_QTY varchar(10),
  DAYS_SUPPLY_CNT varchar(10),
  PAT_PAY_AMT varchar(10)
);

--113471249
copy laad_data.rx_claim from 's3://commdata/CommData/LRxData/FactRx.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
region 'us-west-2';

drop table if exists laad_data.dx_claim;
CREATE TABLE laad_data.Dx_claim(
MONTH_ID  varchar(10),
SVC_DT  varchar(10),
PATIENT_ID  varchar(20),
PAT_ZIP3  VARCHAR(3),
CLAIM_ID  varchar(50) PRIMARY key,
SVC_NBR  varchar(20),
DIAG_CD_POSN_NBR  varchar(10),
CLAIM_TYP_CD  VARCHAR(1),
RENDERING_PROVIDER_ID  varchar(20),
REFERRING_PROVIDER_ID  varchar(20),
BILLING_PROVIDER_ID  varchar(20),
FACILITY_PROVIDER_ID  varchar(20),
PLACE_OF_SVC_NM  VARCHAR(100),
PLAN_ID  varchar(20),
PAY_TYP_DESC  VARCHAR(50),
DIAG_CD  VARCHAR(10),
DIAG_VERS_TYP_ID  varchar(20),
PRC_CD  VARCHAR(10),
PRC_VERS_TYP_ID  varchar(20),
PRC1_MODR_CD  VARCHAR(2),
PRC2_MODR_CD  VARCHAR(2),
PRC3_MODR_CD  VARCHAR(2),
PRC4_MODR_CD  VARCHAR(2),
NDC_CD  VARCHAR(11),
SVC_CRGD_AMT  varchar(20),
UNIT_OF_SVC_AMT  varchar(20)
);

--376158149
copy laad_data.dx_claim from 's3://commdata/CommData/LRxData/FactDx.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
region 'us-west-2';

select * from pg_catalog.stl_load_errors order by 4 desc;


drop table if exists laad_data.dx_p_provider;
CREATE TABLE laad_data.Dx_p_provider(
MONTH_ID  varchar(20),
PROVIDER_ID  varchar(20) PRIMARY key,
TIER_ID  varchar(20));

--501842
truncate table laad_data.dx_p_provider;
copy laad_data.dx_p_provider from 's3://commdata/CommData/LRxData/DxProfessionalProviderTier.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
ignoreheader 1
region 'us-west-2';


drop table if exists laad_Data.patient_act;
CREATE TABLE laad_data.patient_act(
MONTH_ID  VARCHAR(6),
PATIENT_ID   varchar(20),
DATA_TYP_CD  varchar(20));

--45689456
truncate table laad_data.patient_act;
copy laad_data.patient_act from 's3://commdata/CommData/LRxData/PatientActivity.dat.gz' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
delimiter '|'
TRUNCATECOLUMNS
ACCEPTINVCHARS
GZIP
ignoreheader 1
region 'us-west-2';