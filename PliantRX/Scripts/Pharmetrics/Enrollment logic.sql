select pat_id, count(distinct month_id) from pharmetrics.enroll2 where (month_id between 201707 and 202206) 
and (pat_id in (select distinct pat_id from pharmetrics.claims WHERE (from_dt >='2017-07-01' and from_dt <='2022-06-30') 
and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) 
OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))))
and mstr_enroll_cd in('Y')group by pat_id 
order by count(distinct month_id) desc ;

select enrol_cnt, count(*) from (
select pat_id ,count(*) as enrol_cnt from pharmetrics.enroll2 where month_id between 201707 and 202206
and mstr_enroll_cd ='Y'
group by pat_id 
)
group by enrol_cnt
order by 2 desc limit 60;


select enrol,sum(pat_cnt) from (
select case when enrol_cnt = 60 then '5-YR'
	   		when enrol_cnt between 36 and 59 then '3-YR' end as enrol, count(distinct pat_id) as pat_cnt from (
select pat_id ,count(distinct MONTH_ID) as enrol_cnt from pharmetrics.enroll2 where month_id between 201707 and 202206
and mstr_enroll_cd ='R' and pat_id in (select pat_id from #PSC_diag_5yr)
group by pat_id 
)
group by enrol)
group by enrol;

select distinct mstr_enroll_cd  from pharmetrics.enroll2  limit 10


select enrol,sum(pat_cnt) from (
select case when enrol_cnt between 42 and 60 then '5-YR'
	   		else '3-YR' end as enrol, count(distinct pat_id) as pat_cnt from (
select pat_id ,count(distinct MONTH_ID) as enrol_cnt from pharmetrics.enroll2 where month_id between 201707 and 202206
and mstr_enroll_cd ='Y' and pat_id in (select pat_id from #ipf_diag_5yr)
group by pat_id 
)
group by enrol)
group by enrol;