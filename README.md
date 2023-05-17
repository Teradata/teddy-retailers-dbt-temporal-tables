# Teddy Retailers Advanced dbt with Teradata Vantage

This project showcases the integration of dbt with Teradata Vantage from an advanced user perspective. If you are new to data engineering with dbt we recommend that you start with our [introductory project.](https://github.com/Teradata/jaffle_shop-dev)

The advanced use cases showcased in the demo are the following:

* Incremental materializations
* Utility macros
* Optimizing table/view creations with Teradata-specific modifiers

The application of these concepts is illustrated through the ELT process of `teddy_retailers`, a fictional store. Through dbt driven transformations we transform source data from the`teddy_retailers` transactional database into a star schema ready for analytics.

The source data consists of the following tables customers, orders, products, and order_products, according to the following Entity Relations Diagram.


![Teddy Retailers Initial ERD](/etc/teddy_retailers_initial_erd.png)


After the dbt driven transformations the `fact table` fct_order_details is created, this table contains all quantitive data related to the orders (facts), and the foreign keys to link these facts to all dimensions. A dimension table is created for each of the categorical values, customers, orders, and products, according to the following Entity Relations Diagram.


![Teddy Retailers Final ERD](/etc/teddy_retailers_final_erd.png)


The catch of this project is that the data in two of our sources orders, and order_products, is updated periodically, the data that appears in those sources is only the delta regarding new orders that happened since the previous data load. This means that we need to persist all data in previous transformations regarding those two sources in order we capture all data and not only the most recent deltas.

For the purpose above we have defined, as part of our design, two incremental models, all_orders, and all_order_products. To help us in the management of these two models we have created two macro-assisted tests, we are defining a primary key on all_orders, and we are tracking the statistics of both of them.

![Teddy Retailers Incremental ERD](/etc/teddy_incrementals.png)

## Running the Project

### Pre-requisites
* Access to a Teradata Vantage Instance. You can provision one for free at [ClearScape Analytics Experience.](https://clearscape.teradata.com/sign-in)
* Your favorite database client.
* Python 3.9 or above (recommended).

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
* The incremental models (used for data persistence), and the star schema tables are created at this point.
* Run `dbt test` to run the tests.
    - One test confirms the integrity of the all_order_products model by making sure that each product is referenced only once per order. 
    - The other test confirms the integrity of the fct_order_details model by confirming it has as many raws as the all_order_products_model.
* Check the statistics on both all_orders and all_order_products through your database client `HELP STATS <table name>`.
* At this point, you can execute any of the query scripts in references/query in your database client to view the fact data sliced by a specific dimension.

#### Ingesting deltas on baseline
* To mimic the batch process of data loading, the loading of deltas on the baseline data, execute the update_data script in references/inserts.
* After loading the deltas, the steps of the section above (running and testing transformations) can be repeated in order to see the changes.

For questions on this project, you can contact us at [Ecosystem Management - Community](https://support.teradata.com/community?id=community_forum&sys_id=353d17d44fed7f00dcf7a6118110c7b5)
