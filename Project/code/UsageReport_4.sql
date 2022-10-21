/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;

-- DROP PROCEDURE UsageReports_PercentageLoanedBooks_SP;


DELIMITER //
CREATE PROCEDURE UsageReports_PercentageLoanedBooks_SP()
BEGIN SELECT
	(select count(*) from Copies) as `All_Books`,
    (select count(distinct ISBN, CopyNo) from loanhist) as `Loaned_Books`,
    (select (Loaned_Books/All_Books)*100) as `Percentage`
;
END //
DELIMITER ;


CALL UsageReports_PercentageLoanedBooks_SP();
