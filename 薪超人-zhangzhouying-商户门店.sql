--head:"tenant_id	company_name	store_id	store_name	address"
select
    tenant_id
  , company_name
  , id as store_id
  , store_name
  , address
from tenant_super
where deleted_flag = 0 