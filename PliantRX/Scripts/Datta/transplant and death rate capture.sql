----876--1353
SELECT COUNT(DISTINCT pat_id)
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND pat_id in (select distinct pat_id from pharmetrics.claims c where ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       ));
          
      
      SELECT extract (year from from_dt)as years, COUNT(DISTINCT pat_id)
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       ) group by 1;

     
      
      -----272
SELECT COUNT(DISTINCT pat_id)
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0FY00Z1','5051','5059','505','0FY00Z0')
   or icdprc1 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc2 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc3 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc4 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc5 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc6 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc7 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc8 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc9 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc10 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc11 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc12 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   )
  AND ('5761' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'K8301' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12));
     
      
SELECT extract (year from from_dt)as years,COUNT(DISTINCT pat_id)
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0FY00Z1','5051','5059','505','0FY00Z0')
   or icdprc1 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc2 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc3 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc4 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc5 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc6 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc7 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc8 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc9 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc10 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc11 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   OR icdprc12 IN ('0FY00Z1','5051','5059','505','0FY00Z0')
   )
  AND ('5761' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'K8301' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)) group by 1;
     
     ------------------------------------------------------------------------------
     
SELECT *
FROM pharmetrics.claims
WHERE 
  (proc_cde in('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   Or  icdprc1 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc2 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc3 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc4 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc5 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc6 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc7 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc8 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc9 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc10 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc11 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   OR icdprc12 IN ('0BYK0Z0', '335', '32851', '0BYL0Z0', '0BYM0Z0', '0BYM0Z1','3352','32853','3351','0BYL0Z1','3350','32854','32852')
   )
  AND ('51631' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       OR 'J84112' IN (diag_admit, diag1, diag2, diag3, diag4, diag5, diag6, diag7, diag8, diag9, diag10, diag11, diag12)
       );
 	

