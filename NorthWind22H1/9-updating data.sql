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


/* Update achema_name.table_name
	set column_name = expression
	where condition
*/


/* update Order Date, Required Date, and Shipped Date as follow:
1996 --> 2020
1997 --> 2021
1998 --> 2022
by adding 24 years 
*/

/* Built-In T-SQL Functions 
DateAdd(DatePart, number, date_to_update)
where DataPart: year, month, day, hour, minute, ... )
*/

-- 1. update the order date
update Sales.Orders
set OrderDate = DateAdd(year, 24, OrderDate)
-- where condition
;
go

-- 2. update the required date
update Sales.Orders
set RequiredDate = dateAdd(year, 24, RequiredDate)
-- where condition
;
go

-- 3. update the shipping date
update Sales.Orders
set ShippedDate = dateAdd(year, 24, ShippedDate)
-- where condition
;
go

select *
from Sales.Orders
;
go


/* display employyes data */
select *
from HumanResources.Employees
;
go

/* update the birth date of all employees by adding 34 years */
update HumanResources.Employees
set BirthDate = dateadd(year, 34, BirthDate)
-- where condition
;
go


-- In-Class Activity
/* Adjust the employee HireDate, so that the seniority value becomes as follow:
Employee ID	Seniority
===========	=========
1			8
2			8
3			7
4			6		
5			5
6			4
7			3
8			2
9			1
*/


/* calculate the employee seniority using the built-in function DateDiff.
in MySQL 
DateDiff(end_date, start_date)

in SQL Server
DATEDIFF ( datepart , start_date , end_date )
where DataPart: year, month, day, hour, minute, ... )
*/


select EmployeeID, FirstName, LastName,
DATEDIFF(year, HireDate, GETDATE() ) as 'Siniority'
from HumanResources.Employees
;
go

/* update the HireDate for EmployeeID 1 and 2 */
update HumanResources.Employees
set HireDate = DateAdd(year, 22, HireDate)
where EmployeeID in(1, 2)
;
go

/* update the HireDate for EmployeeID 3  */
update HumanResources.Employees
set HireDate = DateAdd(year, 23, HireDate)
where EmployeeID = 3
;
go

/* update the HireDate for EmployeeID 4 */
update HumanResources.Employees
set HireDate = DateAdd(year, 23, HireDate)
where EmployeeID = 4
;
go


-- Employee # 5
update HumanResources.Employees
set HireDate = DateAdd(year, 24, HireDate)
where EmployeeID = 5
;
go

-- Employee # 6
update HumanResources.Employees
set HireDate = DateAdd(year, 25, HireDate)
where EmployeeID = 6
;
go

-- Employee # 7
update HumanResources.Employees
set HireDate = DateAdd(year, 25, HireDate)
where EmployeeID = 7
;
go

-- Employee # 8
update HumanResources.Employees
set HireDate = DateAdd(year, 26, HireDate)
where EmployeeID = 8
;
go

-- Employee # 9
update HumanResources.Employees
set HireDate = DateAdd(year, 27, HireDate)
where EmployeeID = 9
;
go


select EmployeeID, FirstName, LastName,
dateDiff(year, HireDate, getDate() ) as 'Seniority'
from HumanResources.Employees
;
go







