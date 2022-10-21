/* Purpose: Displaying reservations info for Members: 250, 341 and 1675
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

select 
	M.MemberID as `Member #`,
    concat_ws(' ', M.FirstName, ifNull((M.MiddleInitial), ''), M.LastName) as `Member Name`,
    R.ISBN as `ISBN`,
    R.LogDate as `Date Logged`
from Members as M
	left join Reservations as R
		on M.MemberID = R.MemberID
having M.MemberID in (250, 341, 1675)
order by M.MemberID
;