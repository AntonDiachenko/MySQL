/* Purpose: Advance datetime types to values appropriate to the current date, by adding 15 years
	Script Date: April 9, 2022
    Developed By: Greg Barre
*/

DELIMITER $$
CREATE FUNCTION Add15Years (oldDate datetime)
RETURNS datetime
DETERMINISTIC 
BEGIN
    DECLARE newDate datetime;
    SET newDate = DATE_ADD(oldDate, INTERVAL 15 YEAR);
    RETURN newDate; 
END$$
DELIMITER ;