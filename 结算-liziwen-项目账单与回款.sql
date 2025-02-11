--head:"customer_name	project_name	project_number	salary_month	bill_number	bill_name	bill_month	repayment_bill_settle_amount	bad_debt_amount	sub_account_id	cash_amount"
select
   xc.customer_name
 , xp.project_name
 , xp.project_number
 , bp.salary_month
 , bp.bill_id
 , sll.bill_number
 , sll.bill_name
 , sll.bill_month
 , max(cast(bp.repayment_bill_settle_amount as decimal(22,6))) as repayment_bill_settle_amount
 , max(cast(bp.bad_debt_amount as decimal(22,6))) as bad_debt_amount
 , bp.sub_account_id
 , sum(case when rc.tx_status = 1 then cast( rc.amount as decimal(22,6) ) else 0 end) as cash_amount
from xh_settle_repayment_group_detail bp     --应收

left join xhwallet_xbb_charge_sub_account ac --账户
on bp.sub_account_id = ac.id and ac.business_code = 'XBB_CUSTOMER_PAYMENT' and ac.deleted_flag = 0 and ac.tenant_id = 10000

left join xhwallet_account_book_records rc  --流水
on ac.id =  rc.account_id and rc.tx_status in (1,2) and rc.deleted_flag = 0 and rc.tenant_id = 10000

left join xhcrm_projects xp 
on bp.project_id = cast(xp.id as bigint) and xp.deleted_flag = 0 

left join settle_bills sll
on bp.bill_id = sll.id and sll.deleted_flag = 0 and sll.tenant_id = 10000 and sll.status = 50 and sll.business_code = 'settle_bill_list' 

left join xhcrm_customers  xc 
on sll.customer_id = xc.id and xc.deleted_flag = 0 

where 1 = 1 
and bp.deleted_flag = 0 
and bp.tenant_id = 10000
--and sll.bill_month = 202410
--and bp.bill_id = 90253 
--过滤掉负数账单内部操作逻辑
and not exists (select 1 from (--获取负数账单的转账的子账户ID
								select
									sub.scene
								  , sub.id  as sub_account_id
								from xhwallet_xbb_charge_sub_account sub
								inner join xhwallet_account_book_records neg
								on sub.id =  neg.tx_account_id and neg.tx_status in (1,2) and  neg.deleted_flag = 0  and neg.tenant_id = 10000
								where sub.business_code = 'XBB_CUSTOMER_PAYMENT' and sub.scene = 'NEGATIVE_BILL_PROJECTS'
							   ) cr 
				where rc.tx_account_id = cr.sub_account_id )
group by 
   xc.customer_name
 , xp.project_name
 , xp.project_number
 , bp.salary_month 
 , bp.bill_id
 , sll.bill_number
 , sll.bill_name
 , sll.bill_month
 , bp.sub_account_id