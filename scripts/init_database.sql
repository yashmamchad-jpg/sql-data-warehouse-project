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
    cst_create_date NVARCHAR(50),

);
