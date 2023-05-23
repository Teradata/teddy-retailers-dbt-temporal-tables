SELECT 
    teddy_retailers.dim_products.product_id,
    teddy_retailers.dim_products.product_name,
    SUM(teddy_retailers.fct_order_details.quantity) AS item_quantity,
    SUM(teddy_retailers.fct_order_details.amount) AS product_revenue,
    MAX(teddy_retailers.fct_order_details.order_date) AS last_ordered
FROM teddy_retailers.dim_products
LEFT JOIN teddy_retailers.fct_order_details ON teddy_retailers.fct_order_details.product_id = teddy_retailers.dim_products.product_id
GROUP BY 1, 2
ORDER BY product_revenue DESC;