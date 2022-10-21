/* Purpose: Importing data into WestMunicipalLibrary database from CSV files
	Script Date: April 9, 2022
*/

use WestMunicipalLibrary;
SET SESSION sql_mode = '';

-- titles
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/titles.csv'
into table titles
fields OPTIONALLY ENCLOSED BY '"' terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

-- items
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/items.csv'
into table items
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

-- copies
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/copies.csv'
into table copies
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;


-- members
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/members.csv'
into table members
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;


-- adults
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/adults.csv'
into table adults
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(MemberID,PhoneNo,StreetNo,Street,City,State,Zip,@Expiry)
set ExpiryDate = STR_TO_DATE(@Expiry, '%c/%e/%Y %H:%i:%s')
;


-- juveniles
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/juveniles.csv'
into table juveniles
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(MemberID,ParentID,@DOB_Juve)
set DOB = STR_TO_DATE(@DOB_Juve, '%c/%e/%Y %H:%i:%s')
;


-- loans
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loans.csv'
into table loans
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(ISBN,CopyNo,MemberID,@date_out,@date_due)
set DateOut = STR_TO_DATE(@date_out, '%c/%e/%Y %H:%i:%s'),
	DateDue = STR_TO_DATE(@date_due, '%c/%e/%Y %H:%i:%s')
;


-- reservations
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reservations.csv'
into table reservations
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(ISBN,MemberID,@log_date)
set LogDate = STR_TO_DATE(@log_date, '%c/%e/%Y %H:%i:%s')
;

-- loanhist
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loanhist.csv'
into table loanhist
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(ISBN,CopyNo,@date_out,MemberID,@date_due,@date_returned)
set DateOut = STR_TO_DATE(@date_out, '%c/%e/%Y %H:%i:%s'),
	DateDue = STR_TO_DATE(@date_due, '%c/%e/%Y %H:%i:%s'),
    DateReturned = STR_TO_DATE(@date_returned, '%c/%e/%Y %H:%i:%s')
;




-- TEST QUERIES

select * from titles where TitleID = '3';
select * from items where ISBN = '1000';
select * from copies where ISBN = '1000';
select * from loans where ISBN = '1000';
select * from loanhist;
select * from members where MemberID = '10000';
select * from adults where MemberID = '9999';
select * from juveniles where MemberID = '10000';
select * from reservations where ISBN = '862';



