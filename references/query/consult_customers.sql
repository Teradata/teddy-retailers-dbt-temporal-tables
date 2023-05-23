select 
    teddy_retailers.dim_customers.customer_id,
    teddy_retailers.dim_customers.email,
    sum(teddy_retailers.fct_order_details.quantity) as bought_items,
    sum(teddy_retailers.fct_order_details.amount) as tlv,
    max(teddy_retailers.fct_order_details.order_date) as last_ordered
From teddy_retailers.dim_customers
left join teddy_retailers.fct_order_details on teddy_retailers.fct_order_details.customer_id = teddy_retailers.dim_customers.customer_id
GROUP BY 1, 2
ORDER BY tlv DESC;