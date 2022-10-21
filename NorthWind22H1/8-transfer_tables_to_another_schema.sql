/* Purpose: Transfering tables from one schema to another
 in the database Northwind21H1
Script Date: April 08, 2022
Developed by: Khattar Daou
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the Northwind database
-- Syntax: use database_name

use Northwind22H1
;
go -- includes end of the batch marker


/* Syntax to transfer a table from one schema to another
alter schema to_schema_name TRANSFER from_schema_name.table_name
*/

/***** Table No. 1 - Sales.Customers ****/
alter schema Sales transfer dbo.Customers
;
go

/***** Table No. 2 - Sales.Orders ****/ 
alter schema Sales transfer dbo.Orders
;
go

/***** Table No. 3 - Production.Products ****/ 
alter schema Production transfer dbo.Products
;
go

/***** Table No. 4 - Sales.[Order Details] ****/ 
alter schema Sales transfer dbo.[Order Details]
;
go

/***** Table No. 5 - Production.Suppliers ****/
alter schema Purchasing transfer dbo.Suppliers
;
go

/***** Table No. 6 - Production.Categories ****/ 
alter schema Production transfer dbo.Categories
;
go

/***** Table No. 7 - Sales.Shippers ****/
alter schema Sales transfer dbo.Shippers
;
go

/***** Table No. 8 - HumanResources.Employees ****/
alter schema HumanResources transfer dbo.Employees
;
go


/***** Table No. 9 - HumanResources.Region ****/
alter schema HumanResources transfer dbo.Region
;
go

/***** Table No. 10 - HumanResources.Territories ****/
alter schema HumanResources transfer dbo.Territories
;
go


/***** Table No. 11 - HumanResources.EmployeeTerritories ****/
alter schema HumanResources transfer dbo.EmployeeTerritories
;
go

/***** Table No. 12 - Sales.CustomerCustomerDemo ****/
alter schema Sales transfer dbo.CustomerCustomerDemo
;
go

/***** Table No. 13 - Sales.CustomerGeographics ****/
alter schema Sales transfer dbo.CustomerDemographics
;
go



