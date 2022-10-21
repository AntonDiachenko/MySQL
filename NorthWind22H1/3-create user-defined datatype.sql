/* Purpose: Creating user-defined data types in Northwind22H1 database
	script Date: April 6, 2022
	Developed by: Anton Diachenko
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the Northwind database
-- Syntax: use database_name
use Northwind22H1
;
go -- includes end of the batch marker

/* Partial syntax: 
create type [schema_name].type_name
from system_data_type [constraint]
*/

-- create BusinessAddress user-defined data type

create type BusinessAddress
from nvarchar(40) not null
;
go


/* create RegionCode (state or province) data type */
create type dbo.RegionCode
from nchar(2) null
;
go

/* create SocialNumber data type */
create type SocialNumber
from nchar(11) not null
;
go

/* create table Contacts */
create table Contacts
(
	ContactID smallint identity(1, 1) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	SocialInsuranceNumber SocialNumber,
	Address BusinessAddress,
	Region RegionCode,
	constraint pk_Contacts primary key clustered (ContactID asc)
)
;
go




