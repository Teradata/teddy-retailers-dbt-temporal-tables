{{ config(
	materialized="incremental",
	on_schema_change="append_new_columns",
	table_kind="MULTISET",
	index="PRIMARY INDEX ( customer_id ) INDEX (email)",
	post_hook= ["COLLECT STATISTICS INDEX (email), COLUMN ( id ) ON {{ this }};"]
)}}

with source as (

    select * from {{ source('teddy_retailers', 'source_customers')}}

),

renamed as (

    select
        id as customer_id,
        name as first_name,
        surname as last_name,
        email
    
    from source

)

select * from renamed