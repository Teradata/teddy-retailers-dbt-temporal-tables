{% snapshot snapshot-source-orders %}

    {{
        config(
          target_schema='teddy_retailers',
          strategy='check',
          unique_key='id',
          check_cols='all',
        )
    }}

    select * from {{ source('teddy_retailers', 'source_orders_nt') }}

{% endsnapshot %}