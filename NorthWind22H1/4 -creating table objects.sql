/* Purpose: Creating table objects in the database Northwind22H1
	Script Date: April 6, 2022
	Developed by: Khattar Daou
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the Northwind database
-- Syntax: use database_name
use Northwind22H1
;
go -- includes end of the batch marker

/* Consider the following facts when you create tables in SQL Server. You can have up to:
• two billions tables per database
• 1024 columns per table
• 8092 bytes per row (this does not apply to image and text data types)
*/


/* The following script must be used only during the development process and NOT on the production database. */

select *
from sys.all_objects
;
go


/* check if the object (table, view, ...) exists then delete from the database using the drop command.
NOTE: Only the the development environment, NOT Production database 
*/

-- U = Table (user-defined)
if object_ID('Sales.Customers', 'U') is not null
    drop table Sales.Customers
;
go

/* ***** Table No. 1 - Sales.Customers ***** */
create table Sales.Customers
(
    -- column_name data_type constraint(s)
    CustomerID nchar(5) not null, -- based on customer name
    CompanyName nvarchar(40) not null,
    ContactName nvarchar(30) null,
    ContactTitle nvarchar(30) null,
    Address nvarchar(60) not null,  -- Street Number and Street Name only
    City nvarchar(15) not null,
    Region nvarchar(15) not null,   -- Province or State
    PostalCode nvarchar(10) not null,
    Country nvarchar(15) not null,
    Phone nvarchar(24) not null,    -- Phone number includes country code and / or area code
    Fax nvarchar(24) not null,    -- Phone number includes country code and / or area code
    Email nvarchar(60) not null,
    Website nvarchar(60) null,
    constraint pk_Customers primary key clustered (CustomerID asc)
)
;
go

/* return the definition of the database Northwind22H1 */
execute sp_helpdb 'Northwind22H1'
;
go

/* return the definition (structure) of the table Sales.Customers */
exec sp_help 'Sales.Customers'

/* Creates an identity column in a table. The IDENTITY property has the following syntax:
	IDENTITY [ (seed , increment) ]  

	where 
	? seed Is the value that is used for the very first row loaded into the table
	? increment Is the incremental value that is added to the identity value of the previous row that was loaded.
	You must specify both the seed and increment or neither. If neither is specified, the default is (1,1).


	SET IDENTITY_INSERT [ [ database_name . ] schema_name . ] table_name { ON | OFF }

For example, set identity_insert Sales.Shippers2 on 
;
*/


/* ***** Table No. 2 - Sales.Orders ***** */
if object_ID('Sales.Orders', 'U') is not null
    drop table Sales.Orders
;
go


create table Sales.Orders
(
    OrderID int identity(1, 1) not null,   -- auto-generated number assigned to a new order
    CustomerID nchar(5) not null,       -- foreign key references to Customers table
    EmployeeID int not null,            -- foreign key references to Employees table
    OrderDate datetime2 not null,
    RequiredDate datetime2 not null,
    ShippedDate datetime2 null,
    ShipVia int null,                   -- foreign key references to Shippers table 
    Freight smallmoney null,
    ShipName nvarchar(40) null,
    ShipAddress nvarchar(60) null,
    ShipCity nvarchar(15) null,
    ShipRegion nvarchar(15) null,
    ShipPostalCode nvarchar(10) null,
    ShipCountry nvarchar(15) null,
    constraint pk_Orders primary key clustered (OrderID asc)
)
;
go


/***** Table No. 3 - Production.Products *****/
if OBJECT_ID('Production.Products', 'U') is not null
	drop table Production.Products
;
go

CREATE TABLE Production.Products
(
	ProductID int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to each new product
	ProductName nvarchar(40) NOT NULL,
	SupplierID int NOT NULL, -- foreign key (Supplier ID in Production.Suppliers)
	CategoryID int NOT NULL, -- foreign key (categoryID in Production.Categories)
	QuantityPerUnit nvarchar(20) NULL,  -- (e.g., 24-count case, 1 liter bottle)
	UnitPrice smallmoney NULL, -- cost price
	UnitsInStock smallint NULL,
	UnitsOnOrder smallint NULL,
	ReorderLevel smallint NULL, -- Minimum units to maintain in stock
	Discontinued bit NOT NULL, -- Yes means item is no longer available
	CONSTRAINT pk_Products PRIMARY KEY CLUSTERED 
	(
		ProductID ASC
	) 
)
;
go

