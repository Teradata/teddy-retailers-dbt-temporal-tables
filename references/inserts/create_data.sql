CREATE MULTISET TABLE teddy_retailers.source_products AS
(
  SELECT id, name, CAST(category AS CHAR(30)) as category, price_cents
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/raw_products.csv') as products
) WITH DATA;
CREATE MULTISET TABLE teddy_retailers.source_customers AS
(
  SELECT id, name, surname, email
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/raw_customers.csv') as customers
) WITH DATA;
CREATE MULTISET TABLE teddy_retailers.source_orders AS
(
  SELECT id , customer_id, CAST(status AS CHAR(20)) as status, order_date
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_orders_first.csv') as orders
) WITH DATA
ALTER TABLE teddy_retailers.source_orders
  ADD order_duration PERIOD(TIMESTAMP(6) WITH TIME ZONE) NOT NULL
  AS TRANSACTIONTIME;
CREATE SET TABLE teddy_retailers.source_order_products AS
(
  SELECT order_id, product_id, product_quantity
    FROM (
		LOCATION='/gs/storage.googleapis.com/clearscape_analytics_demo_data/DEMO_dbtAdvanced/primary_order_products_first.csv') as orders_products
) WITH DATA;
ALTER TABLE teddy_retailers.source_order_products
  ADD order_product_duration PERIOD(TIMESTAMP(6) WITH TIME ZONE) NOT NULL
  AS TRANSACTIONTIME;