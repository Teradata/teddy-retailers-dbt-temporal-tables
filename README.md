# Teddy Retailers Advanced dbt with Teradata Vantage (Summary for now)

## Content of Demo
This demo covers the following advanced dbt concepts with Teradata Vantage:
- Incremental Materialization
    - Delete + insert strategy (note: no updates are supported due to a bug)
    - Append
- Macros
    - equal_rowcount
    - unique_combination_of_columns
- Teradata Configurations
    - index definition
    - define collection of statistics (through post_hooks)

## Transformations
### Normalized Schema
- customers
- orders
- order_products
- products
### Dimmensional Data
- fct_order_details (contains foreign keys to all dimmensions)
- dim_customers
- dim_orders
- dim_products

## Execution
- Tnitial reading of data to set_up the sources including initial state of transaction tables.
- run dbt
- execute the query scripts to see result
- Second reading of data to load the delta on transaction tables.
- run dbt
- execute the query scripts to see delta on results

## This is just a summary to explain current status.

