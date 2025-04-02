--head:"store_id	store_name	contact_person_name	address"
select
    id as store_id
  , store_name
  , contact_person_name
  , address
from tenant_super_stores
where deleted_flag = 0 
and id in (    
  17819
, 19055
, 20355
, 16813
, 20935
, 19185
, 20399
, 19217
, 19077
, 18767
, 20911
, 20857
, 18599
)