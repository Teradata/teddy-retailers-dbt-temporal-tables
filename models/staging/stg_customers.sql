with source as (

    select * from {{ source('teddy_retailers', 'source_customers')}}

),

renamed as (

    select
        id as customer_id,
        name as first_name,
        surname as last_name,
        email
    
    from source

)

select * from renamed