{{ config(
  post_hook=[
    "COLLECT STATISTICS ON  {{ this }} COLUMN (order_id,  product_id);"
    ]
)}}

with add_new_order_products as (

    select * from {{ ref('stg_order_products') }}

)
select * from add_new_order_products