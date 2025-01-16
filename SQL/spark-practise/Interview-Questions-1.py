# Databricks notebook source
# MAGIC %md
# MAGIC ## Print all the duplicate recordsin the dataframe

# COMMAND ----------

data = [(1, 'abc@gmail.com'), (2, 'abcd@gmail.com'), (1, 'abc@gmail.com')]
column = ['id', 'email']

df = spark.createDataFrame(data, column)

# COMMAND ----------

from pyspark.sql.functions import col, count
(
  df
  .groupBy("id")
  .agg(count("*").alias("count"))
  .filter(col("count") > 1)
  .show()

)

# COMMAND ----------

# DBTITLE 1,Remove the duplicate records


df.select("id").distinct().show()

# COMMAND ----------

# DBTITLE 1,Question-2: Dataset
data = [(1, 'venkat'), (2, 'sai'), (3, 'Manish'), (4, 'YT')]
column = ["customer_id", "customer_name"]

customer_df = spark.createDataFrame(data, column)

order_data =[(1, 4), (3, 2)]
column=["order_id", "customer_id"]
order_df = spark.createDataFrame(order_data, column)

customer_df.show()
order_df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Find out the customers who have not ordered anything
# MAGIC

# COMMAND ----------



joined_df = customer_df.join(order_df, on = (customer_df.customer_id == order_df.customer_id), how = "left")



# COMMAND ----------

joined_df.show()

# COMMAND ----------

joined_df \
.where(col("order_id").isNull()) \
.show()

# COMMAND ----------


dept_df = spark.read.format("csv").option("header", "true").load("dbfs:/FileStore/tables/departments.csv")

# COMMAND ----------

emp_df = spark.read.format("csv").option("header", "true").load("dbfs:/FileStore/tables/employees.csv")

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE TABLE employees
# MAGIC USING CSV
# MAGIC OPTIONS (path "dbfs:/FileStore/tables/employees.csv", header "true", delimiter ",")

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE TABLE department
# MAGIC USING CSV
# MAGIC OPTIONS (path "dbfs:/FileStore/tables/departments.csv", header "true", delimiter ",")

# COMMAND ----------

spark.sql("select * from department")

# COMMAND ----------

# MAGIC %md
# MAGIC ## Find out the highest salary in each department

# COMMAND ----------

# MAGIC %sql
# MAGIC select
# MAGIC DEPARTMENT_ID
# MAGIC , max(SALARY) as highest_Salary
# MAGIC  from employees
# MAGIC group by DEPARTMENT_ID
# MAGIC order by DEPARTMENT_ID
# MAGIC limit 5

# COMMAND ----------

from pyspark.sql.functions import max

(
    emp_df
    .groupBy(col("DEPARTMENT_ID"))
    .agg(max("SALARY").alias("max_salary"))
    .show(5)
)

# COMMAND ----------

# MAGIC %sql
# MAGIC select 
# MAGIC  d.DEPARTMENT_NAME
# MAGIC  , max(e.SALARY) as max_salary
# MAGIC  from employees e
# MAGIC left join department d
# MAGIC on e.DEPARTMENT_ID = d.DEPARTMENT_ID
# MAGIC group by d.DEPARTMENT_NAME
# MAGIC order by max_salary 

# COMMAND ----------


from pyspark.sql.functions import desc
(
  emp_df.join(dept_df, on =(emp_df.DEPARTMENT_ID == dept_df.DEPARTMENT_ID), how = "left") 
  .groupBy(dept_df.DEPARTMENT_NAME)
  .agg(max("SALARY").alias("max_salary"))
  .orderBy(col("max_salary").desc())
  .show(4)
)

# COMMAND ----------

data = [(1, ['A', 'B', 'C']), (2, ['D', 'E'])]
column = ["id", "objects"]

df = spark.createDataFrame(data, column)
df.show()

# COMMAND ----------

from pyspark.sql.functions import explode
df.select("*",explode(col("objects"))).show()

# COMMAND ----------

# DBTITLE 1,print the first not null value from the given data frame colulmns
from pyspark.sql.functions import coalesce

data  = [(1, 'yes', None, None), (2, None, 'yes', None), (3, None, None, 'yes'), (4, 'NO', None, 'yes')]
column = ["id", "d1", "d2", "d3"]

df = spark.createDataFrame(data, column)

df.select("*", coalesce("d1", "d2", "d3")).show()

# COMMAND ----------

data = [("A", '{"street":"123", "city":"boulder"}'), ("B", '{"street":"234", "city":"Denver"}')]
column = ['name', 'address']

df = spark.createDataFrame(data, column)
df.show(truncate=False)
df.printSchema()

# COMMAND ----------

from pyspark.sql.functions import to_json, from_json

df_new = df.withColumn("address_new", from_json("address", schema="street string, city string"))
df_new.printSchema()
df_new.show()

# COMMAND ----------

df_new.select("*", "address_new.street", "address_new.city").show()

# COMMAND ----------


