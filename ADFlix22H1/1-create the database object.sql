-- Step 1. create the database object
/*
Purpose: The database tracks the inventory of DVDs, 
provides information about the DVDs, 
records rental transactions, and stores the names 
of the store’s customers and employees
*/

/* Script Date: March 28, 2022
Developed by Anton Diachenko
*/

/*
CREATE DATABASE [IF NOT EXISTS] <database name>
[[DEFAULT] CHARACTER SET <character set name>]
[[DEFAULT] COLLATE <collation name>]

*/
 
 -- CREATE object_type object_name
 create database ADFlix22H1
 ;
 
 -- switch to Flix database
 -- Syntax: use database_name;
use ADFlix22H1
; 



/* using the schema command to create a new database in MySQL.
Note. Creating schema in Microsoft SQL server has different meaning.
*/ 

-- create schema database_name
create schema myDB2
;

-- create a database with charset and collate
create database Bookstore
default character set latin1
default collate latin1_bin
;

-- show the character set and collation in MySQL
show character set
;

show collation
;

/* remove (drop) a database from MySQL server */
-- drop object_type object_name
drop database mydb2
;

drop database bookstore
;
