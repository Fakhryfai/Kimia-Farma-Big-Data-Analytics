create table kimia_farma.rakamin_kf_analytics as
select 
	ft.transaction_id, 
	ft.date,
	ft.branch_id,
	kc.branch_name,
	kc.kota,kc.provinsi, 
	kc.rating as rating_cabang,
	ft.customer_name,
	ft.product_id,
	pr.product_name,
	pr.price as actual_price,
	ft.discount_percentage,
	Case
	 	when ft.price <= 50000 then 0.10
		when ft.price >50000 and ft.price <= 100000 then 0.15
	 	when ft.price >100000 and ft.price <= 300000 then 0.25
		when ft.price >300000 and ft.price <= 500000 then 0.25
	 	when ft.price >500000 then 0.30
	end as persentase_gross_laba,
	ft.price as nett_sales,
	ft.price*(
			case
	 			when ft.price <= 50000 then 0.10
	 			when ft.price > 50000 and ft.price <= 100000 then 0.15
	 			when ft.price >100000 and ft.price <= 300000 then 0.25
	 			when ft.price >300000 and ft.price <= 500000 then 0.25
	 			when ft.price >500000 then 0.30
	 end
	) as nett_profit,
	ft.rating as rating_transaksi
from 
 kimia_farma.kf_final_transaction as ft
join
 kimia_farma.kf_kantor_cabang as kc on ft.branch_id = kc.branch_id
join
 kimia_farma.kf_product as pr on ft.product_id = pr.product_id;