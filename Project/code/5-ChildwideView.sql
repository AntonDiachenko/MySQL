/* Purpose: Displaying information on Juvenile members
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

create view ChildwideView
as 
select 
	concat_ws(' ', M.FirstName, ifNull((M.MiddleInitial), ''), M.LastName) as `Member Name`,
    A.StreetNo as `Street #`,
    A.Street as `Street`,
    A.City as `City`,
    A.State as `State`,
    A.Zip as `Zip`
from Juveniles as J
	left join Adults as A
		on J.ParentID = A.MemberID
	left join Members as M
		on J.MemberID = M.MemberID
;

-- select * from ChildwideView;