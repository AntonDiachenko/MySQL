/* Purpose: Manipulating data from multiple table objects
	Script Date: April 4, 2022 
    Developed by: Khattar Daou
*/

-- switch to the Flix database
-- Syntax: use database_name;
use ADFlix22H1
;

/* Join Types
1. inner join (default) - matching values
outer join - unmatching values

Syntax:
select
from table1 as T1 join_type table2 as T2
	on T1.PK = T2.FK
    
where join_type: inner, left outer, right outer, self join, ...
*/

/* 1. return the DVD name and Movie Type Description */
select D.DVDName as `DVD Name`, D.MTypeID as `Type`, MT.MTypeDescrip as `Movie Type`
from DVDs as D inner join MovieTypes as MT
	on D.MTypeID = MT.MTypeID
;

/* 2. return the list of Movie Type Description and their DVD Name,
even if no DVD matches the type. Show only unmatched rows */
select MT.MTypeDescrip as `Movie Type`, D.DVDName as `DVD Name`
from MovieTypes as MT left Join DVDs as D
	on MT.MTypeID = D.MTypeID
-- where D.DVDName is null    
;

-- switch tables order
/* 2. return the list of Movie Type Description and their DVD Name,
even if no DVD matches the type. Show only unmatched rows */
select MT.MTypeDescrip as `Movie Type`, D.DVDName as `DVD Name`
from DVDs as D right Join MovieTypes as MT 
	on MT.MTypeID = D.MTypeID
-- where D.DVDName is null 
;

/* 3. return the list of customers (full customer name) and their orders */
select 
	O.CustID as `Customer ID`,
    concat_ws(' ', C.CustFN, coalesce(C.CustMN, ''), CustLN) as `Customer Name`,
     O.OrderID as `Order Number`  
from Customers as C inner join Orders as O 
	on	C.CustID = O.CustID
;

/* 4. return the list of customers (full customer name) how did not placed any order */
select 
	O.CustID as `Customer ID`,
    concat_ws(' ', C.CustFN, coalesce(C.CustMN, ''), CustLN) as `Customer Name`,
     O.OrderID as `Order Number`  
from Customers as C left outer join Orders as O 
	on	C.CustID = O.CustID
-- where O.OrderId is null
;

/* insert yourself as a new customer */
insert into Customers (CustFN, CustLN)
values('Khattar', 'Daou')
;

select * 
from Customers
;

/* 5. return how many orders placed by each customer (full customer name) */
select 
	O.CustID as `Customer ID`,
    concat_ws(' ', C.CustFN, coalesce(C.CustMN, ''), CustLN) as `Customer Name`,
     count(O.OrderID) as `Order Number`  
from Customers as C left outer join Orders as O 
	on	C.CustID = O.CustID
group by O.CustID, `Customer Name`     
-- where O.OrderId is null
;

/* 6. return the (base table)
	DVDName,
    Movie Type description, 
    Studio Description,
    Status Description,
    Format Description,  
    Rating Description,   
    Participant Full Name, and
    Role Description
*/
select
	D.DVDName as 'DVD name',
    MT.MTypeDescrip as 'Movie Type',
    S.StudDescrip as 'Studio',
    ST.StatDescrip as 'Status',
    F.FormDescrip as 'Format',
    R.RatingDescrip as 'Rating',
    concat_ws(' ', P.PartFN, coalesce(P.PartMN, ''), PartLN) as `Particiapnt Name`,
    RO.RoleDescrip as 'Role'
from DVDs as D
	inner join MovieTypes as MT
		on D.MTypeID = MT.MTypeID
    inner join Studios as S
		on D.StudID = S.StudID
	inner join Status as ST
		on D.StatID = ST.StatusID
	inner join Formats as F
		on D.FormID = F.FormID
	inner join Ratings as R
		on D.RatingID = R.RatingID
	inner join DVDParticipants as DP
		on D.DVDID = DP.DVDID
	inner join Participants	as P
		on DP.PartID = P.PartID
	inner join Roles as RO
		on DP.RoleID = RO.RoleID    
;        

