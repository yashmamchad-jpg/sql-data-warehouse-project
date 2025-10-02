-- Create Database and Schemas
-- Script Purpose: This script creates a new database called "DATAWAREHOUSE".
-- The script sets-up three schemas Bronze, Silver, Gold.


CREATE DATABASE DATAWAREHOUSE;
GO

USE DATAWAREHOUSE;
GO

CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
  
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date NVARCHAR(50)
);


CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);



CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

CREATE TABLE bronze.erp_cust_AZ12(
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50)
);

CREATE TABLE bronze.erp_loc_A101(
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_G1V2(
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50),
);

-- Switch to the correct database
USE DATAWAREHOUSE;
GO

-- Ensure the schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO

-- Create or alter the procedure
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Loading crm_cust_info
        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        -- Loading crm_prd_info
        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        -- Loading crm_sales_details
        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM '/var/opt/mssql/data/datasets/source_crm/sales_details.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        -- Loading ERP tables
        TRUNCATE TABLE bronze.erp_cust_AZ12;
        BULK INSERT bronze.erp_cust_AZ12
        FROM '/var/opt/mssql/data/datasets/source_erp/cust_AZ12.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        TRUNCATE TABLE bronze.erp_px_cat_G1V2;
        BULK INSERT bronze.erp_px_cat_G1V2
        FROM '/var/opt/mssql/data/datasets/source_erp/px_cat_G1V2.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        TRUNCATE TABLE bronze.erp_loc_A101;
        BULK INSERT bronze.erp_loc_A101
        FROM '/var/opt/mssql/data/datasets/source_erp/loc_A101.csv'
        WITH
        (
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIRSTROW = 2
        );

        PRINT 'All tables loaded successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error encountered:';
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

-- Execute the procedure
EXEC bronze.load_bronze;

