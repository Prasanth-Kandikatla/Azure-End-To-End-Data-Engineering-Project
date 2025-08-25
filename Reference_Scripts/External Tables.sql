CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'a!bcd123@4'

CREATE DATABASE SCOPED CREDENTIAL credential_name
WITH IDENTITY = 'Managed Identity'
   

CREATE EXTERNAL DATA SOURCE source_silver
WITH (
    LOCATION = 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver',
    CREDENTIAL = credential_name
)

CREATE EXTERNAL DATA SOURCE source_gold
WITH (
    LOCATION = 'https://awstoragedatalakekp2499.dfs.core.windows.net/gold',
    CREDENTIAL = credential_name
)

CREATE EXTERNAL FILE FORMAT format_parquet 
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)


-----------------------
--CREATE EXTERNAL TABLE
-----------------------
CREATE EXTERNAL TABLE gold.extCalendar
WITH (
    LOCATION = 'extCalendar',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM serving.Calendar


SELECT * FROM gold.extCalendar
