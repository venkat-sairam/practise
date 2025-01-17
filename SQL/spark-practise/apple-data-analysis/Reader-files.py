
# Databricks notebook source
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("analysis").getOrCreate()

# COMMAND ----------

customer_df = spark.read.format("csv").option("header", "true").option("inferSchema", True).load("dbfs:/FileStore/tables/Customer_Updated.csv")

# COMMAND ----------

products_df = spark.read.format("csv").option("header", "true").option("inferSchema", True).load("dbfs:/FileStore/tables/Products_Updated.csv")

# COMMAND ----------

transaction_df= spark.read.format("csv").option("header", "true").option("inferSchema", True).load("dbfs:/FileStore/tables/Transaction_Updated.csv")

# COMMAND ----------

# MAGIC %run "./Reader-factory"

# COMMAND ----------


class WorkFlow():

    def __init__(self):
        pass
    
    def runner(self):
        transaction_df = get_data_source(
            file_type= "csv",
            file_path= "dbfs:/FileStore/tables/Transaction_Updated.csv"
        ).load_data()

        transaction_df.show()

WorkFlow().runner()

# COMMAND ----------


