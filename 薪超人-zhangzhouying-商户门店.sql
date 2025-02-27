--head:"store_id	store_name	contact_person_name	address"
select
    id as store_id
  , store_name
  , contact_person_name
  , address
from tenant_super_stores
where deleted_flag = 0 
and id in (    
  20909
, 20355
, 20355
, 20355
, 19217
, 19217
, 18043
, 17861
, 20935
, 20935
, 20945
, 20945
, 20945
, 17861

, 17861
, 20935
, 20935
, 19217
, 19217
, 20931
, 18599
, 18599
, 17995
, 17995
, 17999
, 18153
, 18575)