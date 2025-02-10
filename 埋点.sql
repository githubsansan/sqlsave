select
  pk_id, 
  app_id, 
  product_id, 
  tenant_id, 
  open_id, 
  union_id, 
  user_id, 
  event_name, 
  status, 
  ab_test, 
  action, 
  channel_name, 
  custom_data, 
  device_info, 
  element, 
  error, 
  event_tag, 
  --get_object_json(event_tag,'$.content') as content,
  --get_object_json(event_tag,'$.button_content') as button_content,
  json_extract(event_tag,'$.content') as content,
  json_extract(event_tag,'$.button_content') as button_content,
  interval_time, 
  ip, 
  location, 
  path, 
  session_id, 
  create_tms, 
  event_dt, 
  creation_timestamp, 
  p_date 
from dw_xh_d_super_pv_statistic
where event_name in 
(
'evt_publish_notice_pop_exposure',
'evt_publish_notice_pop_button_click'
)
