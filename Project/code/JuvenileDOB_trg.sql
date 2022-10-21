/* Purpose: trigger for detecting Juveniles that aren't under 18
	Script Date: April 9, 2022
*/

delimiter //
CREATE TRIGGER JuvenileDOB_trg BEFORE INSERT ON Juveniles
       FOR EACH ROW
       BEGIN
           IF 
			year(datediff(current_date(), NEW.DOB)) >= 18
           THEN 
			signal sqlstate '45000' set message_text = 'Member is over 18 years old, must register as adult member';
			END IF;
       END;//
delimiter ;
