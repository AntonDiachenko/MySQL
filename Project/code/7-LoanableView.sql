/* Purpose: Creating the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

USE WestMunicipalLibrary;

create view LoanableView
as 
select * from CopywideView  where Loanable = 'Y'
;

select * from LoanableView;