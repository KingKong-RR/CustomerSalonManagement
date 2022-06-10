-- =============================================
-- Create database For Customer Salon Management
-- =============================================
USE master
GO

-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'<CustomerSalonManagementDB, sysname, CustomerSalonManagementDB>'
)
DROP DATABASE Database_Name, sysname, Database_Name
GO

CREATE DATABASE Database_Name, sysname, Database_Name
GO