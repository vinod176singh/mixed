use sql_training_december_2021;
--create schema vinod;

drop table if exists VINOD.Employee;

Create table VINOD.Employee(
  Emp_Id int identity(1,1),
  Emp_Name varchar(50),
  salary money,
  zip varchar(6),
  State Varchar(30),
  Mobile Varchar(10),
  Email Varchar(50)
);

insert into VINOD.Employee values
('Ajay',50000,'400057','MAHARASHTRA','9949789567','ajay.mujella@pharmaace.com'),
('Yogesh' ,40000, '400057' , 'MAHARASHTRA' , '8827647040' , 'yogesh.tiwari@pharmaace.com'),
('Shivam',62457,'411057','MAHARASHTRA','7018322428','shivam.sinha@pharmaace.com'),
('Santosh',60000,'40057','Madhya Pradesh','9712945175','santosh.parmar@pharmaace.com'),
('Srinidhi',45000,'507123','telangana','9441793811','srinidhi.pachipala@pharmaace.com'),
('Lakshya', 80000, '244001', 'Kerala', '8979439160', 'Lakshya.Agarwal@pharmaace.com'),
('Rohit',90000,'242424','TAMIL NADU','7639042555','Rohit.sivakumar@pharmaace.com'),
('Vijay',30000,'600078','TAMIL NADU','9884196518','Vijay.Mohan@pharmaace.com'),
('Raamesh', 55000, '400057', 'MAHARASHTRA', '9876543210', 'xyz.xyz@PharmaACE.com'),
('Aswin',35000,'615307','TAMIL NADU','9677470437','aswin.chandrasekaran@pharmaace.com'),
('Akash',100000,'444604','MAHARASHTRA',9359784177,'Akash.Dighade.pharmaace.com'),
('Dhananjay',48000,'440017','MAHARASHTRA','9172163570','dn851822@gmail.com'),
('Shivani',66000,'829112','Jharkhand','9470570124','shivansi.kishor@pharmaace.com'),
(' Giridhar Naidu',43000,'518005','Andhra Pradesh','9398091097','mutagiridharnaidu@gmail.com'),
('pradeep',78000,'502032','Telangana','9948579208','Pradeep.Perikala@PharmaACE.com'),
('Satheeshkumar',47000,'626112','TAMIL NADU','7598056343','Satheeshkumar.Malkaj@pharmaace.com'),
('Vishnu',51000,'530009','Andhra Pradesh','9381432204','vishnuvenkat.393@gmail.com'),
('sainath',73000,'585403','karnataka','8884979828','sainath.gadgeppa@pharmaAce.com'),
('Tharun',59000,'517502','ANDHRA PRADESH','8919236812','Tharunkumar.Galla@PharmaACE.com'),
('dias',41000,'680511','Kerala','7558079895','dias.xavy@pharmaace.com'),
('Karan',53300,'700023','WEST BENGAL','9073111274','ksksingh@gmail.com'),
('Divyanshu',61200,'229001','UTTAR PRADESH','9382719434','Divyanshu.bajpai@PharmaAce.com'),
('Dhanush', 64300, 603501, 'TAMIL NADU', 6383632357, 'Dhanush.Kumaran@PharmaACE.com'),
('Saurav',67890,'493558','CHHATTISGARH','7389011591','Saurav.Shukla@PharmaACE.com'),
('Mithilesh', 52300, '274406', 'UTTAR PRADESH', 8400222042,'mithilesh@gmail.com');


select * From VINOD.Employee;


---union
select * from vinod.Employee where State='Maharashtra'
union 
select * from vinod.Employee where State='Kerala' order by State;
--union all
select * from vinod.Employee where State='Maharashtra'
union all
select * from vinod.Employee where State='Kerala';
--except/minus
select Emp_Name  from vinod.Employee where State='Maharashtra'
except
select Emp_Name from vinod.Employee where State='Kerala';
--intersect
select State  from vinod.Employee where State='Maharashtra'
intersect
select State from vinod.Employee where State='Kerala';
--group by
select state,sum(salary) from employee group by state
--having
select state,sum(salary) from employee group by state
having sum(salary)>150000
--distinct
select distinct state From vinod.employee;
--subquery
select * from VINOD.Employee where Emp_Id in (select Emp_Id from VINOD.Employee where State='Maharashtra')
--grouping
select State,SUM(salary),GROUPING(State) From VINOD.Employee group by State with rollup;
--view
create view  vw_emp as 
select * From VINOD.Employee where state='Maharashtra';

select * From vw_emp


select abs('-100')
select degrees(90)
select degrees(pi()/2)
select radians(pi()/2)
select sin(pi()/2)
select log(2.73)
select log(2,2)
select log(12,10)
select sin(90*pi()/180)
select cos(pi()/2)
select acos(1)
select sign(-65)
select ATN2(34,34)


select PATINDEX('%i%','varanasi')
select CHARINDEX('si','varanasi')

select UNICODE('varanasi')
select ascii('v')

select str(4.56543,2)

select GETDATE()
select dateadd(day,5,'2022-07-07')
select dateadd(month,5,'2022-07-07')
select datediff(month,'2022-07-07', dateadd(month,5,'2022-07-07'))
select datepart(day,'2022-07-07')
select datepart(month,'2022-08-07')
select datepart(year,'2022-08-07')
select day('2022-08-07')
select month('2022-08-07')
select year('2022-08-07')


select convert(date,GETDATE(),107)
select cast('3.4554' as float)

select CONCAT('price is ','20');

SELECT FORMAT (getdate(), 'd') as date
SELECT FORMAT (getdate(), 'MM/dd/yyyy ') as date
SELECT FORMAT (getdate(), 'dd MMM yyyy') as date
SELECT FORMAT (getdate(), 'dd, MMMM, yyyy (dddd)') as date
SELECT FORMAT (getdate(), 'yyyy-MM-dd hh:mm:ss tt') as date

select * From VINOD.Employee

alter table VINOD.Employee 
add  Did int foreign key(Did) references vinod.Department(Did)

create table vinod.Department(Did int primary key,Dname Varchar(50));

insert into VINOD.Department values(1,'CSE');
insert into VINOD.Department values(2,'IT');
insert into VINOD.Department values(3,'ETC');
insert into VINOD.Department values(4,'ME');



update vinod.Employee
set Did=1
where emp_id in (1,5,10,15,20,25)

update vinod.Employee
set Did=2
where emp_id in (2,6,11,16,22,24)

update vinod.Employee
set Did=3
where emp_id in (3,7,12,17,21,23)

select Emp_name from vinod.Employee e
inner join VINOD.Department d on e.did=d.Did

select Emp_name,d.Did from vinod.Employee e
left join VINOD.Department d on e.did=d.Did

select distinct d.Did,Dname from vinod.Employee e
right join VINOD.Department d on e.did=d.Did
where e.did is null



select str(123)+space(2)+'pune'+space(2)+'maharashtra'+space(2)+'india'
select CONCAT( str(123),space(2),'pune',space(2),'maharashtra',space(2),'india') 
select cast(Emp_Id as varchar(10))+space(20)+Emp_Name from vinod.Employee


