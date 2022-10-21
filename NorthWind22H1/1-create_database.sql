/* Purpose: Creating the database NorthWind22H1
	script Date: April 5, 2022
	Developed by: Anton Diachenko
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the master database
-- Syntax: use database_name
use master
;
go -- includes end of the batch marker

/* Partial sysntax to create a database
create object_name object_name
create database database_name
*/

-- database name
-- create the northwind database

create database Northwind22H1
on primary
(
	-- 1) rows data logical filename
	name = 'Northwind22H1',
	-- 2) rows data initial filesize
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 8MB,
	-- 4) rows data maximum size
	maxsize = 500MB, --  or unlimited
	-- 5) rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NorthWind22H1.mdf'
)

--transaction log
log on
(
	-- 1) log logical filename
	name ='Northwind22H1_log',
	-- 2) log initial file size (1/4 the rows data file size)
	size = 3 MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log maximum size
	maxsize = 25MB,
	--5) log path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NorthWind22H1_log.ldf'
)
;
go

/* drop mydb1 database */
drop database MyDB1
;
go

/*increase the maximum size of the NorthWind22H1_log to 100MB */
use master;
go

alter database NorthWind22H1
	modify file
	(
		name = 'NorthWind22H1_log',
		maxsize = 100MB
	)
;
go

-- return the definition of NorthWind22H1 database using the system stored procedure
-- Syntax: execute stored_procedure_name [parameter_value]

execute sp_helpdb 'NorthWind22H1'
;
go

/* return the SQL Server version you are running */ 
select @@version as 'SQL Server Version',
@@SERVERNAME as 'Server Name'
;
go

/* using some of system T-SQL functions */

use Northwind22H1
;
go

select 
	USER_NAME() as 'User Name',
	DB_NAME() as 'Database Name'
;
go





