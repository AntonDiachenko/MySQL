/* Purpose: Built-in MySQL functions
	Script Date: April 1, 2022 
    Developed by: Khattar Daou
*/

-- switch to the Flix database
-- Syntax: use database_name;
use ADFlix22H1
;

/* Compariosn and converting functions 
greatest() | least() | coalesce() | isNull() | interval() | strCmp | .... 
*/

/* What is the greatest value of 2, 3, 10 */
select greatest(2, 6, 10) as `The Greatest Value`
;

select greatest('a', 'b', 'aa', 'ab', 'bb') as `The Greatest Value`
;

/* compare two expressions 
if expr1 < exp2 --> -1
if expr1 > exp2 --> 1
if expr1 = exp2 --> 0
*/

select strcmp('Big', 'Bigger') as `strcmp function`
;

/* control flow functions
if() | isNull() | nullif() | case() | cast () */

/* if( (condition), 'true_value', 'false_value') */

select if( (50>= 60), 'passed the course', 'failed the course') as `if() function`
;

select *
from DVDs
;

/* show the status description from table DVDs */

select
	DVDName, statID,
    if ( (statID = 's1'), 'checked out', 'available')
from DVDs
;


-- nested if 
select
	DVDName, statID,
    if ( (statID = 's1'), 'check out', if ((statID = 's2'),  'available', 'N/A'))
from DVDs
;

/* isNull returns a value of 1 if the expression is evaluated to null,
otherwise it returns zero */
select ifnull( (10 * null), 'incorrect expression' ) as `ifNull Function`
;

/* NullIf() returns null if expression1 equals to expression2,
otherwise it returns expression1 */
select NullIf( (10 - 20), (20 - 10) ) as `NullIf Function`
;

/* STRING FUNCTIONS
ASCII() | char_length() | concat() | concat_ws() | lcase() | lower() |
ucase() | upper() | left() | right() | substring() | ... 
*/

/* Some of string functions: 
	left([column_name], number),
    right([column_name], number),
and substring([column_name], start, stop */

select DVDName,
	left(DVDName, 5) as 'Left Function',
    right(DVDName, 9) as 'Right Function',
    substring(DVDName, 7, 5) as 'Substring Function'
from DVDs
where DVDID = 1
;

/* return the full employee name */
select concat(E.EmpFN, ' ', IfNull((E.EmpMN, ' '), ' ', E.EmpLN)) as 'Employee Name'
from Employees as E
;

/* return the full employee name using concat_ws function */
select concat_ws(' ', E.EmpFN, IfNull((E.EmpMN), E.EmpLN)) as 'Employee Name'
from Employees as E
;

/* Create a registration employee ID based on the first 2 characters of the first name,
and 3 characters of the last name.
Capitalize the Registration ID.
Show Full Employee Name.
*/

select
	E.EmpID,
    upper(concat(left(E.EmpFN, 2), left(E.EmpLN, 3)) ) as 'Registration ID',
		concat_ws(' ', E.EmpFN, IfNull((E.EmpMN), E.EmpLN)) as 'Employee Name'
from Employees as E
;

/* case()
	case
		when expression then result
        when expression then result
        .... [else result]
	end
*/

select * 
from Ratings
;

/* using the case() function, show the following messages if:
	- rating id = R ==> Under 17 requires and adult permission
	- rating id = X ==> No One 17 and under
    - rating id = NR ==> Use discretion when renting
    otherwise OK to rent minors
*/

select
DVDName as `DVDName`, RatingID as `Ratings`,
case
	when RatingID = 'R' then 'Under 17 requires an adult permission'
    when RatingID = 'X' then 'No one 17 and under'
    when RatingID = 'NR' then 'Use discretion when renting'
    else 'OK to rent minors'
end as `Rating`
from DVDs
;

/* Some of the data and time */
select TransID, DateOut,
	date(DateOut) as 'The Date',
    day(DateOut) as 'The Day',
    month(DateOut) as 'The Month',
    year(DateOut) as 'The Year',
    dayname(DateOut) as 'The Day Name',
    dayofmonth(DateOut) as 'The Day of Month',
    dayofweek(DateOut) as 'The Day of Week',
    dayofyear(DateOut) as 'The Day of Year',
    monthname(DateOut) as 'Month Name'
from Transactions
;

/* update the DateIn in the table Transactions to the current date
for TransID = 1 */
update Transactions
set DateIn = current_date() +2
where transID = 3
;


/* DateDiff(<endDate>, <startDate>)
   TimeDiff(<endTime>, <startTime>)
*/

/* How long it took to return a DVD? */
select
	T.TransID, T.OrderID, T.DVDID, T.DateOut, T.DateDue, T.DateIn,
    abs(datediff(DateOut, DateIn)) as 'Number of Days'
from Transactions as T
-- where DateIn is not null
;

/* using cast and convert function */
select cast('20220404' as Date) as 'Cast Date'
;

select cast('20222106' as Date) as 'Error Date'
;

select convert('20220404', date) as 'Convert'
; 

select convert('20222106', date) as 'Error date'
; 


















