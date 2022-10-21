/* Purpose: Advance datetime types to values appropriate to the current date, by adding 14 years
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

DELIMITER $$
CREATE FUNCTION Add14Years (oldDate datetime)
RETURNS datetime
DETERMINISTIC 
BEGIN
    DECLARE newDate datetime;
    SET newDate = DATE_ADD(oldDate, INTERVAL 14 YEAR);
    RETURN newDate; 
END$$
DELIMITER ;