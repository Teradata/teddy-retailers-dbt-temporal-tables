CREATE SET TABLE teddy_retailers.source_products AS
(
  SELECT *
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/raw_products.csv') as products
) WITH DATA;
CREATE SET TABLE teddy_retailers.source_customers AS
(
  SELECT *
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/raw_customers.csv') as customers
) WITH DATA;
CREATE SET TABLE teddy_retailers.source_orders AS
(
  SELECT *
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_orders_first.csv') as orders
) WITH DATA;
CREATE SET TABLE teddy_retailers.source_order_products AS
(
  SELECT order_id, product_id, product_quantity
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_order_products_first.csv') as orders_products
) WITH DATA;