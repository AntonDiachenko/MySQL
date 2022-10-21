/* Purpose: Creating the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

USE WestMunicipalLibrary;

create view OnshelfView
as
select * from CopywideView where OnLoan = 'N'
;

select * from OnshelfView ;