/***** Table No. 4 - Sales.[Order Details] *****/
if OBJECT_ID('Sales.[Order Details]', 'U') is not null
	drop table Sales.[Order Details]
;
go

create table Sales.[Order Details]
(
	OrderID int not null, -- foreign key (OrderID in Sales.Orders)
	ProductID int not null, -- foreign key (ProductID in Production.Products)
	UnitPrice smallmoney not null, -- selling price
	Quantity smallint not null,
	Discount real not null,
	constraint pk_Order_Details primary key clustered 
		( -- composite primary key
			OrderID asc,
			ProductID asc
		)
)
;
go



/***** Table No. 5 - Production.Suppliers *****/
if OBJECT_ID('Production.Suppliers', 'U') is not null
	drop table Production.Suppliers
;
go

CREATE TABLE Production.Suppliers
(
	SupplierID int identity(1,1) NOT NULL, -- auto-generated number assigned to a new supplier
	CompanyName nvarchar(40) NOT NULL,
	ContactName nvarchar(30) NULL,
	ContactTitle nvarchar(30) NULL,
	Address nvarchar(60) NOT NULL, -- Street Number and Street Name, or Post-office box
	City nvarchar(15) NOT NULL,
	Region nvarchar(15) NOT NULL, -- State or Province
	PostalCode nvarchar(10) NOT NULL,
	Country nvarchar(15) NOT NULL,
	Phone nvarchar(24) NOT NULL, -- Phone number includes country code and /or area code
	Fax nvarchar(24) NULL, -- Fax number includes country code and /or area code
	HomePage nvarchar(60) NULL, -- Supplier URL
	Email nvarchar(60) NOT NULL, 
	CONSTRAINT pk_Suppliers PRIMARY KEY CLUSTERED 
	(
		SupplierID ASC
	)
)
;
go

/***** Table No. 6 - Production.Categories *****/
if OBJECT_ID('Production.Categories', 'U') is not null
	drop table Production.Categories
;
go

CREATE TABLE Production.Categories
(
	CategoryID int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new category
	CategoryName nvarchar(15) NOT NULL,
	Description nvarchar(250) NULL,
	Picture varbinary(max) NULL,  -- a picture representing the food category
	CONSTRAINT pk_Categories PRIMARY KEY CLUSTERED 
		(
			CategoryID ASC
		)
)
; 
go


/***** Table No. 7 - Sales.Shippers *****/
if OBJECT_ID('Sales.Shippers', 'U') is not null
	drop table Sales.Shippers
;
go


CREATE TABLE Sales.Shippers
(
	ShipperID int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new shipper
	CompanyName nvarchar(40) NOT NULL, -- Name of the shipping company
	Phone nvarchar(24) NOT NULL, -- Phone number includes country code and /or area code
	CONSTRAINT pk_Shippers PRIMARY KEY CLUSTERED 
	(
		ShipperID ASC
	)
)
;
go


/***** Table No. 8 - HumanResources.Employees  *****/
if OBJECT_ID('HumanResources.Employees', 'U') is not null
	drop table HumanResources.Employees
;
go


CREATE TABLE HumanResources.Employees
(
	EmployeeID int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new employee
	LastName nvarchar(20) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	Title nvarchar(30) NULL, -- job title
	TitleOfCourtesy nvarchar(25) NULL, -- e.g. Mr., Ms., Dr., Prof, ...
	BirthDate datetime2 NOT NULL,
	HireDate datetime2 NOT NULL,
	Address nvarchar(60) NOT NULL, -- Only Street Number and Street Name
	City nvarchar(15) NOT NULL,
	Region nvarchar(15) NOT NULL, -- State or Province
	PostalCode nvarchar(10) NOT NULL,
	Country nvarchar(15) NOT NULL,
	HomePhone nvarchar(24) NOT NULL,
	Extension nvarchar(4) NULL, -- work phone extension
	Photo varbinary(max) NULL,
	Notes nvarchar(250) NULL,
	ReportsTo int NULL, -- Foreign Key to the same Employees table 
	DepartmentID smallint NULL, -- foreign key (DepartmentID in Departments)
	CONSTRAINT pk_Employees PRIMARY KEY CLUSTERED 
	(
		EmployeeID ASC
	)
)
;
go

