--head:"reyun_dt	user_type	xbb_channel_name	account_id	device_id	re_date	ure_user_id	ure_date	creation_timestamp	tenant_id	company	store_name"
select
  a.reyun_dt, 
  a.user_type, 
  a.xbb_channel_name, 
  a.account_id, 
  a.device_id, 
  a.re_date, 
  a.ure_user_id, 
  a.ure_date, 
  a.creation_timestamp,
  b.tenant_id,
  c.company,
  d.store_name,
  e.job_name
from dw_xh_d_super_user_regist_dtl a 
left join xh_portal_accounts b 
on a.ure_user_id = cast(b.id  as bigint)
left join xh_portal_tenant c 
on b.tenant_id = c.id 
left join tenant_super_stores d 
on c.id = d.tenant_id 
left join jobs e 
on c.id = e.tenant_id
where a.device_id in 
( '55febd5147161b6b'
, '0c82e765a16b7fd6'
, '57b3fae29855bd20'
, '33092cea1d79c775'
, '3d8cd735183c5bf0'
, 'fbb4f6ca7231ab85'
, '5302d9656ac32cf6'
, '298a5c39e02f475c'
, '1f6fc092ae005d90'
, '4ca946d4a1ca27a4'
, '02ab531f9be09470'
, '40c67f076d517de0'
, '904fb0175e7251dd'
, 'e2447726cea6b28c'
, '37927cb871ca7464'
, '94a525de70576d0b'
, '92da5af7102ead00'
, 'b36aee796e061d41'
, 'ef6970957dca3fea'
, 'd4201cd472be3da1'
, 'd0d1bb74c2cb9f9b'
, '0c599da0d42f9655'
, '01ac52ec8f507ee1'
, '05e274d216182745'
, 'e372929f6b63cf55'
, '57d88a054ea0b7b5'
, '28bcceda2d4096ed'
, 'e7fdd540e1c321a7'
, '81a4bc6388599d95')