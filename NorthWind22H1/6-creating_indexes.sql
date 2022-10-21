/* Purpose: Creating Index Objects in the database  Northwind22H1
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

/* Creating index - Syntax
1. create a clustered index on a table
	create object_type object_name on table_name (column_name)
	create clustered index index_name on table_name (column_name)

2. Create a non-clustered index on a table (base table) or a view (virtual table)
	create nonclustered index index_name on table_name (column_name)
*/
/* SQL Server Index Architecture and Design Guide
https://docs.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver15
*/

/* retrieve index information on table Sales.Customers */
execute sp_help 'Sales.Customers'
;
go

exec sp_helpindex 'Sales.Customers'
;
go

/* retrieve index information on table Sales.Orders */
execute sp_helpindex 'Sales.Orders'
;
go

/* using the system indexes table */
select *
from sys.indexes
;
go

select
	name,	-- name of the index. Name must be unique
	index_id,  -- the ID of the index: 0 --> heap, 1 --> clustered, >1 --> nonclustered
	type,	-- type of the index: 0 --> heap, 1 --> clustered, 2 --> nonclustered, 3 --> xml, 4 --> spatial index
	type_desc,	-- description of the index
	is_unique,	-- 1 --> unique, 0 --> index is not unique
	is_primary_key	-- 1 --> index is part of the primary key
from sys.indexes
where object_id = OBJECT_ID('Sales.[Order Details]')
;
go


/* check if indexes exist in the table HumanResources.Employees  */
execute sp_helpindex 'HumanResources.Employees'
;
go

/* create a nonclustered index, ncl_LastName, on the employee last name */
-- create nonclustered index index_name on schema_name.table_name (column_name)
create nonclustered index ncl_LastName on HumanResources.Employees (LastName)
;
go


/* remove the index, ncl_LastName, on the table HumanResources.Employees */
-- Syntax: drop index from_schema_name_table_name.index_name 
drop index HumanResources.Employees.ncl_LastName
;
go


/* retrieve index information on table Production.Products */
execute sp_helpindex 'Production.Products'
;
go
