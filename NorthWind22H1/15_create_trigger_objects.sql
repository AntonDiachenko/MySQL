/* Creating User-Defined Triggers in the database Northwind22H1
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
 

 
-- create trigger

/* SYNTAX:
create object_type schema_name.object_name
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table | view } 
{ FOR | AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] } 
as 
	sql statements

*/


/* create a trigger, Sales.NotifyCustomerChangesTr, that displays a message when anyone modifies on inserts data into the table Sales.Customers 
*/

create trigger Sales.NotifyCustomerChangesTr
on Sales.Customers
after update, insert
as
	raiserror('Customer data was modified.',
	10,	-- user severity
	1 -- state
	)
;
go

/* change the contact name for customer id 'ALFKI' from Maria Anders to
Margeret Davidson */
update Sales.Customers
set ContactName = 'Maria Anders'
where CustomerID = 'ALFKI'
;
go


/* create a trigger, HumanResources.CheckModifiedDateTR, that checks the modified date column value.
This trigger ensures that during the insert of a new department, or updating an existing department, the modified date is the current date. If it is not, the row will be updated and set to the current date and time.*/

-- create the table Departments
create table Departments
(
	DepartmentID int identity (1, 1) not null,
	DepartmentName nvarchar(40) not null,
	ModifiedDate datetime null,
	constraint pk_Departments primary key clustered (DepartmentID asc)
)
;
go


/* transfer the table Departments to HumanResources schema */
alter schema HumanResources transfer dbo.Departments
;
go


-- insert a new Department
insert into HumanResources.Departments(DepartmentName)
values ('TechNet')
;
go

select *
from HumanResources.Departments
;
go

/* create a trigger, HumanResources.CheckModifiedDateTR, that checks the modified date column value. This trigger ensures that during the insert of a new department, or updating an existing department, the modified date is the current date. If it is not, the row will be updated and set to the current date and time.*/

create trigger HumanResources.CheckModifiedDateTR
on HumanResources.Departments
for insert, update
as
	begin
		-- declare variables 
		-- declare @variable_name data_type [= expression]
		declare @ModifiedDate as datetime,
			@DepartmentID as int
		-- compute the returned value
		select @ModifiedDate = ModifiedDate,
			@DepartmentID = DepartmentID
		from inserted
		-- making decision (comparing the Modified Date with the cussrent Date)
		if (abs(dateDiff(day, @ModifiedDate, getDate() )) > 0) or (@ModifiedDate is null)
			begin
				-- set the modified date to the current date 
				update HumanResources.Departments
				set ModifiedDate = getDate()
				where DepartmentID = @DepartmentID
				print '***** The Date Was Modified. *****' 
			end
	end
;
go


select *
from HumanResources.Departments
;
go

/* change the department name of Department 1 to 'IT' */
update HumanResources.Departments
set DepartmentName = 'IT'
where DepartmentID = 1
;
go

/* add a new department (passed date) */
insert into HumanResources.Departments
values ('HR', '04/06/2020')
;
go


/* add a new department (future date) */
insert into HumanResources.Departments
values ('Sales', '11/26/2025')
;
go

/* add a new department (no modified date) */
insert into HumanResources.Departments (DepartmentName)
values ('Production')
;
go


/* Enable or Disable a trigger 
Syntax:
disable trigger schema_name.trigger_name on schema_name.table_name 

enable trigger schema_name.trigger_name on schema_name.table_name 
*/

disable trigger HumanResources.CheckModifiedDateTR 
	on HumanResources.Departments
;
go

/* add a new department (trigger is disabled) */
insert into HumanResources.Departments (DepartmentName)
values ('Shipping')
;
go
;
go


select *
from HumanResources.Departments
;
go






/* create a trigger, HumanResouces.getEmployeeDataChangedTR, that audits any changes applyied to Employee Data table 
*/

/* create EmployeeData table */
create table HumanResources.EmployeeData
(
	EmployeeID int identity(1, 1) not null,
	BankAccountNumber nchar(10) not null,
	Salary smallmoney not null,
	SocialInsuranceNumber nchar(11) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(30) not null,
	ManagerID int not null,
	constraint pk_EmployeeData primary key clustered (EmployeeID asc)
)
;
go

/* create AuditEmployeeData table */
create table HumanResources.AuditEmployeeData
(
	AuditLogID uniqueidentifier default newID() not null,
	LogType nchar(3) not null, -- new or old
	AuditEmployeeID int not null,
	AuditBankAccountNumber nchar(10) not null,
	AuditSalary smallmoney not null,
	AuditSocialInsuranceNumber nchar(11) not null,
	/* return the login name associated with the security identification number (SID) */
	AuditUser sysname default suser_name(),
	AuditModifiedDate datetime default getDate(),
	constraint pk_AuditEmployeeData primary key clustered (AuditLogID asc)
)
;
go



