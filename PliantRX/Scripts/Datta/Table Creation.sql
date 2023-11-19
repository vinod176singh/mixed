
CREATE TABLE pharmetrics.enroll (
  der_sex CHAR(1),
  der_yob NUMERIC(4),
  pat_id CHAR(16),
  pat_region CHAR(2),
  pat_state CHAR(2),
  grp_indv_cd CHAR(1),
  mh_cd CHAR(1),
  enr_rel CHAR(2)
);

CREATE TABLE pharmetrics.enroll2 (
  pat_id CHAR(16),
  mstr_enroll_cd CHAR(1),
  prd_type CHAR(1),
  pay_type CHAR(1),
  pcob_type CHAR(1),
  mcob_type CHAR(1),
  month_id INTEGER
);

create table  pharmetrics.pos_lookup(
place_of_svc_cd char(6),
place_of_svc_nm char(225),
place_of_svc_desc char(1024)
);

CREATE table pharmetrics.pr_lookup(
procedure_cd char(21),
procedure char(24),
procedure_desc char(2000),
procedure_type_cd char(3),
prc_vers_typ_id Numeric(8)
);

create table pharmetrics.rev_lookup(
rev_cd char(12),
rev_typ_desc char(300),
rev_catg_desc char(825),
rev_subcatg_desc char(825),
rev_short_desc char(300)
);

create table pharmetrics.rx_lookup(
ndc char(11),
product_name char(105),
generic_name char(180),
gpi14 char(42),
gpi_desc char(180),
gpi2 char(6),
gpi2_desc char(180),
thptc_clas_id numeric(8),
thptc_clas_desc char(180),
dosage_form_nm char(240),
route char(150),
strength char(180),
usc_cd char(15),
usc_name char(120)
);