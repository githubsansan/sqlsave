with xh_portal_temp as 
(
select
    lg.mobile 
  , lg.app_id 
  , lg.tenant_id 
  , lg.store_id 
  , nvl(get_json_object(replace(replace(get_json_object(ext,'$.xbb-app-media'),CHR(59),''),'&quot','"'),'$.device_id'),'') as device_id
  , nvl(bu.id,0) as b_user_id
  , nvl(cu.id,0) as c_user_id
  , rank()over(partition by lg.mobile order by lg.created_at  ) as login_rn
from xh_portal_accounts_login_status lg

left join xh_portal_accounts bu 
on lg.mobile = bu.mobile and bu.product_id = 20001 and bu.test_flag = 0 and bu.deleted_flag = 0 

left join xh_portal_c_accounts cu
on lg.mobile = cu.mobile and cu.product_id = 20001 and cu.deleted_flag = 0 

where lg.deleted_flag = 0 and lg.status = 0 
)

,user_tmp as 
(
select  
	  b_user_id as user_id
	, device_id
from xh_portal_temp 
where login_rn = 1 and b_user_id <> 0
union 
select  
	  c_user_id as user_id
	, device_id
from xh_portal_temp 
where login_rn = 1  and c_user_id <> 0
)

, temp_result as (
select 
	a.number as device_id
	,a.affiliation_month_type  as init_date
	,b.user_id
	,c.p_date as next_login
from pub_xh_universal_base_config_filed_test a 
left join user_tmp b 
on a.number = b.device_id
inner join (select
			  distinct  
			   name 
			  ,user_id
			  ,p_date 
			from app_tlog_ce_xunhou_v3
			where name = 'I000000001' and cast(p_date as bigint) >= 20250331
			)  c
on a.affiliation_month_type = c.p_date - 1 and b.user_id = c.user_id
)

, temp_result_user1 as 
(
select 
  affiliation_month_type
 , count(1) as cnt 
from pub_xh_universal_base_config_filed_test
group by affiliation_month_type
)
, temp_result_user2 as 
(
select 
	init_date
	,count(1) as num
from  temp_result
group by init_date
)


select 
	affiliation_month_type
	,cnt
	, num 
from 	temp_result_user1 a 
left join temp_result_user2 b 
on a.affiliation_month_type = b.init_date


--docker 操作
#通过同一网络启动zookeeper客户端容器并连接zookeeper服务上
docker run --rm -it --network datahub_network zookeeper:3.8 zkCli.sh -server 172.18.0.4:2181

docker exec -it 33ed388a31d5 /bin/bash

# 获取 ZooKeeper 容器的 IP
ZOOKEEPER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' datahub-zookeeper-1)

# 在应用配置中替换为 IP
echo "zookeeper.connect=$ZOOKEEPER_IP:2181"

#停止
datahub docker quickstart --stop
#重置
datahub docker nuke
#指定compose文件启动
datahub docker quickstart --quickstart-compose-file <path to compose file>

