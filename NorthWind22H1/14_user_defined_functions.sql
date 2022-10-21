/* User-Defined T-SQL Functions in the database Northwind22H1
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


/* A User-Defined Function (UDF) is a Transactional-SQL (T-SQL) statements that returns parameters, perform an action, such as calculation, and returns the result of that action as a value. 
The return value can either be a scalar (single) or a table. */

/* 
SYNTAX:
	create function schema_name.function_name
	(
		[@parameter_name as data_type [ = expression],
		@parameter_name as data_type,
		...
		]
	)
	returns data_type
	as
		begin
			T-SQL statement goes here
			return value
		end
;
go
*/

/*
if OBJECT_ID('schema_name.object_name', 'object_type') is not null
	drop object_type object_name
	where object_type:
		'U' - Table 
		'V' - View
		'Fn' - function
*/

/* create a function, HumanResources.getEmployeeSeniorityFn, that returns the employee seniority.
drop the function if exists and re-createe it */

if OBJECT_ID('HumanResources.getEmployeeSeniorityFn', 'Fn') is not null
	drop function HumanResources.getEmployeeSeniorityFn
;
go

alter function HumanResources.getEmployeeSeniorityFn
(
	-- declare a parameter
	-- [@parameter_name as data_type [ = expression]
	@HireDate as datetime
)
returns int
as
	begin
		-- declare the returned variable
		-- @variable_name as data_type [ = expression]
		declare @Seniority as int

		-- compute the returned value
		select @Seniority = abs(datediff(year, @HireDate, getDate() ))
		
		-- return the result value to the function caller
		return @Seniority		
	end
;
go


	
-- testing HumanResources.getEmployeeSeniorityFn
select HumanResources.getEmployeeSeniorityFn('2000/03/25') as 'Seniority'
;
go

/* Return the employee seniority */
select
	EmployeeID,
	FirstName,
	LastName,
	HireDate,
	HumanResources.getEmployeeSeniorityFn(HireDate) as 'Seniority'
from HumanResources.Employees
-- where EmployeeID = 3
where title like '%Sales Rep%'