/* ICA_05 */
/* Script Date: April 02, 2022
Developed by Anton Diachenko
*/

 -- switch to Flix database
 -- Syntax: use database_name;
use ADFlix22H1
;

/* 1. MONTH(date) the month for date in the range 1 to 12 for January to December. */
select *
from Transactions
where month(DateOut) = 3
;

/* 2. EXTRACT(unit FROM date) function extracts parts from the date */
select extract(month from DateOut) as 'Month'
from Transactions
;

/* 3. UPPER(str) function returns the string str with all characters changed to uppercase. */
select upper(CustFN), CustLN 
from Customers 
; 


/* 4. Match() against() function performs a natural language search for a string against a text collection */
select *
from DVDs 
where match (DVDName)
against ('Africa' in natural language mode)
; 

/* 5. Last_insert_id function returns a BIGINT UNSIGNED (64-bit) value 
representing the first automatically generated value successfully inserted 
for an AUTO_INCREMENT column as a result of the most recently executed 
INSERT statement.   
*/
select * 
from Customers
where CustID = last_insert_id() 
; 





