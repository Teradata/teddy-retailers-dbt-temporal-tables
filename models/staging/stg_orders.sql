with source as (

    select * from {{ source('teddy_retailers', 'source_orders')}}

),

renamed as (

    select
        id as order_id,
        customer_id,
        order_date
        -- git status
    from source

)

select * from renamed