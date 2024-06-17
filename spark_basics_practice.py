# Databricks notebook source
# MAGIC %sql
# MAGIC select * from  uber_data;

# COMMAND ----------

from pyspark.sql import SparkSession

# COMMAND ----------

spark = SparkSession.builder \
        .appName('practiceSpark') \
        .getOrCreate()

# COMMAND ----------

spark

# COMMAND ----------

df = spark.read.table("uber_data")

# COMMAND ----------

# MAGIC %md
# MAGIC To print the schema of the dataframe, use printSchema() function on the dataframe.

# COMMAND ----------

df.printSchema()

# COMMAND ----------

from pyspark.sql.functions import col, column

# COMMAND ----------

df.select(col("total_amount")).show(5)

# COMMAND ----------

df.select(column("total_amount")).show(3)

# COMMAND ----------

df.select(column("VendorID"), col( "fare_amount")).show(3)

# COMMAND ----------

df.select(col("fare_amount").alias("trip_fare")).show(2)

# COMMAND ----------

df.select(col('fare_amount'), col("fare_amount")+ 5).show(3)

# COMMAND ----------

# MAGIC %md
# MAGIC selectExpr is used when we want to pass SQL like expressions directly on the dataframe.

# COMMAND ----------

df.selectExpr("fare_amount", "fare_amount+5 as plus_five").show(3)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Adding new columns: withColumn
# MAGIC ## Renamingcolumn: withColumnRenamed

# COMMAND ----------

df.withColumn("fare_plus_5", col("fare_amount")+5).show(2)

# COMMAND ----------

df.withColumnRenamed("fare_amount", "total_fare")

# COMMAND ----------

df.columns

# COMMAND ----------

df.filter(col('total_amount') < 0).select('total_amount').show(5)

# COMMAND ----------

df.select(col("total_amount").cast("int")).show(2)

# COMMAND ----------

df.selectExpr("cast(total_amount as int)").show(6)

# COMMAND ----------

df.select("payment_type").distinct().show()

# COMMAND ----------

df.sample(withReplacement=True, fraction=0.2, seed=123).show(2)

# COMMAND ----------

df.select("VendorID", "tolls_amount", "trip_distance", "payment_type").orderBy("payment_type", "trip_distance").show(4)

# COMMAND ----------

df.orderBy("trip_distance", ascending=False).show(3)

# COMMAND ----------

df.rdd.getNumPartitions()

# COMMAND ----------

df.repartition(10)

# COMMAND ----------

df.rdd.getNumPartitions()

# COMMAND ----------

df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ### To find the correlation between any variables, use corr() method on tpo of dataframe.

# COMMAND ----------

df.corr(('total_amount'), ('tolls_amount'))

# COMMAND ----------

# MAGIC %md
# MAGIC ### To print the descriptive statistics: MIN/MAX/COUNT/MEAN/STD-DEV use: df.describe()

# COMMAND ----------

df.select('fare_amount', 'extra', 'tip_amount', 'tolls_amountdf').describe().show()

# COMMAND ----------

from pyspark.sql.functions import lit, lpad, rpad, trim, ltrim, rtrim, lower, upper, initcap
df.select(lower(lit("   Venkata sairam   ")),
          upper(lit("   Venkata sairam   ")),
          trim(lit("   Venkata sairam   ")),
          ltrim(lit("   Venkata sairam   ")),
          rtrim(lit("   Venkata sairam   ")),
           ).show(4)

# COMMAND ----------

from pyspark.sql.functions import regexp_extract, regexp_replace, translate

# COMMAND ----------

df.select(regexp_replace(lit("   Venkata sairam   "), pattern="\s+", replacement="*").alias("name")).show(2)


# COMMAND ----------

df.select(regexp_extract(lit("   venkata Sairam **"), pattern='[\w\s]+', idx=0).alias("name")).show(3)

# COMMAND ----------

df.select(translate(lit("   venkata Sairam  "), "ve", "ev").alias('replaced_str')).show(4)

# COMMAND ----------

data = {
    ('Venkata Sairam', 28, "AP"),
    ("Venkat", 26, "TG"),
    ("Ram", 26, "TG"),
    (None, None, "AP")
}
columns=["name", "age", "city"]

temp = spark.createDataFrame(data, columns)

# COMMAND ----------

temp.show()

# COMMAND ----------

temp.printSchema()

# COMMAND ----------

temp.select("*").show()

# COMMAND ----------

temp.where(col('city').contains("AP")).show()

# COMMAND ----------

temp.na.drop().show()

# COMMAND ----------

temp.na.drop(how="all").show()

# COMMAND ----------

temp.na.fill("empty").show()

# COMMAND ----------

temp.orderBy(col("name").desc_nulls_last()).show()

# COMMAND ----------

from pyspark.sql.functions import split, size, array_contains, explode

# COMMAND ----------

temp.select(split(col("name"), " ").alias("full name")).show()

# COMMAND ----------

temp.select(array_contains(split(col("name"), " "), "Ram")).show()

# COMMAND ----------

temp.select(size(split(col("name"), " "))).show()

# COMMAND ----------

temp.select(explode(split("name", " ")), "*").show()

# COMMAND ----------


