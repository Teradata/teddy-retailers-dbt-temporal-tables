SELECT 
    teddy_retailers.dim_orders.order_id,
    teddy_retailers.dim_orders.order_date,
    SUM(teddy_retailers.fct_order_details.quantity) AS item_quantity,
    SUM(teddy_retailers.fct_order_details.amount) AS total_value
FROM teddy_retailers.dim_orders
LEFT JOIN teddy_retailers.fct_order_details ON teddy_retailers.fct_order_details.order_id = teddy_retailers.dim_orders.order_id
GROUP BY 1, 2
ORDER BY total_value DESC;

SELECT 
    teddy_retailers.dim_orders.order_status,
    COUNT(teddy_retailers.dim_orders.order_id) AS currently_in
FROM teddy_retailers.dim_orders
GROUP BY 1
ORDER BY currently_in DESC;
