/* Purpose: Creating the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

USE WestMunicipalLibrary;

create view OverdueView
as
select * from OnloanView where Date_due < Current_Time
;


select * from OverdueView;