/***** Table No. 9 - HumanResources.Region  *****/
if OBJECT_ID('HumanResources.Region', 'U') is not null
	drop table HumanResources.Region
;
go

CREATE TABLE HumanResources.Region
( 
	RegionID int NOT NULL ,
	RegionDescription nvarchar (50) NOT NULL,
	constraint pk_Region primary key clustered (RegionID asc)
) 
;
GO

/***** Table No. 10 - HumanResources.Territories  *****/
if OBJECT_ID('HumanResources.Territories', 'U') is not null
	drop table HumanResources.Territories
;
go


CREATE TABLE HumanResources.Territories 
(
	TerritoryID nchar (2) NOT NULL ,
	TerritoryDescription nvarchar (50) NOT NULL ,
    RegionID int NOT NULL, -- Foreign Key (RegionID in HumanResources.Region)
	constraint pk_Territories primary key clustered (TerritoryID asc)
) 
;
GO


/* State, Province, and Territory Codes for the United States and Canada
http://apps.cybersource.com/library/documentation/dev_guides/SmallBusiness/Intershop_NT/html/appC.html
*/


/***** Table No. 11 - HumanResources.EmployeeTerritories  *****/
if OBJECT_ID('HumanResources.EmployeeTerritories', 'U') is not null
	drop table HumanResources.EmployeeTerritories
;
go

CREATE TABLE HumanResources.EmployeeTerritories
(
	EmployeeID int NOT NULL, -- Foreign Key (EmployeeID in HumanResources.Employees table)
	TerritoryID nchar(2) NOT NULL, -- Foreign Key (TerritoryID in Territories table)
	constraint pk_EmployeeTerritories primary key clustered 
	( -- composite primary key
		EmployeeID asc,
		TerritoryID asc
	)
) 
;
go


/***** Table No. 12 - Sales.CustomerCustomerDemo  *****/
if OBJECT_ID('Sales.CustomerCustomerDemo', 'U') is not null
	drop table Sales.CustomerCustomerDemo
;
go

CREATE TABLE Sales.CustomerCustomerDemo
(
	CustomerID nchar(5) not null, -- Foreign Key (CustomerID in Customers table)
	CustomerTypeID nvarchar(10) not null, -- Foreign Key (CustomerTypeID in CustomerDemographics table)
	CONSTRAINT pk_CustomerCustomerDemo PRIMARY KEY  CLUSTERED 
	(	-- composite primary key
		CustomerID asc,
		CustomerTypeID asc
	) 
)
;
GO


/***** Table No. 13 - Sales.CustomerDemographics  *****/
if OBJECT_ID('Sales.CustomerDemographics', 'U') is not null
	drop table Sales.CustomerDemographics
;
go

CREATE TABLE Sales.CustomerDemographics
( 
	CustomerTypeID nvarchar(10) not null,
	CustomerDesc nvarchar(250) not null,
	CONSTRAINT pk_CustomerDemographics PRIMARY KEY  CLUSTERED 
	(
		CustomerTypeID asc
	) 
)
;
GO

/* display user-defined table objects */

-- in schema Production
execute sp_tables
@table_owner = 'Production',
@table_qualifier = 'Northwind22H1'
;
go

-- in schema HumanResources
execute sp_tables
@table_owner = 'HumanResources',
@table_qualifier = 'Northwind22H1'
;
go

-- in schema Sales
execute sp_tables
@table_owner = 'Sales',
@table_qualifier = 'Northwind22H1'
;
go


-- in schema Person
execute sp_tables
@table_owner = 'Person',
@table_qualifier = 'Northwind22H1'
;
go

-- in schema Purchasing
execute sp_tables
@table_owner = 'Purchasing',
@table_qualifier = 'Northwind22H1'
;
go

 