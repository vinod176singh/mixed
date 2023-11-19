select pat_id, count(distinct month_id)  from pharmetrics.enroll2
where (month_id between 201707 and 202206) and (pat_id in (select distinct pat_id from pharmetrics.claims WHERE (from_dt >='2017-07-01' and from_dt <='2022-06-30') and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))))
and mstr_enroll_cd in('Y')
group by pat_id
order by count(distinct month_id) desc ;

select pat_id, count(distinct month_id)  from pharmetrics.enroll2
where (month_id between 201907 and 202206) and (pat_id in (select distinct pat_id from pharmetrics.claims WHERE (from_dt >='2019-07-01' and from_dt <='2022-06-30') and ('51631' IN (diag_admit, diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12) OR 'J84112' IN (diag_admit,diag1, diag2, diag3,diag4,diag5,diag6 ,diag7,diag8,diag9,diag10,diag11,diag12))))
group by pat_id
order by count(distinct month_id) desc;