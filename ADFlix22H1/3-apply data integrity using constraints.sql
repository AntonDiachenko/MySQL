/* Purpose: apply data integrity using constraint types in Flix database */
/* Script Date: March 30, 2022
Developed by Anton Diachenko
*/

 -- switch to Flix database
 -- Syntax: use database_name;
use ADFlix22H1
; 


/* 
Integrity types:
1. Column (Domain) integrity
2. Row (Entity) integrity
3. Referential (between two tables or two columns within the same table) integrity
*/

/* Constraint types
Constraint Name Prefix 		Syntax							Example
---------------  -----		------							--------
1. Primary key    pk_		pk_table_name					pk_Customers   |    pk_CustomerID_Customers
2. Foreign Key    fk_		fk_table_name1_table_name2		fk_Orders_Customers
3. Unique 		  uq_		uq_column_name_table_name		uq_CompanyName_Suppliers
4. Default		  df_		df_column_name_table_name		df_City_Customers
5. Check 		  ck_		ck_column name_table_name		ck_Quantity_Products (Quantity	> 0)
							ck_column_name1_column_name2	ck_ShippedDate_OrderDate (ShippedDate >= OrderDate)
*/

/* 1. Primary key
adding a primary key to an existing table
alter table table_name
	-- constraint_name constraint_type
    add constraint pk_table_name PRIMARY KEY [clustered] (column_name [asc])
Example:
alter table Contacts
	add constraint pk_Contacts primary key (Contacts)
*/

/* 2. Syntax of Foreign Key constraint 
alter table table_name
	add constraint fk_table_name1_table_name2 FOREIGN KEY (fk_column_name)
		REFERENCES table_name1 (pk_column_name)
Example:        
alter table Orders
	add constraint fk_Orders_Customers type foreign key (CustomerID)
		references Customers (CustomerID)
*/

/* 3. Syntax of Unique constraint
alter table table_name
	add constraint uq_column_name_table_name UNIQUE (column_name)
    
EXAMPLE:
alter table Customers
	add constraint uq_CompanyName_Customers unique (CompanyName)
*/


/* 4. Syntax of Default constraint
alter table table_name
	alter column column_name
		set default default_value
        
Examples:
alter table Employees
	alter column City
		set default to 'Montreal'
*/


/*
4. Syntax of Check constraint
alter table table_name
	add constraint ck_column_name_table_name CHECK (CONDITION)
OR add constraint ck_column_name1_column_name2_table_name CHECK (condtition)

Example:
alter table Orders
	add constraint ck_OrderDate check (OrderDate > currentDate() )
OR
	add constraint ck_OrderDate_shipDate check (ShipDate >= OrderDate)
*/

/* add foreign keys constraints to DVDs table */

/* 1. Between DVDs and MovieTypes tables */
alter table DVDs
	add constraint fk_DVDs_MovieTypes foreign key (MTypeID)
		references MovieTypes (MTypeID)
;

/* 2. Between DVDs and Studios tables */
alter table DVDs
	add constraint fk_DVDs_Studios foreign key (StudID)
		references Studios (StudID)
;

/* 3. Between DVDs and Ratings tables */
alter table DVDs
	add constraint fk_DVDs_Ratings foreign key (RatingID)
		references Ratings (RatingID)
;

/* 4. Between DVDs and Formats tables */
alter table DVDs
	add constraint fk_DVDs_Formats foreign key (FormID)
		references Formats (FormID)
;
        
/* 5. Between DVDs and Status tables */
alter table DVDs
	add constraint fk_DVDs_Status foreign key (StatID)
		references Status (StatID)
;



/* add foreign keys constraints to DVDParticipants table */

/* 1. Between DVDParticipants and DVDs tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_DVDs foreign key (DVDID)
		references DVDs (DVDID)
;

/* 2. Between DVDParticipants and Participants tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_Participants foreign key (PartID)
		references Participants (PartID)
;

/* 3. Between DVDParticipants and Roles tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_Roles foreign key (RoleID)
		references Roles (RoleID)
;

/* add foreign keys constraints to Orders table */

/* 1. Between Orders and Customers tables */
alter table Orders
	add constraint fk_Orders_Customers foreign key (CustID)
		references Customers (CustID)
;

/* 2. Between Orders and Employees tables */
alter table Orders 
	add constraint fk_Orders_Employees foreign key (EmpID)
		references Employees (EmpID)
;


/* add foreign keys constraints to Transactions table */

/* 1. Between Transactions and Orders tables */
alter table Transactions
	add constraint fk_Transactions_Orders foreign key (OrderID)
		references Orders (OrderID)
;        
    
/* 2. Between Transactions and DVDs tables */
alter table Transactions
	add constraint fk_Transactions_DVDs foreign key (DVDID)
		references DVDs (DVDID)
;

/* 
Foreign keys in each table 
dvdparticipants - 3
dvds - 5
orders - 2
transactions - 2
*/

/* return the definition of the table DVDs */
show columns
from DVDs
;

select *
from information_schema.columns
where table_name = 'DVDs'
;

/* ************** Unique Constraints ************* */

/* set the DVD name to unique constraint */
alter table DVDs
	add constraint uq_DVDname_DVDs unique (DVDName)
;


/* ************** Default Constraint ************ */

/* set value to 1 for the column value named NumDisks in the table DVDs */
alter table DVDs
	alter column NumDisks
		set default 1
;
 
/* ************* Check constraint ************* */
/* set a check constraint  to the Transactions table on 
Date Due to be greater than or equal to Date Out */
alter table Transactions
	add constraint ck_DateOut_transactions check (DateDue >= DateOut)
;

/* return the foreign key constraint in the table DVDs */
select *
from information_schema.table_constraints
where table_name = 'DVDs'
and constraint_type = 'FOREIGN KEY'
;


/* count foreign key constraint number in the database Flix */
select count(*) as 'Number of foreign key constraints'
from information_schema.table_constraints
where constraint_type = 'FOREIGN KEY'
and constraint_schema = 'adflix22h1'
;

/* drop a foreign key constraint form Orders table 
alter table Orders
	drop foreign key fk_Orders_Employees
;
*/
