create table laad_data.Region_state(State_code varchar(2),region varchar(50));
insert into laad_data.Region_State  values('AK','NORTHWEST');
insert into laad_data.Region_State  values('AL','SOUTH');
insert into laad_data.Region_State  values('AR','SOUTH CENTRAL');
insert into laad_data.Region_State  values('AZ','SOUTHWEST');
insert into laad_data.Region_State  values('CA','SOUTHWEST');
insert into laad_data.Region_State  values('CO','SOUTHWEST');
insert into laad_data.Region_State  values('CT','NORTHEAST');
insert into laad_data.Region_State  values('DC','MID ATLANTIC');
insert into laad_data.Region_State  values('DE','MID ATLANTIC');
insert into laad_data.Region_State  values('FL','SOUTH');
insert into laad_data.Region_State  values('GA','SOUTH');
insert into laad_data.Region_State  values('HI','SOUTHWEST');
insert into laad_data.Region_State  values('IA','MIDWEST');
insert into laad_data.Region_State  values('ID','NORTHWEST');
insert into laad_data.Region_State  values('IL','MIDWEST');
insert into laad_data.Region_State  values('IN','MIDWEST');
insert into laad_data.Region_State  values('KS','MIDWEST');
insert into laad_data.Region_State  values('KY','SOUTH');
insert into laad_data.Region_State  values('LA','SOUTH CENTRAL');
insert into laad_data.Region_State  values('MA','NORTHEAST');
insert into laad_data.Region_State  values('MD','MID ATLANTIC');
insert into laad_data.Region_State  values('ME','NORTHEAST');
insert into laad_data.Region_State  values('MI','MIDWEST');
insert into laad_data.Region_State  values('MN','MIDWEST');
insert into laad_data.Region_State  values('MO','MIDWEST');
insert into laad_data.Region_State  values('MS','SOUTH');
insert into laad_data.Region_State  values('MT','NORTHWEST');
insert into laad_data.Region_State  values('NC','SOUTH');
insert into laad_data.Region_State  values('ND','MIDWEST');
insert into laad_data.Region_State  values('NE','MIDWEST');
insert into laad_data.Region_State  values('NH','NORTHEAST');
insert into laad_data.Region_State  values('NJ','NORTHEAST');
insert into laad_data.Region_State  values('NM','SOUTHWEST');
insert into laad_data.Region_State  values('NV','SOUTHWEST');
insert into laad_data.Region_State  values('NY','MID ATLANTIC');
insert into laad_data.Region_State  values('OH','MIDWEST');
insert into laad_data.Region_State  values('OK','SOUTH CENTRAL');
insert into laad_data.Region_State  values('OR','NORTHWEST');
insert into laad_data.Region_State  values('PA','MID ATLANTIC');
insert into laad_data.Region_State  values('RI','NORTHEAST');
insert into laad_data.Region_State  values('SC','SOUTH');
insert into laad_data.Region_State  values('SD','MIDWEST');
insert into laad_data.Region_State  values('TN','SOUTH');
insert into laad_data.Region_State  values('TX','SOUTH CENTRAL');
insert into laad_data.Region_State  values('UT','SOUTHWEST');
insert into laad_data.Region_State  values('VA','SOUTH');
insert into laad_data.Region_State  values('VT','NORTHEAST');
insert into laad_data.Region_State  values('WA','NORTHWEST');
insert into laad_data.Region_State  values('WI','MIDWEST');
insert into laad_data.Region_State  values('WV','SOUTH');
insert into laad_data.Region_State  values('WY','NORTHWEST');

drop table if exists laad_data.zip_terr_mapping;
create table laad_data.zip_terr_mapping as
select distinct pat_zip3,st_cd,zip,c.region  from (select distinct pat_zip3 from laad_data.dx_claim
union select distinct pat_zip3 from laad_data.rx_claim) a
full join (select distinct st_cd,zip  from laad_data.provider) b on a.pat_zip3 =left(b.zip,3)
full join laad_data.Region_state c on b.st_cd=c.state_code;


select distinct pat_zip3 from laad_data.zip_terr_mapping where st_cd is null;

select * from laad_data.zip_terr_mapping;
