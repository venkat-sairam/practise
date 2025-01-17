# Databricks notebook source
class DataSource:

    def __init__(self, path:str):
        """
            assign the path variable to self.path
        """
        self.path = path

    def load_data(self):
        """
            function to load the data from the given filepath
        """
        raise ValueError("function not implemented....")

class CSV_DataSource(DataSource):

    def load_data(self):
        return (
            spark
            .read
            .format("csv")
            .option("header", True)
            .load(self.path)
        )

class Parquet_DataSource(DataSource):

    def load_data(self):
        return (
            spark
            .read
            .format("parquet")
            .load(self.path)
        )

class Delta_DataSource(DataSource):

    def load_data(self):
        return (
            spark
            .read
            .format("delta")
            .load(self.path)
        )

def get_data_source(file_type:str, file_path:str):
    if file_type == "csv":        
        return CSV_DataSource(file_path)
    elif file_type == "delta":
        return Delta_DataSource(file_path)
    elif file_type == 'parquet':
        return Parquet_DataSource(file_path)
    else:
        raise ValueError("file type not supported....")


# COMMAND ----------


