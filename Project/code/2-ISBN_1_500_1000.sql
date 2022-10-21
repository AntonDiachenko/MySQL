/* Purpose: Displaying information on copies with an ISBN of 1, 500 and 1000
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

select 
	C.ISBN as `ISBN`,
    C.CopyNo as `Copy #`,
    C.OnLoan as `On Loan`,
    T.TitleName as `Title`,
    I.Translation as `Language`,
    I.Cover as `Cover Format`   
from Copies as C
	inner join Items as I
		on C.ISBN = I.ISBN
	inner join Titles as T
		on I.TitleID = T.TitleID
having C.ISBN in (1, 500, 1000) 
order by C.ISBN
;
