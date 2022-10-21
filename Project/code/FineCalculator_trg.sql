USE WestMunicipalLibrary;

-- create table Fines
create table fines
(
	id int not null auto_increment,
	MemberID int not null,
    Fines int null,
    constraint pk_fines primary key (id)
);

-- table Fines
alter table fines
add constraint fk_Fines_LoanHist foreign key (MemberID)
references LoanHist (MemberID)
;


DELIMITER $$

CREATE TRIGGER fine_trigger 
AFTER insert
ON LoanHist FOR EACH ROW
BEGIN
    IF (datediff(DateReturned, DateDue) > 1) THEN
    select memberID from loanhist where (LoanHist.DateReturned > LoanHist.DateDue) into @temp1;
    select (2 * (datediff(DateReturned, DateOut))) from loanhist where (LoanHist.DateReturned > LoanHist.DateDue) into @temp2;
	INSERT INTO Fines(memberId, fines)
    VALUES(@temp1, @temp2);
    END IF;
END$$

DELIMITER ;



select (datediff(DateReturned, DateDue)) from loanhist;