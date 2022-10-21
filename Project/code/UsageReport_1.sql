/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;

-- drop procedure UsageReports_NumberOfLoans_SP;

DELIMITER //
CREATE PROCEDURE UsageReports_NumberOfLoans_SP()
BEGIN
	select count(*) as `Number of Loans`
	from Loans
	where year(DateOut) = 2007
;
END //
DELIMITER ;


CALL UsageReports_NumberOfLoans_SP();

