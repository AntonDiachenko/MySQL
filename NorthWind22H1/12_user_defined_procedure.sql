/* Creating User-Defined Stored Procedures in the database Northwind22H1
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


-- Partial Syntac: create procedure
-- Transact-SQL Syntax for Stored Procedures in SQL Server and Azure SQL Database  
  /*
CREATE [ OR ALTER ] { PROC | PROCEDURE } 
    [schema_name.] procedure_name 
    [ { @parameter [ type_schema_name. ] data_type }  ]   

AS 
	{ [ BEGIN ] 
			sql_statement [;] [ ...n ] 
		[ END ] 
	}  
[;]  
*/

/* create a procedure, HumanResources.getAllEmployeesSP, that returns the employee first name, last name, and title
*/
create procedure HumanResources.getAllEmployeesSP
as
	begin
		select EmployeeID, FirstName, LastName, Title
		from HumanResources.Employees
	end
;
go


/* call (execute) the HumanResources.getAllEmployeesSP */
execute HumanResources.getAllEmployeesSP 
;
go


/* create a procedure, HumanResources.getAllEmployeeByNameSP, that returns the employee first name, last name, and title, knowing (having) the employee number */
create procedure HumanResources.getAllEmployeeByNameSP
(
	-- declare parameter(s)
	-- @parameter_name as data_type [ = expression]
	@EmployeeID as int 
)
as
	begin
		select EmployeeID, FirstName, LastName, Title
		from HumanResources.Employees
		where EmployeeID = @EmployeeID
	end
;
go

/* testing proc HumanResources.getAllEmployeeByNameSP */
execute HumanResources.getAllEmployeeByNameSP @EmployeeID = 3
;
go

/* create a procedure, HumanResources.getAllEmployeeByTitleSP, that returns the employee full name, phone, and title, knowing the job title */
alter procedure HumanResources.getAllEmployeeByTitleSP
(
	-- declare parameter(s)
	-- @parameter_name as data_type [ = expression]
	@JobTitle as nvarchar(30)
)
as
	begin
		select concat_ws(' ', FirstName, LastName) as 'Full Name',
		HomePhone, Title
		from HumanResources.Employees
		where Title like @JobTitle
	end
;
go

/* testing proc HumanResources.getAllEmployeeByTitleSP */
execute HumanResources.getAllEmployeeByTitleSP @JobTitle = '%Sales Rep%'
;
go
