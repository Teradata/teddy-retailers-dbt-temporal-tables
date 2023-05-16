with products as (

    select * from {{ ref('stg_products')}} 

),
final as (

    select 
        product_id,
        product_name,
        product_category,
        price_dollars
    from products
        
)
select * from final