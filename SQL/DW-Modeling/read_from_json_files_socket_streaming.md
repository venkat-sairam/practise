```python
from pyspark.sql import SparkSession

spark = (
    SparkSession
    .builder
    .appName("read_from json")
    .config("spark.streaming.stopGracefullyOnShutdown", True)
    .master("local[*]")
    .getOrCreate()
)
```


```python
spark
```





    <div>
        <p><b>SparkSession - in-memory</b></p>

<div>
    <p><b>SparkContext</b></p>

    <p><a href="http://a485b40e9c91:4042">Spark UI</a></p>

    <dl>
      <dt>Version</dt>
        <dd><code>v3.3.0</code></dd>
      <dt>Master</dt>
        <dd><code>local[*]</code></dd>
      <dt>AppName</dt>
        <dd><code>read_from json</code></dd>
    </dl>
</div>

    </div>





```python
_schema = "customerId string, data struct<devices array<struct<deviceId string,measure string,temperature string>>>,  eventId string, eventOffset long, eventPublisher string, eventTime string"
```


```python
### Batch processing logic

#file_data_df = spark.read.format("json").option("schema", _schema).option("path", "inputs/file1.json").load()

### Streaming logic and configuration

spark.conf.set("spark.sql.streaming.schemaInference", True)

streaming_df = (
   spark
    .readStream
    .option("cleanSource", "archive")
    .option("sourceArchiveDir", "archive_dir")
    .option("maxFilesPerTrigger", 1)
    .format("json")
    .load("./inputs")
)
```


```python
# To allow automatic schemaInference while reading

```


```python
streaming_df.printSchema()
```

    root
     |-- customerId: string (nullable = true)
     |-- data: struct (nullable = true)
     |    |-- devices: array (nullable = true)
     |    |    |-- element: struct (containsNull = true)
     |    |    |    |-- deviceId: string (nullable = true)
     |    |    |    |-- measure: string (nullable = true)
     |    |    |    |-- status: string (nullable = true)
     |    |    |    |-- temperature: long (nullable = true)
     |-- eventId: string (nullable = true)
     |-- eventOffset: long (nullable = true)
     |-- eventPublisher: string (nullable = true)
     |-- eventTime: string (nullable = true)
    



```python
# file_data_df.show(truncate=False)
```


```python
from pyspark.sql.functions import explode, from_json, col

exploded_devices_df = (
    streaming_df
    .withColumn("devices", explode(streaming_df.data.devices))
)
```


```python
# exploded_devices_df.show()
```


```python
exploded_devices_df.printSchema()
```

    root
     |-- customerId: string (nullable = true)
     |-- data: struct (nullable = true)
     |    |-- devices: array (nullable = true)
     |    |    |-- element: struct (containsNull = true)
     |    |    |    |-- deviceId: string (nullable = true)
     |    |    |    |-- measure: string (nullable = true)
     |    |    |    |-- status: string (nullable = true)
     |    |    |    |-- temperature: long (nullable = true)
     |-- eventId: string (nullable = true)
     |-- eventOffset: long (nullable = true)
     |-- eventPublisher: string (nullable = true)
     |-- eventTime: string (nullable = true)
     |-- devices: struct (nullable = true)
     |    |-- deviceId: string (nullable = true)
     |    |-- measure: string (nullable = true)
     |    |-- status: string (nullable = true)
     |    |-- temperature: long (nullable = true)
    



```python
final_df = (
    exploded_devices_df
    .drop("data")
    .withColumn("deviceId", col("devices.deviceId"))
    .withColumn("measure", col("devices.measure"))
    .withColumn("status", col("devices.status"))
    .withColumn("temperature", col("devices.temperature"))
    .drop("devices")
    
)
```


```python
final_df.printSchema()
```

    root
     |-- customerId: string (nullable = true)
     |-- eventId: string (nullable = true)
     |-- eventOffset: long (nullable = true)
     |-- eventPublisher: string (nullable = true)
     |-- eventTime: string (nullable = true)
     |-- deviceId: string (nullable = true)
     |-- measure: string (nullable = true)
     |-- status: string (nullable = true)
     |-- temperature: long (nullable = true)
    



```python
# final_df.show()
```


```python
# Write the output to console sink to check the output

(final_df
 .writeStream
 .format("csv")
 .outputMode("append")
 .option("path", "output/device_data.csv")
 .option("checkpointLocation", "checkpoint_dir")
 .start()
 .awaitTermination())
```


```python

```
