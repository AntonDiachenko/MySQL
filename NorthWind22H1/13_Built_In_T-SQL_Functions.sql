/* Unisng Built-In T-SQL Functions in the database Northwind22H1
Script Date: April 12, 2022
 Developed by: Khattar Daou
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the Northwind database
-- Syntax: use database_name

use Northwind22H1
;
go -- includes end of the batch marker


select
	OrderID as 'Order ID',
	OrderDate as 'Order Date',
	year(OrderDate) as ' Order Year',
	month(OrderDate) as 'Order Month',
	day(OrderDate) as 'Order Day',
	DatePart(year, OrderDate) as 'Year Date Part',
	DatePart(month, OrderDate) as 'Month Date Part',
	DatePart(day, OrderDate) as 'Day Date Part',
	DatePart(weekday, OrderDate) as 'Weekday Date Part',
	DatePart(DayOfYear, OrderDate) as 'Day of Year Date Part',
	DateName(weekday, OrderDate) as 'Day Name',
	EOMONTH(OrderDate) as 'End of Month'
from Sales.Orders
;
go



/* return all orders placed between 2020 and 2021 */
select OrderID, OrderDate
from Sales.Orders
-- where OrderDate between '1/1/2020' and '12/31/2021'
-- where year(OrderDate) between '2020' and '2021'
where year(OrderDate) in( '2020','2021')
;
go

-- some of the T-SQL logical functions
/* isNumeric(expression) - returns 1 when the input expression evaluates to a valid data type, otherwise it returns 0. */

/* return the list of employees and the postal code with numeric values */
select EmployeeID, FirstName, LastName, PostalCode
from HumanResources.Employees
where ISNUMERIC(PostalCode) = 1
;
go


/* IIF(expression) - Immediate If function that returns one ot two values depending on whether the boolean expression evaluates to true or false
SYNTAX: iif( (expression), 'true_value', 'false_value')
iif(gender = 'f'), 'Female', 'Male')
*/

/* return the value 'Low Price' if the product unit price is less than $50, otherwise - return 'High Price' */

select 
	PP.ProductID as 'Product ID',
	PP.ProductName as 'Product Name',
	PP.UnitPrice as 'Cost Price',
	iif( (PP.UnitPrice < 50), 'Low Price', 'High Price') as 'Price Status'
from Production.Products as PP
;
go

/* CASE expression evaluates a list of items and returns one of multiple result expression */
select
	PP.ProductID as 'Product ID',
	PP.ProductName as 'Product Name',
	PP.UnitPrice as 'Cost Price',
	'Price Range' =
	case 
		-- when condition then expression
		when (PP.UnitPrice = 0)  then 'Out of stock'
		when (PP.UnitPrice <= 50)  then 'Unit Price is under $50.'
		when (UnitPrice between 51 and 250) then 'Unit Price is Under $250.'
		when (UnitPrice between 251 and 1000) then 'Unit Price is Under $1000.'
		else 'Unit Price is over $1000'
	end

from Production.Products as PP
;
go

/* choose function returns values at the specified index from a list of values
SYNTAX: choose(index, value1, value2, ...) where index is one-based
*/
select choose(2, 'Manager', 'Developer', 'Programmer', 'Analyst', 'Tester')
;
go

