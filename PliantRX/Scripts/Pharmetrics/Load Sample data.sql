drop table if exists sample_data.part; 
copy sample_data.part from 's3://pliantdataload/LoadingDataSampleFiles/part-csv.tbl-000' 
iam_role 'arn:aws:iam::406431883826:role/Redshift-S3-linkage'
csv
null as '\000';