/* Purpose: built in mySQL functions
 	Script Date: April 4, 2022
    Developed By: Alex Holowach
*/

-- switch to the current database 
-- use database_name
use AHflix22h1
;

/* compariosn and converting functions */

/* what is the greatest value */
select greatest(2, 6, 10) as `The greatest value`
;

/* compare two expressions 
if expr1 < exp2 --> -1
if expr1 > exp2 --> 1
if expr1 = exp2 --> 0
*/

select strcmp('Big', 'Bigger') as `strcmp function`
;

/* contro; flow functions
if() | isNull() | nullif() | case() | cast () 

if( (condition), 'true_value', 'false_value') */

select if( (50>= 60), 'passed the course', 'failed the course') as `if() function`
;

select*
from status
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



/* ------------------------------------ */



/* return the list of customers (full customer name) and their orders */
select c.custid as `customer id`,
concat_ws( ' ', c.custFN, coalesce(c.custMN, ' '), c.custLN) as `customer Name`, 
o.orderid as `order number`
from orders as o inner join customers as c
	on c.custid = o.custid
    ;

/* return the list of customers (full customer name) who did not place any orders */
select c.custid as `customer id`,
concat_ws( ' ', c.custFN, coalesce(c.custMN, ' '), c.custLN) as `customer Name`, 
o.orderid as `order number`
from customers as c left outer join orders as o
	on c.custid = o.custid
   where o.orderid is null
    ;

-- insert yourself into table
insert into customers (custfn, custln)
values ('Alex', 'Holowach')
;

select*
from customers
;

/* 5. how many orders are placed by each customer */

select c.custid as `customer id`,
concat_ws( ' ', c.custFN, coalesce(c.custMN, ' '), c.custLN) as `customer Name`, 
count(o.orderid) as `number of orders`
from customers as c inner join orders as o
on c.custid = o.custid
group by o.custid, `customer Name`
;

/* return the (base table) 
	DVDName,
    Movie type description,
    studio description,
    status description,
    format description, 
    rating description
    participant full name
    role description
    */
    
    select
		D.DVDName as `DVD Name`,
        MT.MtypeDescript as `Movie Type`,
        s.studdescrip as `studio`,
        st.statdescrip as `status`,
        f.formdescrip as `format`,
        r.ratingdescrip as `rating`,
        concat_ws( ' ', p.partFN, coalesce(p.partMN, ' '), p.partLN) as `participant Name`,
        ro.roledescript as `role`
    from DVDs as D
		inner join MovieTypes as MT
			on D.MTypeID = MT.MTypeID
		inner join studios as s
			on d.studID = s.studid
		inner join status as st
			on d.statusid = st.statusid
		inner join formats as f
			on d.formid = f.formid
		inner join ratings as r
			on d.ratingid = r.ratingid
		inner join dvdparticipants as dp
			on d.dvdid = dp.dvdid
		inner join participants as p
			on dp.partid = p.partid
		inner join roles as ro
			on dp.roleid = ro.roleid
        ;
        
        



