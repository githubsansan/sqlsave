select
  st.contract_id,
  fact.cst_contract_id, 
  fact.cst_contract_name, 
  fact.business_type, 
  fact.business_type_cn, 
  fact.cont_sign_tms, 
  fact.cont_crt_tms, 
  fact.sign_sale_id, 
  fact.sign_sale_name, 
  fact.sign_sale_depart, 
  fact.customer_name, 
  fact.industry_lvl1, 
  fact.industry_lvl2, 
  fact.brand_name, 
  fact.project_id, 
  fact.project_no, 
  fact.project_name, 
  fact.exe_pm_id, 
  fact.exe_pm_name, 
  fact.exe_pm_depart, 
  fact.svc_pm_id, 
  fact.svc_pm_name, 
  fact.svc_pm_depart, 
  fact.job_title_lvl1, 
  fact.job_title_lvl2, 
  fact.staff_name, 
  fact.personal_number, 
  fact.opr_on_date, 
  fact.act_on_date, 
  fact.opr_quit_date, 
  fact.act_quit_date, 
  fact.data_src, 
  fact.creation_timestamp, 
  fact.job_title, 
  fact.job_title_cn, 
  fact.p_date,
  substr(ss.updated_at,1,10) as sta_contract_date,
  cn.effective_at as contract_start_time,
  cn.invalid_at  as contract_end_time 
from fact_xh_staff_mix_base fact 
left join xh_hrm_staff st 
on fact.personal_number = st.personal_number and st.deleted_flag = 0 

--员工合同
left join hrm_staff_contracts cn
on st.contract_id = cn.id and cn.contract_type = 'CONTRACT' and cn.deleted_flag = 0 

--合同节点时间
left join xh_universal_contract_sign_nodes ss
on st.contract_id = ss.contract_id
and ss.signer_type = 'PERSON'
and ss.sign_status = 'COMPLETED' 
and ss.deleted_flag = 0 

where fact.p_date = 20250131
and (opr_on_date like '2025-01%' or opr_quit_date like '2025-01%')	
and fact.personal_number = 'XE2025012430258'	