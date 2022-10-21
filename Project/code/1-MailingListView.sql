/* Purpose: Displaying a mailing list for all members with address information
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

create view MailingListView
as
select 
	concat_ws(' ', M.FirstName, ifNull((M.MiddleInitial), ''), M.LastName) as `Member Name`,
    A.StreetNo as `Street #`,
    A.Street as `Street`,
    A.City as `City`,
    A.State as `State`,
    A.Zip as `Zip`
from Members as M
	inner join Adults as A
		on M.MemberID = A.MemberID
;

-- select * from MailingListView;