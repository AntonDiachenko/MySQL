/* Purpose: Creating view objects in the database Northwind22H1
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


/* 1. create the contact customer view (Sales.ContactNameView) that contains the contact name and contact title */

if OBJECT_ID('Sales.ContactNameView', 'V') is not null
	drop view Sales.ContactNameView
;
go

create view Sales.ContactNameView
as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle
	from Sales.Customers as SC
;
go

select *
from Sales.ContactNameView
order by CompanyName asc
;
go

/* 2. modify the Sales.ContactNameView and add the Phone, and Country */
alter view Sales.ContactNameView
as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle, SC.Phone, SC.Country
	from Sales.Customers as SC
;
go

select *
from Sales.ContactNameView
where CustomerID = 'ALFKI'
order by CompanyName asc
;
go

/* return the definition of the Sales.ContactNameView view */
execute sp_helptext 'Sales.ContactNameView'
;
go

/* calculate the subtotal of each order. Create this view and save it as getOrderSubtotalView.
Subtotal = unit price x quantity - discount
*/

create view Sales.getOrderSubtotalView
as
	select SOD.OrderID, SOD.ProductID, SOD.UnitPrice, SOD.Quantity, SOD.Discount,
	sum(convert(smallmoney, ((SOD.UnitPrice * SOD.Quantity) * (1 - SOD.Discount)  ) )) as 'Subtotal'	
	from Sales.[Order Details] as SOD
	-- where SOD.OrderID = 10248
	group by SOD.OrderID, SOD.ProductID, SOD.UnitPrice, SOD.Quantity, SOD.Discount	
;
go

select *
from Sales.getOrderSubtotalView
where OrderID = 10248
;
go

/* return the definition of the Sales.ContactNameView view */
execute sp_helptext 'Sales.getOrderSubtotalView'
;
go



/* calculate the total of each order. Create this view and save it as getOrderTotalView.
Subtotal = unit price x quantity - discount
*/

alter view Sales.getOrderSubtotalView
with encryption
as 
	select SOD.OrderID, 
	sum(convert(smallmoney, ((SOD.UnitPrice * SOD.Quantity) * (1 - SOD.Discount)  ) )) as 'Total'
	from Sales.[Order Details] as SOD
	group by SOD.OrderID
;
go


/* return the definition of the Sales.ContactNameView view */
execute sp_helptext 'Sales.getOrderSubtotalView'
;
go



/* join tables
Syntax:
 
1) inner join
select T1.column_name, T2.column_name 
from table1 as T1 inner join table2 as T2
	on table1.pk_colum = table2.fk_column

2) outer join
select T1.column_name, T2.column_name 
from table1 as T1 left outer join table2 as T2
	on table1.pk_colum = table2.fk_column

*/


/* create a view, Sales.getProductListView, that returns the customer company name, the product name */

create view Sales.getProductListView
as
	select 
		SC.CompanyName as 'Company Name' , PP.ProductName as 'Product Name'
	from Sales.Customers as SC 
		inner join Sales.Orders as SO
			on SC.CustomerID = SO.CustomerID
		inner join Sales.[Order Details] as SOD
			on SO.OrderID = SOD.OrderID
		inner join Production.Products as PP
			on SOD.ProductID = PP.ProductID
;
go


/* return customers (company name) who placed orders (OrderID) in 2022 */
select SC.CompanyName as 'Company', SO.OrderID as 'Order'
from Sales.Customers as SC
	inner join Sales.Orders as SO
		on SC.CustomerID = SO.CustomerID
-- where SO.OrderDate between '1/1/2022' and '12/31/2022'
-- where year(SO.OrderDate) = '2022'
;
go


/* return customers (company name) who did not placed orders (OrderID) in 2022 */
select SC.CompanyName as 'Company', SO.OrderID as 'Order'
from Sales.Customers as SC
	left outer join Sales.Orders as SO
		on SC.CustomerID = SO.CustomerID
-- where SO.OrderDate between '1/1/2022' and '12/31/2022'
-- where year(SO.OrderDate) = '2022' 
;
go
