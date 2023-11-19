select * into #temp2 from 
(select A.pat_id,t.of_min_rx_dt as treatment_date,A.from_dt as diagnosis_date, ABS(date_diff('days',A.from_dt,t.of_min_rx_dt)) as day_gap,
A.diag_admit ,A.diag1 ,A.diag2,diag3,diag4,diag5,
diag6,diag7,diag8,diag9,diag10,diag11,diag12
from (select pat_id,from_dt ,diag_admit ,diag1 ,diag2,diag3,diag4,diag5,
diag6,diag7,diag8,diag9,diag10,diag11,diag12
from pharmetrics.ofev_table where pat_id in (select distinct pat_id from pharmetrics.test ) 
and (diag_admit <>'' or diag1<>'' or diag2<>'' or diag3<>'' or diag4<>'' or diag5<>'' or diag6<>''
or diag7<>'' or diag8<>'' or diag9<>'' or diag10<>'' or diag11<>'' or diag12<>'')
) A 
inner join pharmetrics.test t on A.pat_id=t.pat_id);

select distinct pat_id from pharmetrics.ofev_table ot where diag_admit ='' and diag1='' and diag2='' and diag3='' and diag4='' and diag5='' and diag6=''
and diag7='' and diag8='' and diag9='' and diag10='' and diag11='' and diag12=''
except
select distinct pat_id from pharmetrics.ofev_table ot where diag_admit <>'' or diag1<>'' or diag2<>'' or diag3<>'' or diag4<>'' or diag5<>'' or diag6<>''
or diag7<>'' or diag8<>'' or diag9<>'' or diag10<>'' or diag11<>'' or diag12<>''



select * from pharmetrics.test;

select * into #temp3 from (select a.* from(
(select * from #temp2) a
inner join
(select pat_id,min(day_gap) as min_day_gap from #temp2 group by 1) b on a.pat_id=b.pat_id and a.day_gap=b.min_day_gap)
)

select * from #temp3;

select * into #temp4 from (
select distinct  pat_id,treatment_date,diagnosis_date,diag_admit from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag1 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag2 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag3 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag4 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag5 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag6 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag7 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag8 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag9 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag10 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag11 from #temp3
union
select pat_id,treatment_date,diagnosis_date,diag12 from #temp3) where diag_admit <> ''

select distinct a.*,b.diagnosis_desc from(
(select * from #temp4) a
inner join
(select * from pharmetrics.dx_lookup dl)b on   b.dx_cd=a.diag_admit)

--select * from pharmetrics.ofev_table ot where pat_id='v94j21eo8a5qyxvf'