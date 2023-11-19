select distinct d.patient_id,count(distinct p.mkted_prod_nm) as prod_cnt   from laad_data.rx_claim d
inner join laad_data.products p on d.product_id=p.product_id 
where  d.patient_id in(select distinct patient_id from laad_data.ofev_pat)
group by d.patient_id order by prod_cnt desc;
