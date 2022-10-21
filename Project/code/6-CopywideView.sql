/* Purpose: Creating the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

USE WestMunicipalLibrary;

create view CopywideView
as
select
C.CopyNo,
I.ISBN,
I.Translation,
I.Cover,
T.TitleID,
T.TitleName,
T.AuthorName,
T.Synopsis,
C.OnLoan,
I.Loanable
from Items as I
inner join Titles as T
on I.TitleID = T.TitleID
inner join Copies as C
on I.ISBN = C.ISBN
;



select * from CopyWideView;
select count(CopyNo) from CopyWideView;
select count(CopyNo) from CopyWideView;

-- (Total variations of each book is 20 => (1 Hard Cover + 1 Paperback) * 10 languages
select * from CopyWideView where TitleName = 'Last of the Mohicans' group by ISBN; 

-- (Total count of each book is 200 => ((1 Hard Cover + 1 Paperback) * 10 languages) * 10 copies per book
select * from CopyWideView where TitleName = 'Last of the Mohicans'; 
select count(CopyNo) from CopyWideView where TitleName = 'Last of the Mohicans'; 