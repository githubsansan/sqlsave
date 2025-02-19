 SELECT 
      t1.tenant_id
    , t1.id as template_id
    , t1.template_name
    , t1.effective_status
    , t1.effective_date_start
   -- , case when t1.effective_date_end is null then cast(replace(substr(cast(current_date as varchar(10)),1,7),'-','') as bigint) end as effective_date_end
    , t1.version as template_version
    , t2.field_id
    , t3.number  as field_eng_name
    , t3.name    as field_cn_name
    , t3.field_type
    , t3.affiliation_month_type
    , t3.structure_type
    , t3.category
    , t3.expense_type
    , CURRENT_TIMESTAMP as creation_timestamp
from xh_universal.base_config_template t1
LEFT JOIN xh_universal.base_config_template_field t2
ON t1.tenant_id = t2.tenant_id AND t1.id = t2.template_id AND t2.deleted_flag = 0  
LEFT JOIN xh_universal.base_config_field t3
ON t2.field_id = t3.id  AND t2.tenant_id = t3.tenant_id AND t3.deleted_flag = 0  
WHERE 1 = 1 
AND t1.business_code = 'settle_actual_payment_report' 
AND t1.effective_status = 20 
AND t1.deleted_flag = 0 
AND t3.structure_type IN (10,20) 
and t3.name = '公积金个人基数'