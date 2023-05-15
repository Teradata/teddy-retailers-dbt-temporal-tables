with add_new_orders as (

    select * from {{ ref('stg_orders') }}

)
select * from add_new_orders
