with customers as (

    select * from {{ ref('stg_customers')}} 

),
final as (

    select 
       customer_id,
       first_name,
       last_name,
       email

    from customers
        
)
select * from final