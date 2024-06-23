# Databricks notebook source


# COMMAND ----------

df = spark.read.table('employees_csv')

# COMMAND ----------

df.show(4)

# COMMAND ----------

df.printSchema()

# COMMAND ----------

df = df.drop("PHONE_NUMBER")

# COMMAND ----------

df.show(2)

# COMMAND ----------

df.select("*").show(5)

# COMMAND ----------

df.select("EMPLOYEE_ID", "FIRST_NAME").show(3)

# COMMAND ----------

from pyspark.sql.functions import column

# COMMAND ----------

df.select(column("FIRST_NAME").alias("first_name"), column("EMPLOYEE_ID").alias("emp_id")).show(2)

# COMMAND ----------

df.select("EMPLOYEE_ID","FIRST_NAME","SALARY").withColumn("Revised_Salary", column("SALARY") + 1000).show(4)

# COMMAND ----------

df.withColumnRenamed("SALARY", "salary").show(5)

# COMMAND ----------

df.columns

# COMMAND ----------

df.filter(column("SALARY") < 2200).select("EMPLOYEE_ID", "FIRST_NAME", "HIRE_DATE", "DEPARTMENT_ID").show(5)

# COMMAND ----------

df.filter(column("DEPARTMENT_ID") == 50).sort("SALARY").select("EMPLOYEE_ID", "FIRST_NAME", "HIRE_DATE", "DEPARTMENT_ID", "SALARY").show(5)

# COMMAND ----------



# COMMAND ----------

dept_50_filter = df.filter(df['DEPARTMENT_ID']==50)
dept_50_filter.select(df['SALARY']).distinct().show()

# COMMAND ----------

df.count()

# COMMAND ----------

df.dropDuplicates().count()

# COMMAND ----------

from pyspark.sql.functions import min, max, count, mean, std, avg, sum

# COMMAND ----------

df.select(min("SALARY").alias("min_salary")
          , max("SALARY").alias("max_salary")
          , avg("SALARY").alias("avg_salary")
          , sum("SALARY").alias("total_salary")
          , std("SALARY").alias("std_Dev")
          ).show()

# COMMAND ----------

df.select("EMPLOYEE_ID","FIRST_NAME","DEPARTMENT_ID","SALARY") \
.orderBy(df['DEPARTMENT_ID'].asc(), df['SALARY'].asc())\
.show(4)

# COMMAND ----------

df.groupBy("DEPARTMENT_ID") \
.agg(count("DEPARTMENT_ID").alias("total_staff")) \
.orderBy("total_staff", ascending=False) \
.show()

# COMMAND ----------

df.createOrReplaceTempView("employee")

# COMMAND ----------

df.groupBy("DEPARTMENT_ID").agg(sum("SALARY").alias("total_salary")).orderBy("total_salary", ascending=False).show()

# COMMAND ----------

spark.sql("select department_id, sum(salary) as total_Salary from employee group by department_id").show()

# COMMAND ----------

spark.sql("select EMPLOYEE_ID, FIRST_NAME, SALARY,MANAGER_ID, DEPARTMENT_ID  from employee").show()

# COMMAND ----------

spark.sql("select EMPLOYEE_ID, FIRST_NAME, SALARY,MANAGER_ID, DEPARTMENT_ID, row_number() over (partition by department_id order by salary) as rn from employee").show()

# COMMAND ----------

df.alias("t1").join(df.alias("t2"), 
                    column('t1.DEPARTMENT_ID') == column('t2.MANAGER_ID'), 
                    "inner")\
                    .select(
                        column('t1.employee_id'),
                        column('t1.first_name'), 
                        column('t1.salary'), 
                        column('t1.manager_id'))\
                    .show() 

# COMMAND ----------

df.columns

# COMMAND ----------

dept_df = spark.read.table("departments")

# COMMAND ----------

dept_df.show()

# COMMAND ----------

from pyspark.sql.functions import col

# COMMAND ----------

df.columns

# COMMAND ----------

dept_df.columns

# COMMAND ----------

groupBy("DEPARTMENT_NAME").agg(count("*"))

# COMMAND ----------

df.join(dept_df, df.DEPARTMENT_ID == dept_df.DEPARTMENT_ID, 'inner').select("EMPLOYEE_ID", "FIRST_NAME", "SALARY", "DEPARTMENT_NAME" )\
.groupBy("DEPARTMENT_NAME").agg(max("SALARY").alias("max_salary")) \
.orderBy("max_salary", ascending=False).show()

# COMMAND ----------

from pyspark.sql.window import Window as window

# COMMAND ----------

joined_df = df.join(dept_df, df.DEPARTMENT_ID == dept_df.DEPARTMENT_ID, 'inner')
window_spec  = window.partitionBy("DEPARTMENT_NAME").orderBy(col("SALARY").desc())


# COMMAND ----------

from pyspark.sql.functions import dense_rank, row_number, rank

# COMMAND ----------

joined_df.select("EMPLOYEE_ID", "FIRST_NAME", "SALARY", "DEPARTMENT_NAME", dense_rank().over(window_spec).alias("rank_number")).filter(col("rank_number") <=2).show()

# COMMAND ----------


