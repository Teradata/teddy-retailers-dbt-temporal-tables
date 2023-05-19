{{ config(
  post_hook=[
    "COLLECT STATISTICS ON  {{ this }} COLUMN (order_id,  product_id);"
    ]
)}}

with add_new_order_products as (

  select * from {{ ref('stg_order_products') }}

),
final as (
  select 
    order_id,
    product_id,
    sum(product_quantity) as product_quantity
  from add_new_order_products
  group by 1, 2

)
select * from final