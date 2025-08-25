---------------
--Calendar
---------------
-- ============================================
-- 📄 Create a View: serving.Calendar
-- This view uses OPENROWSET to query data stored in Azure Data Lake Gen2.
-- It points to the 'Calendar' folder in the Silver layer and reads Parquet files.
-- This approach enables schema-on-read without requiring physical tables.
-- ============================================

CREATE VIEW serving.Calendar
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Calendar/',
        FORMAT = 'PARQUET'
    ) AS Query1;
GO


---------------
--Customers
---------------
CREATE VIEW serving.Customers
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Customers/',
        FORMAT = 'PARQUET'
    ) AS Query2
GO
   

--------------------
CREATE VIEW serving.Product_Categories
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Product_Categories/',
        FORMAT = 'PARQUET'
    ) AS Query3
GO
      

CREATE VIEW serving.Product_Subcategories
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Product_Subcategories/',
        FORMAT = 'PARQUET'
    ) AS Query4
GO

CREATE VIEW serving.Products
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Products/',
        FORMAT = 'PARQUET'
    ) AS Query5
GO
   
CREATE VIEW serving.Returns
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Returns/',
        FORMAT = 'PARQUET'
    ) AS Query6
GO

CREATE VIEW serving.Sales
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Sales/',
        FORMAT = 'PARQUET'
    ) AS Query7
GO

CREATE VIEW serving.Territories
AS
SELECT
    *
FROM 
    OPENROWSET(
        BULK 'https://awstoragedatalakekp2499.dfs.core.windows.net/silver/Territories/',
        FORMAT = 'PARQUET'
    ) AS Query8
GO


