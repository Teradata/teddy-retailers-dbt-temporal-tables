with order_products as (

    select * from {{ ref('all_order_products') }}

),
orders as (

    select * from {{ ref('all_orders') }}

),
products as (

    select * from {{ ref('stg_products') }}
),

final as (

    select
        order_products.order_id,
        order_products.product_id,
        orders.customer_id,
        orders.order_date,
        products.price_dollars as unit_price,
        order_products.product_quantity as quantity,
        unit_price * quantity as amount
    
    from order_products
    left join products on order_products.product_id = products.product_id
    left join orders on order_products.order_id = orders.order_id

)

select * from final