/* replace category id value by a capital letter */
select CategoryName, CategoryID,
choose(CategoryID, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I') as 'Category'
from Production.Categories
;
go


/* some of the T-SQL string functions */
-- isNull function 
-- ISNULL ( check_expression , replacement_value ) 


select CustomerID, CompanyName,
(Address + ' ' + City + ' ' + isnull(Region, '') + ' ' + PostalCode + ' ' + Country) as 'Customer Address'
from Sales.Customers
;
go


-- concat function
select CustomerID, CompanyName,
concat(Address, ' ', City, ' ', isnull(Region, ''), ' ', PostalCode, ' ', Country) as 'Customer Address'
from Sales.Customers
;
go

-- coalesce function evalutes the arguments in order and returns the 
-- current value of the first expression that initially doesn't evaluate to null
select CustomerID, CompanyName,
concat_ws(' ', Address, City, coalesce(Region, '-'), PostalCode, Country) as 'Customer Address'
from Sales.Customers
;
go

/* 
	left([column_name], number)
	right([column_name], number)
	substring([column_name, start, length)
	lcase() deprecated| lower()
	ucase() deprecated | upper()
*/

/* return the identification number based on the first 3-character of employee first name, and 4-character of the last name. Return values as capital characters */

select upper(concat(left([FirstName],3), left([LastName], 4))) as 'ID', FirstName, LastName, HomePhone
from HumanResources.Employees
;
go

/* return the customer company name and the telephone area code in Canada and USA */
select
	CompanyName, City, Phone, SUBSTRING([Phone], 2, 3) as 'Area Code'
from Sales.Customers
where Country in('Canada', 'USA')
;
go

/* A table-valued function that splits a string into rows of substrings, based on a specified separator character.
STRING_SPLIT ( string , separator )  
*/

-- declare a variable
-- declare @variable_name as data_type [=expression]
declare @OrderID as nvarchar(max) = N'10248,10542,10731,10765,10812';
select value
from string_split(@orderID, ',')
;
go


/* some of T-SQL conversion functions */
/* Cast() and  Convert() functions allow you to convert one data type to another. 
If the data types are incompatible, cast will return an error
-- CAST Syntax:  
CAST ( expression AS data_type [ ( length ) ] )  
  
-- CONVERT Syntax:  
CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
*/

select getdate() as 'Get Date',  SYSDATETIME() as 'System Data and Time'
;
go


select CAST(SYSDATETIME() as int )
;
go

select cast('20210217' as int) as 'Cast to Int'
;
go

-- convert() function 
select 
-- CONVERT ( data_type [ ( length ) ] , expression [ , style ] )  
convert(char(10), current_timestamp, 103) as 'British/French Style',
convert(char(10), current_timestamp, 104) as 'German Style',
convert(char(10), current_timestamp, 101) as 'North America Style',
convert(char(10), current_timestamp, 105) as 'Italian Style'
;
go

-- PARSE ( string_value AS data_type [ USING culture ] )
select
parse('06/05/2020' as datetime using 'en-us') as 'US Date Style',
parse('06/05/2020' as datetime using 'fr-fr') as 'French Date Style',
parse('06/05/2020' as datetime using 'en-ca') as 'Canada English Date Style',
parse('06/05/2020' as datetime using 'fr-ca') as 'Canada French Date Style'
;
go


/*
Returns the result of an expression, translated to the requested data type, or null if the cast fails in SQL Server. Use TRY_PARSE only for converting from string to date/time and number types.
*/
-- TRY_PARSE ( string_value AS data_type [ USING culture ] )
select
try_parse('13/9/2021' as datetime using 'en-ca') as 'Canada English Date Style'
;
go

-- SQL Server supports up to 34 international languages */
execute sp_helplanguage
;
go


-- return the local language identifier id, use @@LangID */
select @@LANGID as 'Language ID'
;
go

-- switch to japanese language
-- switch to japanese language
set language 'Japanese'
;
go


declare @today as datetime
set @today = getDate()
select DATENAME(month, @today) as 'Month Name'
;
go

-- switch to italian language
set language 'Italian'
;
go


-- switch to simplified chinese language
set language 'Simplified Chinese'
;
go


execute sp_helplanguage 'Simplified Chinese'
;
go

set language 'English'
;
go

execute sp_helplanguage 'English'
;
go


/* concatenate a string to an order number */
select OrderID, isNull(N'SO' + convert(nvarchar(8), OrderID), N'*** ERROR ***') as 'Sales Order Number'
from Sales.Orders


