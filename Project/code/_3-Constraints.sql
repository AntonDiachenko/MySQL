/* Purpose: Defining data constraints in the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/


USE WestMunicipalLibrary;

-- Table Modifications
alter table Adults
	alter State
		set default 'WA'
;


-- modify 
alter table Adults
modify column PhoneNo varchar(20) null
;

-- Adding Constraints
-- Default Constraints
alter table Titles
	alter Synopsis
		set default null
;

ALTER TABLE Loans
ADD column timeNow TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

/*
-- Check Constraints
alter table loans
add constraint ck_DateDue Check (DateDue > DateOut)
;
*/

-- Primary Key Constraints
alter table Titles
add constraint pk_Titles primary key (TitleID asc)
;

alter table Items
add constraint pk_Items primary key (ISBN asc)
;

-- Foreign Keys Constraints
-- table Items
alter table Items
add constraint fk_Items_Titles foreign key (TitleID)
references Titles (TitleID)
;

-- table Copies
alter table Copies
add constraint fk_Copies_Items foreign key (ISBN)
references Items (ISBN)
;

alter table Copies
add constraint fk_Copies_Titles foreign key (CopyNo)
references Titles (TitleID)
;

-- table Loans
alter table Loans
add constraint fk_Loans_Copies foreign key (ISBN)
references Copies (ISBN)
;

alter table Loans
add constraint fk_Loans_Copies2 foreign key (CopyNo)
references Copies(CopyNo)
;

alter table Loans
add constraint fk_Loans_Members foreign key(MemberID)
references Members(MemberID)
;

-- table LoanHist
alter table LoanHist
add constraint fk_LoanHist_Items foreign key (ISBN)
references Items(ISBN)
;

alter table LoanHist
add constraint fk_LoanHist_Loans foreign key (CopyNo)
references Loans(CopyNo)
;

alter table LoanHist
add constraint fk_LoanHist_Members foreign key (MemberID)
references Members(MemberID)
;

-- table Adults
alter table Adults
add constraint fk_Adults_Members foreign key (MemberID)
references Members(MemberID)
;

-- table Juvenile
alter table Juveniles
add constraint fk_Juveniles_Members foreign key (ParentID)
references Members(MemberID)
;

-- table Reservations
alter table Reservations
add constraint fk_Reservations_Items foreign key (ISBN)
references Items(ISBN)
;

alter table Reservations
add constraint fk_Reservations_Members foreign key (MemberID)
references Members(MemberID)
;

