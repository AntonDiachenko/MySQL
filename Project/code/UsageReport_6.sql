/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;

-- drop procedure UsageReports_AvgLoanLength_SP;

DELIMITER //
CREATE PROCEDURE UsageReports_AvgLoanLength_SP()
BEGIN
	select avg(datediff(DateReturned, DateOut)) as `Average Loan Length in Days`
	from LoanHist
;
END //
DELIMITER ;


CALL UsageReports_AvgLoanLength_SP();
