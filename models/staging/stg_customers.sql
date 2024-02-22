{{ config(
	materialized="incremental",
	on_schema_change="append_new_columns",
	table_kind="MULTISET",
    post_hook= [
        "{% if not is_incremental() %} CREATE INDEX (email) ON {{ this }} {% endif %};",
        "{% if not is_incremental() %} COLLECT STATISTICS INDEX (email), COLUMN ( customer_id ) ON {{ this }} {% endif %};"
        ]
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