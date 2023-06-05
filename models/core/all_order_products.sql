{{ config(
  post_hook=[
    "COLLECT STATISTICS ON  {{ this }} COLUMN (order_id,  product_id);"
    ]
)}}

with add_new_order_products as (

  select * from {{ ref('stg_order_products') }}
  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE BEGIN(order_product_duration) > (SELECT MAX(BEGIN(order_product_duration)) FROM {{ this }})

  {% endif %}


),
final as (
  select 
    order_id,
    product_id,
    order_product_duration,
    sum(product_quantity) as product_quantity
  from add_new_order_products
  group by 1, 2, 3

)
select * from final