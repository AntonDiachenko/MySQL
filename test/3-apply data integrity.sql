/*
Purpose: Apply data integrity. 
*/

/* Script Date: March 31, 2022
Developed by Anton Diachenko
*/

use FurnitureRentalInc
;

alter table Rentals
	add constraint fk_Rentals_Customers foreign key (CustID)
		references Customers (CustID)
;  

alter table RentalLineItems
	add constraint fk_RentalLineItems_Rentals foreign key (RentalID)
		references Rentals (RentalID)
;

alter table RentalLineItems
	add constraint fk_RentalLineItems_Inventory foreign key (ItemID)
		references Inventory (ItemID)
;

alter table Customers
	add constraint uq_Phone_Customers unique (Phone)
;

alter table Rentals
	add constraint ck_ReturnDate check (ReturnDate < '2022-12-15' )
;

alter table RentalLineItems
	alter column Quantity
		set default '1'
;

show columns
from RentalLineItems
;
  