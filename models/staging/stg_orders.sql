
with source as (

    select * from {{ source('teddy_retailers', 'source_orders')}}

),

renamed as (

    select
        id as order_id,
        customer_id,
        order_date,
        status as order_status
    from source

)

select * from renamed