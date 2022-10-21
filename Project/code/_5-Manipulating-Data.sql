/* Purpose: update data in WestMunicipalLibrary database
	Script Date: April 10, 2022
*/
USE WestMunicipalLibrary;

-- 1. Safe Mode OFF *enables error-free updates*
SET SQL_SAFE_UPDATES = 0;
-- 2. Safe Mode ON *to go back to safe mode protection*
SET SQL_SAFE_UPDATES = 1;

-- Date Updates
update Adults
	set ExpiryDate = Add15Years(ExpiryDate)
;
update Juveniles
	set DOB = Add14Years(DOB)
;
update Reservations
	set LogDate = Add14Years(LogDate)
;
update Loans
	set DateOut = Add14Years(DateOut),
		DateDue = Add14Years(DateDue)
;
update LoanHist
	set DateOut = Add14Years(DateOut),
		DateDue = Add14Years(DateDue),
        DateReturned = Add14Years(DateReturned)
;