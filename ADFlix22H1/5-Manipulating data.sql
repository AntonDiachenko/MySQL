/* Purpose: manipulate data */
/* Script Date: April 01, 2022
Developed by Anton Diachenko
*/

 -- switch to Flix database
 -- Syntax: use database_name;
use ADFlix22H1
; 

/* A query is a question you ask about the data in the database.
A query can be used on one or more tables or other queries */ 

/* in order to answer any question about the data:
1. determine the object(s), table (base table) or view (virtual table)
2. determine the column(s) from each object
3. run the script
4. define criteria(s), сondition(s), and then run them one after another
5. group the data
6. eliminate the duplicate data
*/

/* Partial Syntax:
select * (all) | <comma separator column_list> | distinct |
from object_name
where condition [and | or]
limit number_of_rows
*/

/* 1. list all dvd id, dvd name, year released */
select DVDID, DVDName, YearRlsd
from DVDs
;

/* 2. List all dvd id, and dvd name released in 2019 */
select DVDID, DVDName 
from DVDs
where YearRlsd = '2019'
;

/* 3. list all dvd id and dvd names that have more than one disk */
select DVDID, DVDName
from DVDs
where NUMDisks > 1
;

/* General syntax:
select table_name.column_name, table_name, ...
from table_name
where table_name.column_name = expression
*/

-- server_name.database_name.object_name.column_name

/* 4. using aliases, re-write the previous script */
select D.DVDID as 'DVD Number', D.DVDName as 'DVD Name', D.NumDisks as 'No. of Disks'
from DVDs as D
where D.NumDisks > 1
; 

/* Using aliases change the column names in the result set of the Employees table.
for example,  EmpID -> Employee ID */
select E.EmpID as 'Employee ID', E.EmpFN as 'First Name', E.EmpMN as 'Middle Name', E.EmpLN as 'Last Name' 
from Employees as E
;

/* or the same using backtick (`) for MySQL*/
select E.EmpID as `Employee ID`, E.EmpFN as `First Name`, E.EmpMN as `Middle Name`, E.EmpLN as `Last Name` 
from Employees as E
;

/* 6. return the employee full name as a single string */
select E.EmpFN + ' ' + E.EmpLN
from Employees as E
;

/* 7. using concat(str1, str2, ... strN)
Syntax: CONCAT(string_value1, string_value2 [, string_valueN]) 
*/
select concat(E.EmpFN, ' ', E.EmpMN, ' ', E.EmpLN) as 'Employee Name'
from Employees as E
;

/* using the coalesce funcion 
COALESCE() function is used for returning the first non-null value 
in a list of expressions. If all the values 
in the list evaluate to NULL, then the COALESCE() function return NULL. 
The COALESCE() function accepts one parameter
which is the list which can contain various values
*/
select concat(E.EmpFN, ' ', coalesce(E.EmpMN, ''), ' ', E.EmpLN) as 'Employee Name'
from Employees as E
;

/* 9. using concat_ws() function
concat_ws(separator, argument1, argument2, ..., [, argumentN])
*/
select concat_ws(' ', E.EmpFN, coalesce(E.EmpMN, ''), E.EmpLN) as 'Employee Name'
from Employees as E
;

/* update YearRlsd to 2022 for DVDID number 55 
update table_name
set column_name = expression
*/

update DVDs
set YearRlsd = 2022
where DVDID = 55
;

/* Use where condition when updating and deleting records
delete
from Employees
where EmpID > 6
where EmpID between 3 and 6
where EmpID IN (1, 3, 5)
*/

delete
from Orders
where OrderID between 111 and 222
;

/* 10. return the rating id (NO DUPLICATE VALUES)  from the DVDs table */
select distinct RatingID as 'Rating ID'
from DVDs
;

/* return only five records from the table DVDs */
select DVDID, DVDName, NumDisks
from DVDs
-- limit number_of_rows
limit 5
;

/* return only five records from the table DVD randomly */
select DVDID, DVDName, NumDisks
from DVDs
order by rand()
limit 5
;

/* 11. return the dvd names ad nmovie type id for the status value S1 */
select DVDName, MTypeID
from DVDs
where StatID = 'S1'
;

/* 12. return the dvd names and movie type id for the status values S1, S2 and S4 */
select D.DVDName as `DVD Name`, D.MTypeID as `Movie Type`, D.StatID as `Status`
from DVDs as D
where D.StatID  = 'S1' or D.StatID  = 'S2' or D.StatID  = 'S4'
;

/* repeat the same query using the In(val1, val2, ...) operation */
select D.DVDName as `DVD Name`, D.MTypeID as `Movie Type`, D.StatID as `Status`
from DVDs as D
where D.StatID  in('S1', 'S2', 'S4')
;

/* 13. return the DVD name and the movie type id for the status id = S2,
and the rating id equals NR or G
*/

select D.DVDName as `DVD Name`, D.MTypeID as `Movie Type`, D.StatID as `Status`, D.RatingID as `Rating`
from DVDs as D
where D.StatID = 'S2'
	and RatingID in('NR', 'G')
;

/* OR logical operator
false	false	-> false
false	true	-> true
true	false	-> true
true	true	-> true

AND
false	false	-> false
false	true	-> false
true	false	-> false
true	true	-> true
*/

/* Aggregate Functions: count([column_name]) | sum() | min() | max() | avg() */

/* 14. return the total number of dvds */
select count(DVDID) as 'TOtal Number of DVDs'
from DVDs
;

/* return the total number of disks */
select sum(NumDisks) as `Total Number of Disks`
from DVDs
;

/* 16.a find out how many transactions per each order.
List them from the highest to the lowest value */
select OrderID, count(TransID) as `Number of Transactions per Order`
from Transactions
group by OrderID
;

/* 16.b find out how many transactions per each order.
List them from the highest to the lowest value */
select OrderID, count(TransID) as `Number of Transactions per Order`
from Transactions
group by OrderID
order by count(TransID) desc
-- order by 2 desc
;

/* 17. how many orders were taken by each employee */
select EmpID, count(OrderID) as `Number of Orders by Employee` 
from Orders
group by EmpID
;

/* Return the total number of orders placed by each customer */
select CustID, count(OrderID) as `Number of Orders by Customer` 
from Orders
group by CustID
;

/* 18. list customers who placed more than 2 orders */
select CustID, count(OrderID) as `Number of Orders by Customer` 
from Orders
group by CustID
having count(OrderID)> 2
;



