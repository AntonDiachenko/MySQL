/* Purpose: Creating a schema object in Northwind22H1 database
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

/* create schema objects and set the owner to each of them 
1. Person
2. Production
3. HumanResources
4. Sales
5. Purchasing
*/
/* Syntax: create object_type object_name
create schema schema_name authorization owner_name */

/* customer, order, order detail, product, supplier, employee, category */

-- 1. create person schema
create schema Person authorization dbo
;
go

-- 2. create Production schema
create schema Production authorization dbo
;
go

-- 3. create HumanResources schema
create schema HumanResources authorization dbo
;
go

-- 4. create Sales schema
create schema Sales authorization dbo
;
go

-- 5. create Purchasing schema
create schema Purchasing authorization dbo
;
go

/* create a schenma and grant permissions
Create Sports schema owned by Annik that contains  table Teams.
The statement grants SELECT to Andrew and denies SELECT to David
*/

create schema Sports authorization Annik
	create table Teams
		(
			TeamID int,
			TeamName varchar(20)
		)
		grant select on schema::Sports to Andrew 
		deny select on schema::Sports to David

-- I'm Andrew
select*
from Sports.Teams
;
-- I'm David - I can not execute