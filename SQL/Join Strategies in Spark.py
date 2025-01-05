# Databricks notebook source
# MAGIC %md
# MAGIC ## Broadcasting Default Threshold
# MAGIC Max size of dataframe that can be broadcasted. The default is 10 MB. Which means only datasets below 18 MB can be broadcasted.
# MAGIC

# COMMAND ----------

from pyspark.sql.functions import broadcast

# COMMAND ----------

spark.conf.get("spark.sql.autoBroadcastJoinThreshold")


# COMMAND ----------

data1 = [[10],  [40], [10], [40],[20], [30], [20], [20], [20], [20], [50]]
df1 = spark.createDataFrame(data1, ["id"])

data2 = [[46], [50],[30], [20]]
df2 = spark.createDataFrame(data2, ["id2"])


# COMMAND ----------

display(df1), display(df2)

# COMMAND ----------

df_joined = df1.join(df2, df1['id'] == df2['id2'], how='inner')

# COMMAND ----------

df_joined.show()

# COMMAND ----------

df_joined = df1.join(broadcast(df2), df1['id'] == df2['id2'], how='inner')

# COMMAND ----------

df_joined.explain()

# COMMAND ----------

# MAGIC %md
# MAGIC Broadcast works very well under the following conditions:
# MAGIC - works only for equi-joins
# MAGIC - Broadcast Hash Join works whenever there is a small dataset and it can be hashed
# MAGIC - If one of the datasets is too big, then it could be more expensive to perform broadcast joins and leads to job execution slow down and memory outage errors. This is due to the fact that broadcasted table will be kept in the executors memory.
# MAGIC - There won't be any shuffling in the context of broadcast joins.
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC - We cannot perform joins, unless the data is available in a same executor.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Shuffle Hash Join

# COMMAND ----------

# MAGIC %md
# MAGIC 1. step-1: shuffle the data between the executors.
# MAGIC 2. step-2: Perform Hashing on the related keys.

# COMMAND ----------

# MAGIC %md
# MAGIC - only works with equi joins.
# MAGIC - works only when the sort-merge join disabled.(by default enabled).
# MAGIC - 
# MAGIC

# COMMAND ----------

spark.conf.set("spark.sql.adaptive.enabled", "false")


# COMMAND ----------

spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

# COMMAND ----------

spark.conf.set("spark.sql.join.prefer.SortMergeJoin", "false")

# COMMAND ----------

df_joined = df1.join((df2), df1['id'] == df2['id2'], how='inner')

# COMMAND ----------

df_joined.show()

# COMMAND ----------

df_joined.explain()

# COMMAND ----------

spark.conf.get("spark.sql.autoBroadcastJoinThreshold")

# COMMAND ----------

shuffle_partitions = spark.conf.get("spark.sql.shuffle.partitions")
print(f"Configured shuffle partitions: {shuffle_partitions}")


# COMMAND ----------


# Check configurations
print("Adaptive Query Execution Enabled:", spark.conf.get("spark.sql.adaptive.enabled"))
print("Prefer Sort Merge Join:", spark.conf.get("spark.sql.join.preferSortMergeJoin"))
print("Auto Broadcast Join Threshold:", spark.conf.get("spark.sql.autoBroadcastJoinThreshold"))


# COMMAND ----------

# Create small dummy datasets
data1 = [Row(id=1, name="Alice"), Row(id=2, name="Bob")]
data2 = [Row(id2=1, age=25), Row(id2=2, age=30)]


# COMMAND ----------

df_joined = df1.join(df2, df1['id'] == df2['id2'], how='inner')

# Show execution plan
df_joined.explain(True)

# COMMAND ----------

df1

# COMMAND ----------

df2.show()


# COMMAND ----------


