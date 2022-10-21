/* Purpose: Creating Stored Procedure for use in usage reports
	Script Date: April 11, 2022
    Developed By: Greg Barre
*/
USE WestMunicipalLibrary;
-- drop procedure UsageReports_PercentageMembers_SP;

DELIMITER //
CREATE PROCEDURE UsageReports_PercentageMembers_SP()
BEGIN
	select
		count(DISTINCT(M.MemberID)) as `Total Members`,
        count(DISTINCT(L.MemberID)) as `Members that borrowed`,
		(count(DISTINCT(L.MemberID)) / count(DISTINCT(M.MemberID)))*100 as `Percentage of Members to borrow a book` 
	from Members as M
    left join Loans as L
    on M.MemberID = L.MemberID
;
END //
DELIMITER ;


call UsageReports_PercentageMembers_SP();