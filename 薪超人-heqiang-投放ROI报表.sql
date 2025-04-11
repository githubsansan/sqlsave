select
    re.p_date
  , json_extract_scalar(re.action_info,'$.xbbChannelName') as xbb_channel_name
  , json_extract_scalar(re.action_info,'$.accountId') as account_id
  , json_extract_scalar(re.action_info,'$.deviceId') as device_id
  , json_extract_scalar(ure.action_info,'$.media.device_id') as device_id_1
  , json_extract_scalar(bre.action_info,'$.userInfo.userId') as user_id_all
  , json_extract_scalar(bre2.action_info,'$.userInfo.userId') as user_id_add
  , json_extract_scalar(bjr.action_info,'$.userInfo.userId') as user_id_j
  , json_extract_scalar(bjr.action_info,'$.eventTag.job_id') as job_id
  , json_extract_scalar(bsr.action_info,'$.eventTag.salary_id') as salary_id
from blog_hd re

left join blog_hd ure
on json_extract_scalar(re.action_info,'$.deviceId') = json_extract_scalar(ure.action_info,'$.media.device_id')
and ure.action_kind_name = 'XUNHOU_USER_REGISTRATION_SUCCESS' and cast(re.p_date as bigint) >= 20250410

left join blog_hd bre
on json_extract_scalar(re.action_info,'$.deviceId') = json_extract_scalar(bre.action_info,'$.media.device_id')
and bre.action_kind_name = 'XUNHOU_B_USER_REGISTRATION_SUCCESS' and cast(re.p_date as bigint) >= 20250410

left join blog_hd bre2
on json_extract_scalar(re.action_info,'$.deviceId') = json_extract_scalar(bre2.action_info,'$.media.device_id')
and bre.action_kind_name = 'XUNHOU_B_USER_REGISTRATION_SUCCESS' and bre2.p_date = '20250410'

left join blog_hd bjr
on json_extract_scalar(bre.action_info,'$.userInfo.userId') = json_extract_scalar(bjr.action_info,'$.userInfo.userId')
and bre.action_kind_name = 'XUNHOU_B_JOB_POST_SUCCESS' and bjr.p_date = '20250410'

left join blog_hd bsr
on json_extract_scalar(bre.action_info,'$.userInfo.userId') = json_extract_scalar(bsr.action_info,'$.userInfo.userId')
and bre.action_kind_name = 'XUNHOU_B_SALARY_SUCCESS' and bsr.p_date = '20250410'


where 1 = 1 
and re.action_kind_name = 'XUNHOU_USER_REYUN_SUCCESS' and json_extract_scalar(re.action_info,'$.xbbChannelName') = '巨量引擎'
and cast(re.p_date as bigint) >= 20250410




-------单表
--head:"action_datetime	action_kind_name	action_info	xbb_channel_name	account_id	device_id	p_date"
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.xbbChannelName') as xbb_channel_name
  , json_extract_scalar(action_info,'$.accountId') as account_id
  , json_extract_scalar(action_info,'$.deviceId') as device_id
  , p_date 
from blog_hd
where 1 = 1 
and action_kind_name = 'XUNHOU_USER_REYUN_SUCCESS' and json_extract_scalar(action_info,'$.xbbChannelName') = '巨量引擎'

--XUNHOU_USER_REGISTRATION_SUCCESS
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.media.device_id') as device_id
  , p_date 
from blog_hd
where 1 = 1 
and action_kind_name = 'XUNHOU_USER_REGISTRATION_SUCCESS'

--XUNHOU_C_USER_REGISTRATION_SUCCESS
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.media.device_id') as device_id
  , json_extract_scalar(action_info,'$.userInfo.userId') as c_user_id
  , p_date 
from blog_hd
where p_date = '20250411'
and action_kind_name = 'XUNHOU_C_USER_REGISTRATION_SUCCESS'

--XUNHOU_B_USER_REGISTRATION_SUCCESS
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.media.device_id') as device_id
  , json_extract_scalar(action_info,'$.userInfo.userId') as user_id
  , p_date 
from blog_hd
where p_date = '20250411'
and action_kind_name = 'XUNHOU_B_USER_REGISTRATION_SUCCESS'

--XUNHOU_B_JOB_POST_SUCCESS
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.userInfo.userId') as user_id
  , json_extract_scalar(action_info,'$.eventTag.tenant_id') as tenant_id
  , json_extract_scalar(action_info,'$.eventTag.job_id') as job_id
  , p_date 
from blog_hd
where p_date = '20250411'
and action_kind_name = 'XUNHOU_B_JOB_POST_SUCCESS'

--XUNHOU_B_SALARY_SUCCESS
select
    action_datetime
  , action_kind_name 
  , action_info
  , json_extract_scalar(action_info,'$.userInfo.userId') as user_id
  , json_extract_scalar(action_info,'$.eventTag.tenant_id') as tenant_id
  , json_extract_scalar(action_info,'$.eventTag.store_id') as store_id
  , json_extract_scalar(action_info,'$.eventTag.job_id') as job_id
  , json_extract_scalar(action_info,'$.eventTag.salary_id') as salary_id
  , p_date 
from blog_hd
where p_date = '20250411'
and action_kind_name = 'XUNHOU_B_SALARY_SUCCESS'