/* Purpose: Creating virtual tables (View) objects
	Script Date: April 4, 2022 
    Developed by: Khattar Daou
*/

-- switch to the Flix database
-- Syntax: use database_name;
use ADFlix22H1
;

/* Syntax

-- head
	create view view_name [(column_list)]
	as
-- body
	sql statement(s)
*/


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

/* change some filed names */
create view DVDDescriptionView 
as
	select
		D.DVDName as 'DVDName',
		MT.MTypeDescrip as 'MovieType',
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

-- return the DVD description 
select *
from DVDDescriptionView
-- where `MovieType` = 'Mystery'
where Status = 'available' 
and `MovieType` = 'Mystery'
;

/* old way to join tables */
select D.DVDName, MT.MTypeDescrip, R.RatingDescrip
from DVDS as D, MovieTypes as MT, Ratings as R
where D.MTypeID = MT.MTypeID
and D.RatingID = R.RatingID

;
-- a new way 
select D.DVDName, MT.MTypeDescrip, R.RatingDescrip
from DVDS as D
	inner join MovieTypes as MT
		on D.MTypeID = MT.MTypeID
    inner join Ratings as R
		on D.RatingID = R.RatingID
;


/* drop view DVDDescriptionView */
-- drop object_type object_name 
drop view DVDDescriptionView
;