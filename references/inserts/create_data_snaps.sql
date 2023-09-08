CREATE MULTISET TABLE teddy_retailers.source_orders_nt AS
(
  SELECT id , customer_id, CAST(status AS CHAR(20)) as status, order_date
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_orders_first.csv') as orders
) WITH DATA;
CREATE MULTISET TABLE teddy_retailers.source_order_products_nt AS
(
  SELECT order_id, product_id, product_quantity
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_order_products_first.csv') as orders_products
) WITH DATA;
