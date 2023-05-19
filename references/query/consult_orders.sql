select 
    teddy_retailers.dim_orders.order_id,
    teddy_retailers.dim_orders.order_date as order_date,
    sum(teddy_retailers.fct_order_details.quantity) as item_quantity,
    sum(teddy_retailers.fct_order_details.amount) as total_value
From teddy_retailers.dim_orders
LEFT JOIN  teddy_retailers.fct_order_details on teddy_retailers.fct_order_details.order_id = teddy_retailers.dim_orders.order_id
GROUP BY 1, 2
ORDER BY total_value DESC;

select 
    teddy_retailers.dim_orders.order_status,
    count(teddy_retailers.dim_orders.order_id) as currently_in,
From teddy_retailers.dim_orders
GROUP BY 1
ORDER BY currently_in DESC
ROLLUP;
