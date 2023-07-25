# Teddy Retailers Advanced dbt with Teradata Vantage Temporal Tables

This project showcases the integration of dbt with Teradata Vantage from an advanced user perspective. If you are new to data engineering with dbt we recommend that you start with our [introductory project.](https://github.com/Teradata/jaffle_shop-dev)

The advanced use case showcased in this demo is the combination of dbt with Teradata Vantage temporal tables features.

The application of these concepts is illustrated through the ELT process of `teddy_retailers`, a fictional store. The demo is focused on the ingestion of data into an incremental model filtering for data ingested after the previous dbt run. This objective is attained through usage of Teradata Vantage temporal tables features.

The source data consists of the following tables customers, orders, products, and order_products, according to the following Entity Relations Diagram.

![Teddy Retailers Initial ERD](/etc/teddy_retailers_initial_erd.png)

After the dbt driven transformations the `fact table` fct_order_details is created, this table contains all quantitive data related to the orders (facts), and the foreign keys to link these facts to all dimensions. A dimension table is created for each of the categorical values, customers, orders, and products, according to the following Entity Relations Diagram.

![Teddy Retailers Final ERD](/etc/teddy_retailers_final_erd.png)

The data in two of our sources `sources_orders`, and `source_order_products`, is updated periodically. These sources contain Teradata Vantage `TRANSACTIONTIME` PERIOD fields, `order_duration` and `order_product_duration`, respectively. The Period columns keep an automated record of timestamps pointing to the period of time when the data was inserted or updated. Using these timestamps in conjuction with dbt allows to ingest only newly inserted of udpated data in our dbt models. For this purpose we have defined, as part of our design, two incremental models, all_orders, and all_order_products. 

![Teddy Retailers Incremental ERD](/etc/teddy_incrementals.png)

## Running the Project

### Pre-requisites
* Access to a Teradata Vantage Instance. You can provision one for free at [ClearScape Analytics Experience.](https://clearscape.teradata.com/sign-in?utm_source=github&utm_medium=readme&utm_campaign=dbt-temp-tables)
* Your favorite database client.
* Python 3.9 - 3.10 (recommended).

### Steps
#### Setting Up Environment
* Create a Python virtual environment `python -m venv venv`
* Activate your Python virtual environment according to your operating system.
* Install dbt-teradata `pip install dbt-teradata`
* Clone this repository.
* CD into the directory that contains your cloned version of this repository.
* Create the profile teddy_retailers in your `~/.dbt/profiles.yml`. You might need to create this folder and file if this is the first dbt project that you have created or cloned in your working environment.

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

* Run `dbt debug` to make sure the connection to your data warehouse is working properly. 
* Run `dbt deps` to install the project dependencies. 

#### Loading data to sources (baseline data) 
* The demo project assumes that the source data is already in your warehouse, this mimics more closely the way that dbt is used in a production environment. To achieve this objective we provide public datasets available in GCP and [scripts to load those datasets into your mock data warehouse](/references/inserts/). These scripts can be executed by simply copying and pasting into your favorite database client. 
* To load the data in your data warehouse the existence of the teddy_retailers database is assumed. A simple SQL script to achieve this is provided as create_db.sql. The exact form of this script might vary depending on the edition of Teradata Vantage you are using and your privileges on the server.
* Once the database exists you can execute the script create_data.sql in your database client.

#### Running and Testing Transformations
* Run `dbt run` to execute the transformations on the baseline data.
* The incremental models are created at this point.
* Check the statistics on both all_orders and all_order_products through your database client `HELP STATS <table name>`, this permits a fast confirmation regarding the data that was transformed.
* At this point, you can execute any of the query scripts in references/query in your database client to view the fact data sliced by a specific dimension.

#### Ingesting deltas on baseline
* To mimic the batch process of data loading, the loading of deltas on the baseline data, execute the update_data script in references/inserts.
* After loading the updated data, the steps of the section above (running and testing transformations) can be repeated in order to see the changes.

For questions on this project, you can contact us at [Ecosystem Management - Community](https://support.teradata.com/community?id=community_forum&sys_id=353d17d44fed7f00dcf7a6118110c7b5)
