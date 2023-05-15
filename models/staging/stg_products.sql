with source as (

    select * from {{ source('teddy_retailers', 'source_products')}}

),

renamed as (

    select
        id as product_id,
        name as product_name,
        category as product_category,
        price_cents / 100 as price_dollars
    
    from source

)

select * from renamed