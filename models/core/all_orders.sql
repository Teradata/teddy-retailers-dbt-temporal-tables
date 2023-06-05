{{ config(
  post_hook=[
    "COLLECT STATISTICS ON  {{ this }} COLUMN (order_id,  customer_id);"
    ]
)}}

WITH add_new_orders AS (

  SELECT * FROM {{ ref('stg_orders') }}
  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE BEGIN(order_duration) > (SELECT MAX(BEGIN(order_duration)) FROM {{ this }})

  {% endif %}

)
select * from add_new_orders
