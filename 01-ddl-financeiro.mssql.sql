---------------------------------------------------------------------
-- Script that creates the sample database TSQLV3
--
-- Supported versions of SQL Server: 2008, 2008 R2, 2012, 2014, Microsoft Azure SQL Database
--
-- Last updated: 20190909
--
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Create empty database TSQLV3
---------------------------------------------------------------------

-- For on-premises SQL Server use the steps in section A and then proceed to section C
-- For SQL Azure use the steps in section B and then proceed to section C

---------------------------------------------------------------------
-- Section A - for on-premises SQL Server only
---------------------------------------------------------------------

-- 1. Connect to your on-premises SQL Server instance, master database

-- 2. Run the following code to create an empty database called TSQLV3
USE master;

-- Drop database
IF DB_ID(N'TSQLV3') IS NOT NULL DROP DATABASE TSQLV3;

-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR(N'Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE TSQLV3;
GO

USE TSQLV3;
GO

-- 1. Highlight the remaining code in the script file and execute

---------------------------------------------------------------------
-- Create Schemas
---------------------------------------------------------------------

CREATE SCHEMA HR AUTHORIZATION dbo;
GO
CREATE SCHEMA Production AUTHORIZATION dbo;
GO
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO
CREATE SCHEMA Stats AUTHORIZATION dbo;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

-- Create table HR.Employees
CREATE TABLE HR.Employees
(
  empid           INT          NOT NULL IDENTITY,
  lastname        NVARCHAR(20) NOT NULL,
  firstname       NVARCHAR(10) NOT NULL,
  title           NVARCHAR(30) NOT NULL,
  titleofcourtesy NVARCHAR(25) NOT NULL,
  birthdate       DATE         NOT NULL,
  hiredate        DATE         NOT NULL,
  address         NVARCHAR(60) NOT NULL,
  city            NVARCHAR(15) NOT NULL,
  region          NVARCHAR(15) NULL,
  postalcode      NVARCHAR(10) NULL,
  country         NVARCHAR(15) NOT NULL,
  phone           NVARCHAR(24) NOT NULL,
  mgrid           INT          NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid),
  CONSTRAINT FK_Employees_Employees FOREIGN KEY(mgrid)
    REFERENCES HR.Employees(empid),
  CONSTRAINT CHK_birthdate CHECK(birthdate <= CAST(SYSDATETIME() AS DATE))
);