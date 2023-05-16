{{ config(
  post_hook=[
    "COLLECT STATISTICS ON  {{ this }} COLUMN (order_id,  customer_id);"
    ]
)}}

with add_new_orders as (

   select * from {{ ref('stg_orders') }}

)
select * from add_new_orders
