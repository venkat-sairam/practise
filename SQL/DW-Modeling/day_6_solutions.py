# Import required libraries
from pyspark.sql import SparkSession
from pyspark.sql.functions import lit, expr, current_date, date_sub, col, datediff, year, count, month

# Spark Session Initialization
spark = (
    SparkSession
    .builder
    .appName("Working with Strings & Dates")
    .master("local[*]")
    .getOrCreate()
)

spark

# Sample employee data
data = [
    (1, 'Ankit', 100, 10000, 4, 39),
    (2, 'Mohit', 100, 15000, 5, 48),
    (3, 'Vikas', 100, 10000, 4, 37),
    (4, 'Rohit', 100, 5000, 2, 16),
    (5, 'Mudit', 200, 12000, 6, 55),
    (6, 'Agam', 200, 12000, 2, 14),
    (7, 'Sanjay', 200, 9000, 2, 13),
    (8, 'Ashish', 200, 5000, 2, 12),
    (9, 'Mukesh', 300, 6000, 6, 51),
    (10, 'Rakesh', 500, 7000, 6, 50),
]

columns = ["emp_id", "emp_name", "dept_id", "salary", "manager_id", "emp_age"]
employee = spark.createDataFrame(data).toDF(*columns)

employee.show()

employee.printSchema()

# Sample department data
data = [
    (100, 'Analytics'),
    (200, 'IT'),
    (300, 'HR'),
    (400, 'Text Analytics')
]

columns = ["dep_id", "dep_name"]
dept = spark.createDataFrame(data).toDF(*columns)

dept.show()

# Create new column for Date of Birth based on employee age
employee = employee.withColumn("dob", date_sub(current_date(), (col("emp_age") * 365).cast("int")))

# Write a query to print employee name, their manager name, and the difference in their age (in days) for employees whose year of birth is before their manager's year of birth
df_joined = (
    employee.alias("e1").join(employee.alias("e2"), on=(col("e1.manager_id") == col("e2.emp_id")), how="inner")
)

df_joined.show()

emp_details = (
    df_joined.where(year(col("e1.dob")) < year(col("e2.dob")))
)

emp_details.show()

emp_final = (
    emp_details
    .select(
        col("e1.emp_name"),
        col("e2.emp_name").alias("Manager_name"),
        datediff(col("e2.dob"), col("e1.dob")).alias("diff_in_days")
    )
)

emp_final.show()

# Create orders and returns DataFrames
orders_data = [
    (1, "Electronics", "2023-11-05"),
    (2, "Furniture", "2023-11-15"),
    (3, "Electronics", "2023-10-10"),
    (4, "Furniture", "2023-11-20"),
    (5, "Clothing", "2023-11-25"),
    (6, "Clothing", "2023-12-01"),
]
orders_columns = ["order_id", "sub_category", "order_date"]
orders_df = spark.createDataFrame(orders_data, schema=orders_columns)

returns_data = [
    (1, "Defective"),
]
returns_columns = ["order_id", "return_reason"]
returns_df = spark.createDataFrame(returns_data, schema=returns_columns)

# Join orders and returns DataFrames
orders_returns_joined_df = orders_df.alias("o").join(returns_df.alias("r"), on=(col('o.order_id') == col('r.order_id')), how="left")

orders_returns_joined_df.sort(col("sub_category"), col("order_date")).show()

# Subcategories with zero returned orders
(
    orders_returns_joined_df
    .groupby("sub_category")
    .agg(count("return_reason").alias("return_count"))
    .where(col("return_count") == 0)
    .select("sub_category", "return_count").show()
)

# Subcategories with zero returned orders in November
orders_returns_joined_df.select(month(col("order_date"))).show()

november_returned_orders_df = (
    orders_returns_joined_df
    .where(month(col("order_date")) == 11)
)

november_returned_orders_df.orderBy("sub_category").show()

(
    november_returned_orders_df
    .groupby("sub_category")
    .agg(count("return_reason").alias("return_reason_count"))
    .where(col("return_reason_count") == 0)
    .show()
)



### write a query to get number of business days between order_date and ship_date (exclude weekends). 
### Assume that all order date and ship date are on weekdays only


from pyspark.sql.functions import  expr, datediff

business_days_df =(
    orders_df
    .withColumn("business_days", 
               expr(
               """
               DATEDIFF(ship_date, order_date) + 1
               - (DATEDIFF(ship_date, order_date) / 7) * 2
               - CASE WHEN dayofweek(order_date) IN (1, 7) THEN 1 ELSE 0 END
               - CASE WHEN dayofweek(ship_date) IN (1, 7) THEN 1 ELSE 0 END
               """
               ).cast("int")
    )
    .show()
    
)
