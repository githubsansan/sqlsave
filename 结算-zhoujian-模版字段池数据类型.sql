SELECT 
      t1.tenant_id
    , t1.id as template_id
    , t1.template_name
    , t1.effective_status
    , t1.effective_date_start
    , t1.version as template_version
    , t2.field_id
    , t3.number  as field_eng_name
    , t3.name    as field_cn_name
    , t3.field_type
    , t3.affiliation_month_type
    , t3.structure_type
    , t3.category
    , t3.expense_type
    , case when data_type = 1 then '文本' 
           when data_type = 2  and decimal_places = 0  then '整数'  
           when data_type = 2  and decimal_places <> 0 then '小数'  
           
           when data_type = 3 then '日期'
           else '未知'
           end as column_type
	, case when data_type = 1 then 'string' 
           when data_type = 2  and decimal_places = 0  then 'int'  
           when data_type = 2  and decimal_places <> 0 then 'decimal'  
           
           when data_type = 3 then 'date'
           else 'string'
           end as column_struct
           
from xh_universal_base_config_template t1
LEFT JOIN xh_universal_base_config_template_field t2
ON t1.tenant_id = t2.tenant_id AND cast( t1.id as bigint) = t2.template_id AND t2.deleted_flag = 0  
LEFT JOIN xh_universal_base_config_field t3
ON t2.field_id = cast(t3.id as bigint) AND t2.tenant_id = t3.tenant_id AND t3.deleted_flag = 0  
WHERE 1 = 1 
AND t1.business_code = 'settle_actual_payment_report' --实付报表
AND t1.effective_status = 20  --生效中模版
AND t1.deleted_flag = 0 
AND t3.structure_type IN (10,20) --基础字段和结构字段
AND t1.tenant_id = 10000 and (t3.expense_type = 0 or t3.expense_type = 10) --费用类型，（0:系统字段,10:实发,20:个税,30:社保,40:商保,50:其他费用）