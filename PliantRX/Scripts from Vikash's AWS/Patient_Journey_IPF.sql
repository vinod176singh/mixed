create table #temp as
select * from pharmetrics.claims where pat_id in (SELECT DISTINCT ac.pat_id AS patient_id
FROM pharmetrics.ipf_diag id
LEFT JOIN (
SELECT DISTINCT pat_id, MIN(from_dt) AS from_dt
FROM pharmetrics.ipf_claims
WHERE ndc IN (
SELECT DISTINCT ndc
FROM pharmetrics.ndc_codes
WHERE mkted_prod_nm IN ('OFEV', 'ESBRIET', 'PIRFENIDONE'))
GROUP BY pat_id
) ac ON ac.pat_id = id.pat_id
WHERE EXTRACT(YEAR FROM id.min_from_dt) = 2015
GROUP BY ac.pat_id
HAVING COUNT(DISTINCT CASE WHEN datediff(day, id.min_from_dt, ac.from_dt) >= 0 THEN ac.pat_id END));
