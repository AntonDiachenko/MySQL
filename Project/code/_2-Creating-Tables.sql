/* Purpose: Creating tables in the WestMunicipalLibrary database
	Script Date: April 9, 2022
*/

USE WestMunicipalLibrary;

-- create table Titles
create table Titles
(
	TitleID int not null,
    TitleName varchar(80) not null,
    AuthorName varchar(50) not null,
    Synopsis varchar(1000) null
    -- PK added in Constraints script
);

-- create table Items
create table Items
(
	ISBN int not null,
    TitleID int not null,
    Translation varchar(15) not null,
    Cover varchar(15) not null,
    Loanable char(1) not null -- all set to Y except for ISBN 10, 50 and 100
    -- PK added in Constraints script
);

-- create table Copies
create table Copies
(
	ISBN int not null,
    CopyNo int not null,
	OnLoan char(1) not null, -- possibly Boolean type?
    constraint pk_Copies primary key (ISBN asc, CopyNo asc)
);

-- create table Loans
create table Loans
(
	ISBN int not null,
    CopyNo int not null,
    MemberID int not null,
    DateOut datetime not null, -- AdvanceYear14Func
    DateDue datetime not null, -- AdvanceYear14Func
    constraint pk_Loans primary key (ISBN asc, CopyNo asc, MemberID asc)
);

-- create table LoanHist
create table LoanHist
(
	ISBN int not null,
    CopyNo int not null,
    DateOut datetime not null, -- AdvanceYear14Func
    MemberID int not null,
    DateDue datetime not null, -- AdvanceYear14Func
    DateReturned datetime null, -- AdvanceYear14Func
    constraint pk_LoanHist primary key (ISBN asc, CopyNo asc, DateOut asc)
);

-- create table Reservations
create table Reservations
(
    ISBN Int not null,
    MemberID int not null,
    LogDate datetime not null, -- AdvanceYear14Func
    constraint pk_Reservations primary key (ISBN asc, MemberID asc, LogDate asc) 
);

-- create table Members
create table Members
(
	MemberID int not null,
    LastName varchar(30) not null,
    FirstName varchar(30) not null,
    MiddleInitial char(2) null,
    Photograph blob null,
    constraint pk_Members primary key (MemberID asc)
);

-- create table Adults
create table Adults
(
	MemberID int not null, -- PK for Adults and FK for Members MemberID
    PhoneNo varchar(20) not null,
    StreetNo varchar(10) not null,
    Street varchar(50) not null,
    City varchar(25) not null,
    State char(2) not null,
    Zip varchar(15) not null,
    ExpiryDate datetime not null, -- AdvanceYear15Func puts the expiry in 2023
    constraint pk_Adults primary key (MemberID asc)
);

-- create table Juveniles
create table Juveniles
(
	MemberID int not null, -- PK for Juveniles and FK for Members MemberID
    ParentID int not null, -- FK for Adults MemberID
    DOB datetime not null, -- AdvanceYear14Func
    constraint pk_Juveniles primary key (MemberID asc)
);

