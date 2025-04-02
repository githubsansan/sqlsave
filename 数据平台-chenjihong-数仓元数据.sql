--head:"tablename	tablename	columnname	comment	datatype	source	businessline	status	createtime	manager	managername	"
select
  t.tablename, 
  t.cnname,
  c.columnname,
  c.comment,
  c.datatype,
  t.source,
  t.businessline, 
  t.status, 
  t.createtime, 
  t.manager, 
  t.managername 
from busi_dwi_tables t
left join busi_dwi_tables_columns c 
on t.tablename = c.tablename
where t.businessline like '%勋厚%'