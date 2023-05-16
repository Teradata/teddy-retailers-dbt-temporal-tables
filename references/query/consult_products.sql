select 
    teddy_retailers.dim_products.product_id,
    sum(teddy_retailers.fct_order_details.quantity) as item_quantity,
    sum(teddy_retailers.fct_order_details.amount) as product_revenue,
    max(teddy_retailers.dim_orders.order_date) as last_ordered
From teddy_retailers.dim_products
left join teddy_retailers.fct_order_details on teddy_retailers.fct_order_details.product_id = teddy_retailers.dim_products.product_id
left join teddy_retailers.dim_orders on teddy_retailers.dim_orders.order_id = teddy.teddy_retailers.fct_order_details.product_id
GROUP BY 1