create schema laad_data authorization vsingh;

ALTER USER vsingh CREATEUSER
create table pharmetrics.test(id int)
insert into pharmetrics.test values (1),(2),(3)

select * from pharmetrics.test

create  user dhake password 'Navy@123@hake'


grant all on schema pharmetrics to vdas,dhake
grant all on table pharmetrics.test to vdas,dhake;

create group commdata_analytics with user vsingh, vdas,dhake;