/* set the relationship between tables HumanResources.EmployeeData 
and HumanResources.AuditEmployeeData */
alter table HumanResources.AuditEmployeeData
	add constraint fk_AuditEmployeeData_EmployeeData foreign key (AuditEmployeeID) references HumanResources.EmployeeData (EmployeeID)
;
go
/* create a trigger, HumanResouces.getEmployeeDataChangedTR, that audits any changes applyied to Employee Data table 
*/

alter trigger HumanResources.getEmployeeDataChangedTR
on HumanResources.EmployeeData
for update
as
	begin
		-- audit EmployeeData old record
		insert into HumanResources.AuditEmployeeData
		(
			LogType, -- new or old
			AuditEmployeeID,
			AuditBankAccountNumber,
			AuditSalary,
			AuditSocialInsuranceNumber
		)
		select
			'old',
			del.EmployeeID,
			del.BankAccountNumber,
			del.Salary,
			del.SocialInsuranceNumber
		from deleted as del
		union
		select
			'new',
			ins.EmployeeID,
			ins.BankAccountNumber,
			ins.Salary,
			ins.SocialInsuranceNumber
		from inserted as ins
	end
;
go


select *
from HumanResources.EmployeeData
;
go


select *
from HumanResources.AuditEmployeeData
;
go

/* add a new record into table HumanResources.EmployeeData */
insert into HumanResources.EmployeeData
( 
	BankAccountNumber, 
	Salary,
	SocialInsuranceNumber,
	LastName,
	FirstName,
	ManagerID
)
values (
	'S-12345678',
	45000,
	'123-456-789',
	'Smith',
	'John',
	32
	)
;
go

/* increase John's salary to $47500 */
update HumanResources.EmployeeData
set Salary = 50000
where EmployeeID = 1
;
go


/* increase John's salary to $75000 */
update HumanResources.EmployeeData
set Salary = 75000
where EmployeeID = 1
;
go


/*
create a trigger, OrderDetailsInsertTr, that updates a column (UnitsInStock) 
in the Production.Products table, whenever a products is ordered (whenever a 
record is inserted into the order details table). 
When the insert occurs, it fires the OrderDetailsInsertTr trigger and reduces 
the quantity of the product placed in the order details. another words, 
the UnitsInStock in the Production.Products table will be calculated as 
UnitsInStock  = UnitsInStock - QuantityOrdered
*/

select *
from Production.Products
where ProductID = 1
;
go

select *
from Sales.[Order Details]
where OrderID = 10248
;
go

create trigger Sales.OrderDetailsInsertTr
on Sales.[Order Details]
for insert 
as
	update PP
	set PP.UnitsInStock = (PP.UnitsInStock - SOD.Quantity)
	from Production.Products as PP
		inner join Sales.[Order Details] as SOD
		on PP.ProductID = SOD.ProductID
;
go


-- disable constraint 
ALTER TABLE Production.Products  
NOCHECK CONSTRAINT CK_UnitsInStock
;   
GO 

insert into Sales.[Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (10248, 1, 48.99, 10, 0.0)

;
go

/* ********************************************************* */
CREATE TABLE Sales.Shippers2
(
	ShipperID int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new shipper
	CompanyName nvarchar(40) NOT NULL, -- Name of the shipping company
	Phone nvarchar(24) NOT NULL, -- Phone number includes country code and /or area code
	PostalCode nchar(7) null,
	CONSTRAINT pk_Shippers2 PRIMARY KEY CLUSTERED 
	(
		ShipperID ASC
	)
)
;
go

/* insert a new row into Shippers2 */
insert into Sales.Shippers2 (CompanyName, Phone, PostalCode)
values (upper('Live is Foods'), '(514) 555-4569', upper('h3t 3t3') )
;
go

select *
from Sales.Shippers2
;
go

/* create a trigger, Sales.toUpperCaseTr, that changes the lower case characters to upper case for the postal code */
create trigger Sales.toUpperCaseTr
on Sales.Shippers2
after insert, update
as
	begin
		update Sales.Shippers2
		set PostalCode = upper(PostalCode)
		where ShipperID
			in ( 
				select ShipperID 
				from inserted
			)
	end
;
go

-- insert a new record 
insert into Sales.Shippers2 (CompanyName, Phone, PostalCode)
values ('Green Food', '(514) 789-6541', 'h4t 3t3')
;
go

-- I:\_data_sources
-- import data from Shippers.txt
bulk insert Sales.Shippers2
from 'I:\_data_sources\Shippers.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ',',
	FIRE_TRIGGERS
)
;
go












-- I:\_data_sources
-- import data from Shippers.txt
bulk insert Sales.Shippers2
from 'I:\_data_source\Shippers.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ',',
	FIRE_TRIGGERS
)
;
go


/* create a check constraint oh the phone number */
alter table Sales.Shippers2
	with check
	add constraint ck_Phone_Shippers2 check
	(Phone like
		'(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
	or Phone like 
		'(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
)
;
go

