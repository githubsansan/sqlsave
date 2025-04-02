--引流人数，388
select count(distinct union_id) from xh_portal_program_authorization_records 
where channel_extend IS NOT NULL

--浏览小程序去重,266
select
	count(distinct union_id ) as cnt 
from dw_xh_d_super_pv_statistic a
where 1 = 1
and a.event_name = 'page_C_job_table_count'
and exists (select 1 from xh_portal_program_authorization_records b where a.union_id = b.union_id and b.channel_extend IS NOT NULL)

--注册用户数,125
select count(distinct a.union_id) from xh_portal_program_authorization_records  a
where 1 = 1
and a.channel_extend IS NOT NULL
and exists(select 1 from xh_portal_c_account_third_parties b where a.union_id = b.union_id)

--进入职位详情的人数，125
select
	count(distinct union_id ) as cnt 
from dw_xh_d_super_pv_statistic a
where 1 = 1
and a.event_name = 'page_jobview_detail'
and exists (select 1 from xh_portal_program_authorization_records b where a.union_id = b.union_id and b.channel_extend IS NOT NULL)

--进入职位详情的人数，45
select
	count(distinct user_id ) as cnt 
from dw_xh_d_super_pv_statistic a
where 1 = 1
and a.event_name = 'page_jobview_detail'
and exists (select 1 from xh_portal_program_authorization_records b where a.union_id = b.union_id and b.channel_extend IS NOT NULL)

--浏览职位去重
--有多次进入小程序的用户C端 两次浏览及以上浏览，间隔10分钟，去重

--有报名动作的去重

--trino sql
EXTRACT(HOUR FROM cast(create_tms as timestamp)) AS create_hour,

--spark sql
hour(cast(create_tms as timestamp)) as create_hour,

--*****************************************************
--按小时统计访问首页的C用户
select
  '访问首页' as event_name,
  event_dt,
  EXTRACT(HOUR FROM cast(create_tms as timestamp)) AS create_hour,
  count(distinct union_id) as cnt 
from
  dw_xh_d_super_pv_statistic a
where 1 = 1
and a.event_name = 'page_C_job_table_count'
and exists (select 1 from xh_portal_program_authorization_records b where a.union_id = b.union_id and b.channel_extend IS NOT NULL)
and p_date >= 20250204
group by event_dt,
  EXTRACT(HOUR FROM cast(create_tms as timestamp))

--按小时统计访问职位详情
select
  '访问职位详情' as event_name,
  event_dt,
  EXTRACT(HOUR FROM cast(create_tms as timestamp)) AS create_hour,
  count(distinct user_id) as cnt 
from
  dw_xh_d_super_pv_statistic a
where 1 = 1
and a.event_name = 'page_jobview_detail'
and exists (select 1 from xh_portal_program_authorization_records b where a.union_id = b.union_id and b.channel_extend IS NOT NULL)
and p_date >= 20250204
group by event_dt,
  EXTRACT(HOUR FROM cast(create_tms as timestamp))

--*****************************************************