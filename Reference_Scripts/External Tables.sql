-- ============================================
-- 🔐 Step 1: Create a Master Key
-- This is required to store credentials securely in the database.
-- The password protects the encryption key.
-- ============================================
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'a!bcd123@4';
GO

-- ============================================
-- 🔐 Step 2: Create a Database Scoped Credential
-- This credential uses a Managed Identity to authenticate
-- against the Azure Data Lake (Gen2) storage.
-- ============================================
CREATE DATABASE SCOPED CREDENTIAL credential_name
WITH IDENTITY = 'Managed Identity';
GO

-- ============================================
-- 🌐 Step 3: Create External Data Sources
-- These define the locations of the silver and gold layers
-- in the Azure Data Lake, which will be used to read/write data.
-- ============================================
CREATE EXTERNAL DATA SOURCE source_silver
WITH (
    LOCATION = 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver',
    CREDENTIAL = credential_name
);
GO

CREATE EXTERNAL DATA SOURCE source_gold
WITH (
    LOCATION = 'https://awstoragedatalakekp2499.dfs.core.windows.net/gold',
    CREDENTIAL = credential_name
);
GO

-- ============================================
-- 📦 Step 4: Define External File Format
-- This specifies that files are in Parquet format using Snappy compression.
-- Used when writing or reading external tables.
-- ============================================
CREATE EXTERNAL FILE FORMAT format_parquet 
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
GO

-- ============================================
-- 🪙 Step 5: Create an External Table in the Gold Layer
-- This external table is created using CETAS (Create External Table As Select).
-- It materializes data from the 'serving.Calendar' view
-- into a Parquet file in the 'gold/extCalendar' path.
-- ============================================
CREATE EXTERNAL TABLE gold.extCalendar
WITH (
    LOCATION = 'extCalendar', -- Folder path under the 'gold' container
    DATA_SOURCE = source_gold, -- External source pointing to gold layer
    FILE_FORMAT = format_parquet -- Uses defined Parquet format
)
AS
SELECT * FROM serving.Calendar;
-- This query pulls data from the serving layer (view) and writes to external storage as a table.
GO



-- Check the external table by using the below command
-- SELECT * FROM gold.extCalendar
