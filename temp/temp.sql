{{ config(
	materialized="incremental",
	on_schema_change="append_new_columns",
	table_kind="MULTISET",
	index="PRIMARY INDEX ( customer_id ) INDEX (email)",
	post_hook= ["COLLECT STATISTICS INDEX (email), COLUMN ( id ) ON {{ this }};"]
)}}

  post_hook= [
        "{% if not is_incremental() %}
        CREATE INDEX (email) ON {{ this }} ;
        COLLECT STATISTICS INDEX (email), COLUMN ( customer_id ) ON {{ this }};
        {% endif %}
        {% if is_incremental() %}
        SELECT * FROM {{ this }}
        {% endif %}"]