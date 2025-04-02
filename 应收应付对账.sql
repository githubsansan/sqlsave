--head:"paytype	unique_id	tenant_id	base_config_template_id	bill_id	bill_name	bill_number	bill_type	personal_name	personal_number	id_card_number	project_id	secondary_business_type	customer_id	end_bill_month	bill_month	affiliation_month	oc_receivable_amount	ci_receivable_amount	si_receivable_amount	tax_receivable_amount	ap_receivable_amount	creation_timestamp	contract_subject_id	p_date"
select
  '应收' as paytype,
  unique_id,
  tenant_id,
  base_config_template_id,
  bill_id,
  bill_name,
  bill_number,
  bill_type,
  personal_name,
  personal_number,
  id_card_number,
  project_id,
  secondary_business_type,
  customer_id,
  end_bill_month,
  bill_month,
  affiliation_month,
  oc_receivable_amount,
  ci_receivable_amount,
  si_receivable_amount,
  tax_receivable_amount,
  ap_receivable_amount,
  creation_timestamp,
  cast(contract_subject_id as bigint) as contract_subject_id ,
  p_date
from
  fact_xh_settle_bill_person_rcv_cal
where p_date = 20250204 and personal_number = 'XE2024122730750'  and affiliation_month = 202412
  union all 

select
  '应付' as paytype,
  unique_id,
  tenant_id,
  base_config_template_id,
  bill_id,
  bill_name,
  bill_number,
  bill_type,
  personal_name,
  personal_number,
  id_card_number,
  project_id,
  secondary_business_type,
  customer_id,
  end_bill_month,
  bill_month,
  affiliation_month,
  oc_payable_amount,
  ci_payable_amount,
  si_payable_amount,
  tax_payable_amount,
  ap_payable_amount,
  creation_timestamp,
  contract_subject_id,
  p_date
from
  fact_xh_settle_bill_person_pay_cal
where p_date = 20250204 and personal_number = 'XE2024122730750'  and affiliation_month = 202412 