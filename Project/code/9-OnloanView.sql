/* Purpose: Creating the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

create view OnloanView
as
select
L.ISBN as `ISBN`,
L.DateOut as `Date_out`,
L.DateDue as `Date_due`,
L.timeNow as `Current_Time`,
concat_ws(' ', M.FirstName, ifNull((M.MiddleInitial), ''), M.LastName) as `Member Name`,
T.TitleName as `Title`,
T.AuthorName as `Author`,
T.Synopsis as `Synopsis`
from Loans as L
inner join Copies as C
on L.ISBN = C.ISBN and L.CopyNo = C.CopyNo
inner join Items as I
on C.ISBN = I.ISBN
inner join Titles as T
on I.TitleID = T.TitleID
inner join Members as M
on L.MemberID = M.MemberID
where OnLoan = 'Y'
;

select * from OnloanView;



