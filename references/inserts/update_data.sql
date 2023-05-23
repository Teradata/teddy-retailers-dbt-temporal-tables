DROP TABLE teddy_retailers.source_orders;
CREATE SET TABLE teddy_retailers.source_orders AS
(
  SELECT id , customer_id, CAST(status AS CHAR(20)) as status, order_date
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_orders_second.csv') as orders
) WITH DATA;
DROP TABLE teddy_retailers.source_order_products;
CREATE SET TABLE teddy_retailers.source_order_products AS
(
  SELECT  order_id, product_id, product_quantity
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_order_products_second.csv') as orders_products
) WITH DATA;