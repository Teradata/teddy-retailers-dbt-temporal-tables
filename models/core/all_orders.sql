{{ config(
  post_hook=[
    "ALTER TABLE {{ this }}
  ADD order_duration PERIOD(TIMESTAMP(6) WITH TIME ZONE) NOT NULL
  AS TRANSACTIONTIME;"
    ]
)}}

with add_new_orders as (

   select * from {{ ref('stg_orders') }}

)
select * from add_new_orders
