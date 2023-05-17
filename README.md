# Teddy Retailers Advanced dbt with Teradata Vantage

In this project we showcase the integration of dbt with Teradata Vantage from an advanced user perspective. If you are a new to data engineering with dbt we recommend that you start with our [introductory project](https://github.com/Teradata/jaffle_shop-dev)

The advanced use cases showcased in the demo are the following:

* Incremental materializations
* Utility macros
* Optimizing table/view creations with Teradata-specific modifiers

The application of these concepts is illustrated through the ELT process of `teddy_retailers`, a fictional store. Through dbt driven transformations we transform source data from `teddy_retailers` transactional database into a star schema ready for analytics.

The source data consists of the following tables customers, orders, products, and order_products, according to the following Entity Relations Diagram.


![Teddy Retailers ERD](/etc/teddy_retailers_initial_erd.png)


After the dbt driven transformations the `fact table` fct_order_details is created, this table contains all quantitive data related to the orders (facts), and the foreign keys to link these facts to all other dimmensions. A dimension table is created for each of the categorical values, customers, orders, products, according to the following Entity Relations Diagram.


![Teddy Retailers ERD](/etc/teddy_retailers_final_erd.png)


## Running the Project

### Pre-requisites
* Access to a Teradata Vantage Instance. You can provision one for free at [ClearScape Analytics Experience](https://clearscape.teradata.com/sign-in)
* Python 3.9 or above (recommended).

### Steps
#### Setting Up Environment
* Create a python virtual environment `python -m venv venv`
* Activate yur python virtual environment according to your operating system.
* Clone this repository
* CD into the directory that contains your clonned version of this repository.
* Create the profile teddy_retailers in your `~/.dbt/profiles.yml`. You might need to create this folder and file if this is the first dbt project that you have created or clonned in your working environment.

```
teddy_retailers:
  target: dev
  outputs:
    dev:
      type: teradata
      server: <Your server host>
      schema: teddy_retailers
      username: <Your server user>
      password: <Your server password>
      tmode: ANSI
```



* The demo project assumes that the source data is already in your warehouse, this mimics more closely the way that dbt will be used in a production environment. To attain this state we provide public datasets available in GCP and [scripts to load those datasets into your mock data warehouse](/references/inserts/).  


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

## dbt models for `jaffle_shop`

`jaffle_shop` is a fictional ecommerce store. This dbt project transforms raw
data from an app database into a customers and orders model ready for analytics.

The raw data from the app consists of customers, orders, and payments, with the
following entity-relationship diagram:

![Jaffle Shop ERD](/etc/jaffle_shop_erd.png)


### Using this project as a tutorial
To get up and running with this project:
1. Install dbt using [these instructions](https://docs.getdbt.com/docs/installation).

2. Clone this repository. If you need extra help, see [these instructions](https://docs.getdbt.com/docs/use-an-existing-project).

3. Change into the `jaffle_shop` directory from the command line:
```bash
$ cd jaffle_shop
```

4. Set up a profile called `jaffle_shop` to connect to a data warehouse by
  following [these instructions](https://docs.getdbt.com/docs/configure-your-profile).
  If you have access to a data warehouse, you can use those credentials – we
  recommend setting your [target schema](https://docs.getdbt.com/docs/configure-your-profile#section-populating-your-profile)
  to be a new schema (dbt will create the schema for you, as long as you have
  the right priviliges). If you don't have access to an existing data warehouse,
  you can also setup a local postgres database and connect to it in your profile.

5. Ensure your profile is setup correctly from the command line:
```bash
$ dbt debug
```

6. Load the CSVs with the demo data set. This materializes the CSVs as tables in
  your target schema. Note that a typical dbt project **does not require this
  step** since dbt assumes your raw data is already in your warehouse.
```bash
$ dbt seed
```

7. Run the models:
```bash
$ dbt run
```

> **NOTE:** If this steps fails, it might be that you need to make small changes to the SQL in the models folder to adjust for the flavor of SQL of your target database. Definitely consider this if you are using a community-contributed adapter.

8. Test the output of the models:
```bash
$ dbt test
```

9. Generate documentation for the project:
```bash
$ dbt docs generate
```

10. View the documentation for the project:
```bash
$ dbt docs serve
```

### What is a jaffle?
A jaffle is a toasted sandwich with crimped, sealed edges. Invented in Bondi in 1949, the humble jaffle is an Australian classic. The sealed edges allow jaffle-eaters to enjoy liquid fillings inside the sandwich, which reach temperatures close to the core of the earth during cooking. Often consumed at home after a night out, the most classic filling is tinned spaghetti, while my personal favourite is leftover beef stew with melted cheese.

---
For more information on dbt:
- Read the [introduction to dbt](https://dbt.readme.io/docs/introduction).
- Read the [dbt viewpoint](https://dbt.readme.io/docs/viewpoint).
- Join the [chat](http://slack.getdbt.com/) on Slack for live questions and support.
---
