--head:"job_id	full_probation	job_mode	tenant_id	company_name	store_name	job_name	job_status	job_status_cn	address	rate	created_at	updated_at	work_date	work_start_time	work_end_time	rest_start	rest_end	job_requirements	job_description	salry_cnt	real_salary_amount	service_fee_amount	pre_amount"
select
  t1.id as job_id,
  case when t1.job_type = 1 then  '全职试工' 
       when t1.job_type = 2 then  '兼职'   end as full_probation,
  case when t1.job_mode = 1 then '一人连报' 
       when t1.job_mode = 2 then '多人拼单' end as job_mode,
  t1.tenant_id,
  t2.company_name,
  t2.store_name,
  t1.job_name,
  t1.job_status,
  case when t1.job_status = 0 then '待发布'
       when t1.job_status = 1 then '招聘中'
       when t1.job_status = 2 then '平台失效'
       when t1.job_status = 3 then 'b端关闭'
       when t1.job_status = 4 then '结算中'
	   when t1.job_status = 5 then '工作中'
	   when t1.job_status = 6 then '已完成'
	   when t1.job_status = 7 then '没有招到人'
       when t1.job_status = 8 then '停止招聘'
       end as job_status_cn,
  t1.address,
  cast(get_json_object(t1.service_rate, '$.value') as decimal(10,3)) as rate,
  t1.created_at,
  t1.updated_at,
  t1.work_date,
  t1.work_start_time,
  t1.work_end_time,
  t1.rest_start,
  t1.rest_end,
  t1.job_requirements,
  t1.job_description,
  t3.salry_cnt,
  t3.real_salary_amount,
  t3.service_fee_amount,
  t4.amount as pre_amount
from
  jobs t1
left join tenant_super  t2
on t1.tenant_id = t2.tenant_id and t2.test_flag = 0 and t2.deleted_flag = 0 
left join 
(
select 
	job_id,
	count(distinct user_id) as salry_cnt,
	sum(cast(t3.real_salary_amount as decimal(22,6))) as real_salary_amount,
	sum(cast(t3.service_fee_amount as decimal(22,6)))  as service_fee_amount
from super_salary t3 
where 1 = 1  and t3.deleted_flag = 0 and t3.status = 3
group by job_id
) t3
on t1.id = t3.job_id 
left join xh_wallet_orders t4 
on t1.order_id = t4.id  and t4.category = 1 and t4.deleted_flag = 0  

where t1.test_flag = 0 and t1.deleted_flag = 0  
/*
and substr(t1.created_at,1,10) >= '2024-10-01'
and substr(t1.created_at,1,10) <= '2024-11-30'
*/
