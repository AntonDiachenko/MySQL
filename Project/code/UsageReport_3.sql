/* Purpose: what was the greatest number of books loaned by any one individual
Script date: April 9, 2022
*/

USE WestMunicipalLibrary;

-- DROP PROCEDURE GreatestNumBorrowed;

DELIMITER //
CREATE PROCEDURE GreatestNumBorrowed(
		IN WhatYear YEAR
)
BEGIN
    select count(dateout) as `No. of books borrowed`, memberID
	from loanhist
	where year(dateout) = WhatYear
	group by memberID
	order by count(dateout) desc
	limit 1;
END //
    
DELIMITER ;

CALL GreatestNumBorrowed(2007);




