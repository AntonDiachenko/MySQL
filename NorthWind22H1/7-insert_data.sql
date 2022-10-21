/* Purpose:  Inserting data into table objects in the database  Northwind22H1
	Script Date: April 7, 2022
	Developed by: Khattar Daou
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the Northwind database
-- Syntax: use database_name
use Northwind22H1
;
go -- includes end of the batch marker


/* 1. using insert clause 
Syntax: 
insert [into] schema_name.table_name [(column_list)]
values (value1, value2, ...)
;
go
*/


/* create table Contacts */ 
create table #MyContacts
(
	ContactID smallint  identity(1, 1) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	Address nvarchar(40) not null,
	Region nchar(2) null,
	constraint pk_Contacts primary key clustered (ContactID asc)
)
;
go

insert into #MyContacts (FirstName, LastName,  Address)
values ('John', 'Smith',  '125 Green Street')
;
go

select *
from #MyContacts
;
go



/* 2. using insert clause from another table 
Syntax:
insert [into] schema_name.table_name [(column_list)]
select (column_name_1, column_name_2, ...)
from schema_name.another_table_name
*/

insert into #MyContacts(FirstName, LastName,  Address)
select FirstName, LastName, Address
from HumanResources.Employees
where EmployeeId between 2 and 5
;
go

/* 3. Using Bulk insert clause
Syntax:
bulk insert schema_name.table_name
from 'path/filename.ext'
with 
(
	FirstRow = number_of_first_row,
	RowTerminator = '\n',
	FieldTerminator = ','
)
*/

bulk insert #MyContacts
from 'I:\_data_sources\contacts.txt'
with
(
	FirstRow = 2,
	FieldTerminator = ',',
		RowTerminator = '\n'
)
;
go

