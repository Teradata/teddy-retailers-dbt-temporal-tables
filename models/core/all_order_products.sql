with add_new_order_products as (

    select * from {{ ref('stg_order_products') }}

)
select * from add_new_order_products