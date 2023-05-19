with orders as (

    select * from {{ ref('all_orders')}} 

),
final as (

    select 
        order_id,
        order_date,
        order_status 
    From orders
)
select * from final