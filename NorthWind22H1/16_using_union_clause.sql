/* Using Union clause in the database Northwind22H1
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

 
 /* return the list of customers in Canada */
select
	CompanyName, Address, City, Region, PostalCode, Country, 'Customer' as 'Status'
from Sales.Customers
where Country = 'Canada'

union -- union all
/* 
 • The number and the order of the columns must be the same in all queries.
 • The data types must be compatible.
*/
/* return the list of Suppliers in Canada */
select
	CompanyName, Address, City, Region, PostalCode, Country, 'Supplier' as 'Status'
from Purchasing.Suppliers
where Country = 'Canada'

select *
from Sales.Shippers
;
go

select *
from HumanResources.Employees

select ShipperID, CompanyName, Phone
from Sales.Shippers
union
select EmployeeID, LastName, HomePhone
from HumanResources.Employees


/* ********************************************************* */
