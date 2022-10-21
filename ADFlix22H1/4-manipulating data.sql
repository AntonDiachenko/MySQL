/* Purpose: manipulating data in Flix database */
/* Script Date: March 31, 2022
Developed by Anton Diachenko
*/

 -- switch to Flix database
 -- Syntax: use database_name;
use ADFlix22H1
; 
drop table contacts
;

create table Contacts
(
	ContactID char(5) not null,
	FirstName varchar(15) not null,
	LastName varchar(15) not null,
	constraint pk_Contacts primary key (contactID)
)
;

/* 1. insert a new row into a table using insert / values clauses */
insert into Contacts 
values ('JS123', 'John', 'Smith')
;

/* return the list of contacts */
select *
from Roles
;

insert into Contacts
values ('MS12', 'Mary', 'Smith')
;

/* 2. Insert a new row using column names */
insert into Contacts (LastName, ContactID, FirstName)
values ('Smith', 'AM123', 'Andrea')
;

select * 
from Contacts 
order by FirstName
; 

/* 3. adding data from external data sources 
-- using load data
load data infile 'path/filename.extension'
into table table_name
fields terminated by ','
lines terminated by '\n'
ignore number_of_rows rows
;
*/

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/5_8_Participant_Roles.csv'
into table Roles
fields terminated by ','
lines terminated by '\n'
ignore 1 rows
;

/* insert data from another table
insert into table_name (column_name1, column_name2, ...) 
select from another_table_name
column_name1, column_name2, ...
*/
