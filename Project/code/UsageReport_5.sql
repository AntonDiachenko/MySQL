/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;

-- drop procedure UsageReports_PercentageOverdue_SP;


DELIMITER //
CREATE PROCEDURE UsageReports_PercentageOverdue_SP()
BEGIN SELECT
	(select count(*) from loanhist where (DateDue < DateReturned)) as Overdue,
    (select count(*) from loanhist) as Total,
    (select (OverDue/Total)*100) as `Percentage`
;
END //
DELIMITER ;

CALL UsageReports_PercentageOverdue_SP();
