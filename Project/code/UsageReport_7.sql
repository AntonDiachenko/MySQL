/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;

-- drop procedure UsageReports_PeakHours_SP;

DELIMITER //
CREATE PROCEDURE UsageReports_PeakHours_SP()
BEGIN
	select avg(hour(DateOut)) as `Peak Hour of Loans`
	from Loans
;
END //
DELIMITER ;

call UsageReports_PeakHours_SP();