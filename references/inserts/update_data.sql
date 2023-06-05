INSERT INTO teddy_retailers.source_orders 
  (id, customer_id, status, order_date)
  VALUES 
    (855, 98, 'delivered', '2023-01-30');
INSERT INTO teddy_retailers.source_orders 
  (id, customer_id, status, order_date)
  VALUES
    (856, 583, 'delivered', '2023-01-30');
INSERT INTO teddy_retailers.source_orders 
  (id, customer_id, status, order_date)
  VALUES
    (859, 735, 'open', '2023-02-01');
INSERT INTO teddy_retailers.source_order_products
  (order_id,product_id,product_quantity)
  VALUES
    (859,42,4);
INSERT INTO teddy_retailers.source_order_products
  (order_id,product_id,product_quantity)
  VALUES
    (859,22,1);