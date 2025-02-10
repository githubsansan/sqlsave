--head:"index_name	collect_dt	index_value"
--截至2024-09-30平均工资
select
    '薪资' as index_name
  , '2024-09-30' as collect_dt
  , sum(cast(real_salary_amount as decimal(10,3)))/count(1) as index_value
from super_salary
where  deleted_flag = 0 and status = 3 and substr(created_at,1,10) <= '2024-09-30'