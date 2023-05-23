SELECT 
    teddy_retailers.dim_customers.customer_id,
    teddy_retailers.dim_customers.email,
    SUM(teddy_retailers.fct_order_details.quantity) AS bought_items,
    SUM(teddy_retailers.fct_order_details.amount) AS tlv,
    MAX(teddy_retailers.fct_order_details.order_date) AS last_ordered
FROM teddy_retailers.dim_customers
LEFT JOIN teddy_retailers.fct_order_details ON teddy_retailers.fct_order_details.customer_id = teddy_retailers.dim_customers.customer_id
GROUP BY 1, 2
ORDER BY tlv DESC;