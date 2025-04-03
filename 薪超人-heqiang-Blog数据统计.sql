--C端注册与报名
select 
      p_date
	, count( distinct bl.mix_user_id ) as regist_cnt 
	, count( distinct sg.from_user_id) as sign_sum
from 
(
select
    json_extract_scalar(action_info,'$.userInfo.userId') as mix_user_id
  , substr(action_kind_name,1,8) as user_type
  , p_date 
from blog_hd bl 
where cast(p_date as bigint) in (20250401,20250402)
and action_kind_name in ('XUNHOU_C_USER_REGISTRATION_SUCCESS','XUNHOU_B_USER_REGISTRATION_SUCCESS')
) bl 
left join super_sign_up sg
on bl.mix_user_id = cast(sg.from_user_id as varchar(100))  and sg.status = 1 
where bl.user_type = 'XUNHOU_C'
group by p_date


--工作意向埋点统计
select
    count( distinct json_extract_scalar(action_info,'$.userInfo.userId') ) as intention_cnt
  , p_date 
from blog_hd bl 
where cast(p_date as bigint) in (20250401,20250402)
and action_kind_name in ('XUNHOU_C_WORKINTENTION_COLLECT_SUCCESS')
and  json_extract_scalar(action_info,'$.userInfo.userId') 
in 
(--注册用户
select
json_extract_scalar(action_info,'$.userInfo.userId') as mix_user_id
from blog_hd bl 
where cast(p_date as bigint) in (20250401,20250402)
and action_kind_name in ('XUNHOU_C_USER_REGISTRATION_SUCCESS')
)
group by p_date
