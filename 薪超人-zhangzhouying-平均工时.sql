--head:"index_name	collect_dt	index_value"
--截至2024-09-30的平均工时
select
    '平均工时' as index_name
  , '2024-09-30' as collect_dt
  , sum(cast(work_hour as decimal(10,3))) / 60 /count(1) as index_value
from super_salary
where  deleted_flag = 0 and status = 3 and substr(created_at,1,10) <= '2024-09-30'