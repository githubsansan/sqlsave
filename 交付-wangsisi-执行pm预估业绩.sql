----2.执行PM服务费预估----	  
	select 
  	      det.business_type 
  	    , det.business_type_cn 
  	    , det.project_no 
  	    , det.project_name
  	    , det.customer_name
  	    , substr(det.cont_crt_tms ,1,10) as cont_crt_tms
  	    , det.exe_pm_id 
  	    , det.exe_pm_name 
  	    , det.job_title 
  	    , det.job_title_cn 
  	    , nvl(sept.job_title_family,'其他') as job_title_family
  	    , case when  al.agent_type_nm in ('校园') then  count(1)/ 5 else count(1) end  as onboard_cnt
  	    --title配置表
  	    , max(nvl(sept.stand_fee_cof,2000)) as stand_fee_cof --若匹配不到取默认值其他
  	    --sevice配置表
  	    , max(sev.fee_zs_cof) as fee_zs_cof
  	    , max(sev.budget_tms_cof) as budget_tms_cof
  	    , max(sev.settle_type) as settle_type
  	    , case when por.org_nm_3 like '%区%' then por.org_nm_4 else por.org_nm_3 end org_name3
  	    , al.channel_name
    from fact_xh_staff_mix_base det 
	
    --关联职能服务费系数,获取上个月末数据，P_date相差一个月，用上个月的职能族
    left join dw_xh_d_s_pub_jobtitle_cof sept
    on det.job_title = sept.job_title_cd
	and sept.p_date = 20241231
	
    left join pub_xh_sept_sevicetype_cof sev
    on det.business_type_cn = sev.sevice_type
     
	
	left join dw_xh_d_portal_accounts ac
	on det.exe_pm_id = ac.xh_acct_id and ac.tenant_id = 10000
	
	left join fact_xh_portal_base por
    on ac.src_id = por.employ_id  and  por.p_date = 20250131
  	
  	
    left join fact_xh_candidate_base al 
    on det.personal_number = al.personal_number and al.opr_status = '50'  and  al.p_date = 20250131
	
    where 1 = 1 
    and det.p_date = 20250131
    and REPLACE(substr(det.opr_on_date,1,7),'-','') = substr(20250131,1,6) --当月入职
    and det.business_type not in (5,6,10,20,21) --不包含转移外包、劳务派遣
    and det.exe_pm_name is not null --存在执行pm数据链路断了的情况。
	
    group by 
  	      det.business_type 
  	    , det.business_type_cn 
  	    , det.project_no 
  	    , det.project_name
  	    , det.customer_name
  	    , substr(det.cont_crt_tms ,1,10) 
  	    , det.exe_pm_id 
  	    , det.exe_pm_name 
  	    , det.job_title 
  	    , det.job_title_cn 
  	    , sept.job_title_family
  	    , case when por.org_nm_3 like '%区%' then por.org_nm_4 else por.org_nm_3 end
  	    , al.channel_name
  	    , al.agent_type_nm