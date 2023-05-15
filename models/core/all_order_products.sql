{{
    config(
        materialized='incremental',
        unique_key = ['order_id', 'product_id'],
        incremental_strategy = 'delete+insert'
    )
}}

with add_new_order_products as (

    select * from {{ ref('stg_order_products') }}

)
select * from add_new_order_products