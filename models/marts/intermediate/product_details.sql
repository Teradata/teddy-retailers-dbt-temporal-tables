with product_order_details as (
    
    select * from {{ ref('product_order_details')}} 

),
orders as (

    select * from {{ ref('all_orders')}} 

),
final as (

    select 
        product_id,
        sum(quantity) as item_quantity,
        sum(amount) as product_revenue,
        max(orders.order_date) as last_ordered
    From product_order_details
    left join orders on orders.order_id = product_order_details.order_id
    GROUP BY 1
)
select * from final