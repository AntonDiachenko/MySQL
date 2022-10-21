/* Purpose: Displaying information on Adult members
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

create view AdultwideView
as 
select 
	concat_ws(' ', M.FirstName, ifNull((M.MiddleInitial), ''), M.LastName) as `Member Name`,
    A.StreetNo as `Street #`,
    A.Street as `Street`,
    A.City as `City`,
    A.State as `State`,
    A.Zip as `Zip`
from Adults as A
	left join Members as M
		on A.MemberID = M.MemberID
;

-- select * from AdultwideView;