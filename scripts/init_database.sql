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
    prd_cost NVARCHAR(50),
    prd_line NVARCHAR(50),
    prd_start_dt NVARCHAR(50),
    prd_end_dt NVARCHAR(50)
);



CREATE TABLE bronze.crm_sales_details(
    sls_ord_num INT,
    sls_prd_key NVARCHAR(50),
    sls_cust_id NVARCHAR(50),
    sls_order_dt NVARCHAR(50),
    sls_ship_dt NVARCHAR(50),
    sls_due_dt NVARCHAR(50),
    sls_sales NVARCHAR(50),
    sls_quantity NVARCHAR(50),
    sls_price NVARCHAR(50)
);

CREATE TABLE bronze.erp_cust_AZ12(
    CID INT,
    BDATE NVARCHAR(50),
    GEN NVARCHAR(50)
);

CREATE TABLE bronze.erp_loc_A101(
    CID INT,
    CNTRY NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_G1V2(
    ID INT,
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50),
);
