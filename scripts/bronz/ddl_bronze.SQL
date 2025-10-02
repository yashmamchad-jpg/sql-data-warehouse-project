USE DATAWAREHOUSE;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY
    SET NOCOUNT ON;

    PRINT '#################################################################################';
    PRINT 'Loading Bronze Layer';
    PRINT '#################################################################################';

    PRINT '*********************************************************************************';
    PRINT 'Loading CRM Tables';
    PRINT '*********************************************************************************';


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_cust_info;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.crm_cust_info';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.crm_cust_info';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.crm_cust_info
    FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_prd_info;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.crm_prd_info';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.crm_prd_info';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.crm_prd_info
    FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_sales_details;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.crm_sales_details';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.crm_sales_details';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.crm_sales_details
    FROM '/var/opt/mssql/data/datasets/source_crm/sales_details.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'
    

    PRINT '*********************************************************************************';
    PRINT 'Loading ERP Layer';
    PRINT '*********************************************************************************';


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_cust_AZ12;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.erp_cust_AZ12';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.erp_cust_AZ12';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.erp_cust_AZ12
    FROM '/var/opt/mssql/data/datasets/source_erp/cust_AZ12.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_px_cat_G1V2;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.erp_px_cat_G1V2';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.erp_px_cat_G1V2';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.erp_px_cat_G1V2
    FROM '/var/opt/mssql/data/datasets/source_erp/px_cat_G1V2.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'


    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_loc_A101;
    PRINT '=================================================================================';
    PRINT 'Truncating: bronze.erp_loc_A101';
    PRINT '=================================================================================';
    PRINT '---------------------------------------------------------------------------------';
    PRINT 'Inserting: bronze.erp_loc_A101';
    PRINT '---------------------------------------------------------------------------------';
    BULK INSERT bronze.erp_loc_A101
    FROM '/var/opt/mssql/data/datasets/source_erp/loc_A101.csv'
    WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
    SET @end_time = GETDATE();
    PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'


    END TRY
    BEGIN CATCH
    PRINT '============================================================'
    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
    PRINT 'Error Message' + ERROR_MESSAGE();
    PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
    PRINT '============================================================'
    END CATCH

    PRINT 'All tables loaded successfully.';
    
END;
GO

-- Execute the procedure
EXEC bronze.load_bronze;
GO
