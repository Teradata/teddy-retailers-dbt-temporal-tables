with source as (

    select * from {{ source('teddy_retailers', 'source_order_products')}}

),

renamed as (

    select
        order_id,
        product_id,
        product_quantity

    from source

)

select * from renamed