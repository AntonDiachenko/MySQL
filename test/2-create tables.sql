/*
Purpose: Create table objects in FurnitureRentalInc database. 
*/

/* Script Date: March 31, 2022
Developed by Anton Diachenko
*/

use FurnitureRentalInc
;

create table Customers
(
	CustID int not null,
	CustFN varchar(20) not null,
	CustLN varchar(20) not null,
    Address varchar(40) not null,
    City varchar(20) not null,
    State varchar(20) not null,
    ZIP varchar(6) not null,
    Phone varchar(12) not null,
    Email tinytext not null,
	constraint pk_Customers primary key (CustID asc)
)
;

create table Inventory
(
	ItemID int not null,
    ItemDescrip varchar(40) not null,
    MonthPrice double not null,
    constraint pk_Inventory primary key (ItemID asc)
)
;

create table Rentals
(
	RentalID int not null,
    CustID int not null,
    RentDate date not null,
    ReturnDate date not null,
    constraint pk_Rentals primary key (RentalID asc)  
)
;

create table RentalLineItems
(
	RentalID int not null,
    ItemID int not null,
    Quantity tinyint not null,
    constraint pk_RentalLineItems primary key
    (
		RentalID asc,
        ItemID asc
	)
)
;
