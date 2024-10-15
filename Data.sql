INSERT IGNORE INTO Address (AddressDesc, City, State, Pincode, Lat, Lon) 
VALUES 
('MG Road', 'Bengaluru', 'Karnataka', 560001, '12.9716', '77.5946'),
('Connaught Place', 'New Delhi', 'Delhi', 110001, NULL, NULL),
('Marine Drive', 'Mumbai', 'Maharashtra', 400020, '18.9432', '72.8235'),
('Park Street', 'Kolkata', 'West Bengal', 700016, NULL, NULL),
('Anna Salai', 'Chennai', 'Tamil Nadu', 600002, '13.0808', '80.2707');

INSERT IGNORE INTO Suppliers 
(SupplierName, SupplierContact, SupplierEmail, SupplierPassword, SupplierGSTNumber, SupplierAadhar, AddressId, AdminStatus)
VALUES 
('Ramesh Traders', '9876543210', 'ramesh@example.com', 'securepassword1', '29ABCDE1234F1Z5', '123412341234', 1, 'Approved'),
('Mohan Suppliers', '8765432109', 'mohan@example.com', 'securepassword2', '07ABCDE1234F1Z6', '234523452345', 2, 'Pending'),
('Kiran Enterprises', '7654321098', 'kiran@example.com', 'securepassword3', '19ABCDE1234F1Z7', '345634563456', 3, 'Approved'),
('Suresh Distributors', '6543210987', 'suresh@example.com', 'securepassword4', '27ABCDE1234F1Z8', '456745674567', 4, 'Pending'),
('Anil Wholesalers', '5432109876', 'anil@example.com', 'securepassword5', '18ABCDE1234F1Z9', '567856785678', 5, 'Approved');

INSERT IGNORE INTO Users 
(UserName, UserEmail, UserPassword, UserPhoneNumber, AddressId, UserDOB, UserGender, AdminStatus)
VALUES 
('Amit Sharma', 'amit.sharma@example.com', 'password123', '9876543211', 1, '1990-01-15', 'Male', 'Approved'),
('Neha Singh', 'neha.singh@example.com', 'password456', '8765432110', 2, '1992-03-22', 'Female', 'Pending'),
('Ravi Kumar', 'ravi.kumar@example.com', 'password789', '7654321109', 3, '1985-06-10', 'Male', 'Approved'),
('Priya Desai', 'priya.desai@example.com', 'password101', '6543211098', 4, '1995-11-05', 'Female', 'Pending'),
('Rahul Verma', 'rahul.verma@example.com', 'password202', '5432109876', 5, '1988-09-17', 'Male', 'Approved'),
('Manik Manro' , 'manik.manro@example.com' , 'password404' , '4321567890' , 1 , '2000-12-21' , 'Male' , 'Pending');

INSERT IGNORE INTO Packages 
(SupplierId, PackageName, PackageDesc, Source, Destination, FASL, Duration, PackagePrice, CompanyProfit, Quantity, SupplierStatus, AdminStatus)
VALUES 
(1, 'Himalayan Adventure', 'Explore the Himalayas with guided treks and campfires.', 'Delhi', 'Manali', 'HIM1', 7, 15000, 6000, 10, 'Active', 'Pending'),
(2, 'Goa Beach Getaway', 'Relax on the sunny beaches of Goa with luxury accommodations.', 'Mumbai', 'Goa', 'GOA1', 5, 12000, 5000, 20, 'Active', 'Approved'),
(3, 'Kerala Backwaters', 'Experience the serene beauty of Kerala’s backwaters.', 'Kochi', 'Alleppey', 'KER1', 3, 8000, 5000, 15, 'Inactive', 'Pending'),
(4, 'Rajasthan Cultural Tour', 'Discover the rich culture and heritage of Rajasthan.', 'Jaipur', 'Jodhpur', 'RAJ1', 10, 20000, 7000, 8, 'Active', 'Approved'),
(5, 'Andaman Islands Escape', 'Explore the pristine beaches and marine life of the Andaman Islands.', 'Chennai', 'Port Blair', 'AND1', 6, 18000, 6500, 12, 'Active', 'Pending'),
(1, 'Leh-Ladakh Expedition', 'An adventurous journey through the rugged landscapes of Leh and Ladakh.', 'Delhi', 'Leh', 'LEH1', 9, 25000, 8000, 0, 'Active', 'Approved'), -- Quantity is 0
(2, 'Sundarbans Wildlife Tour', 'Explore the mangrove forests and spot the elusive Royal Bengal Tiger.', 'Kolkata', 'Sundarbans', 'SUN1', 4, 12000, 5500, 5, 'Active', 'Pending'), -- Pending Admin Status
(3, 'Golden Triangle Tour', 'Experience the historical wonders of Delhi, Agra, and Jaipur.', 'Delhi', 'Jaipur', 'GOL1', 7, 15000, 6000, 10, 'Inactive', 'Approved'), -- Inactive Supplier Status
(4, 'North-East Explorer', 'Discover the scenic beauty and cultural diversity of India’s North-East.', 'Guwahati', 'Shillong', 'NEE1', 6, 18000, 6500, 0, 'Inactive', 'Pending'); -- Quantity is 0, Inactive Supplier Status, Pending Admin Status

INSERT IGNORE INTO Bookings (UserId, PackageId, JourneyStartDatetime, SupplierStatus)
VALUES
(1, 1, '2024-09-15 08:00:00', 'Confirmed'),            -- Booking for User 1 on Package 1
(2, 2, '2024-10-05 10:00:00', 'Under Process'),        -- Booking for User 2 on Package 2
(3, 3, '2024-11-12 09:30:00', 'Confirmed'),            -- Booking for User 3 on Package 3
(4, 4, '2024-12-20 06:45:00', 'Under Process'),        -- Booking for User 4 on Package 4
(5, 5, '2025-01-10 07:00:00', 'Confirmed');            -- Booking for User 5 on Package 5

INSERT INTO Bookings (UserId, PackageId, JourneyStartDatetime, SupplierStatus)
VALUES
(1, 1, '2024-09-15 08:00:00', 'Confirmed'),            -- Booking for User 1 on Package 1
(2, 2, '2024-10-05 10:00:00', 'Under Process'),        -- Booking for User 2 on Package 2
(3, 3, '2024-11-12 09:30:00', 'Confirmed'),            -- Booking for User 3 on Package 3
(4, 4, '2024-12-20 06:45:00', 'Under Process'),        -- Booking for User 4 on Package 4
(5, 5, '2025-01-10 07:00:00', 'Confirmed'),            -- Booking for User 5 on Package 5
(11, 1, '2024-09-25 07:15:00', 'Under Process'),       -- Booking for User 11 on Package 1
(13, 2, '2024-10-15 08:30:00', 'Confirmed'),           -- Booking for User 13 on Package 2
(1, 3, '2024-11-22 09:00:00', 'Under Process'),        -- Another booking for User 1 on Package 3
(2, 4, '2024-12-29 06:30:00', 'Confirmed'),            -- Another booking for User 2 on Package 4
(3, 5, '2025-01-15 08:00:00', 'Under Process');        -- Another booking for User 3 on Package 5

INSERT IGNORE INTO Payments (BookingId, PaymentAmount, PaymentDatetime, PaymentMode, PaymentStatus)
VALUES
(1, 10000, '2024-09-15 09:00:00', 'Credit Card', 'Approved'),       -- Payment for Booking 1
(2, 15000, '2024-10-05 11:00:00', 'Debit Card', 'Pending'),         -- Payment for Booking 2
(3, 20000, '2024-11-12 10:00:00', 'Net Banking', 'Approved'),       -- Payment for Booking 3
(4, 25000, '2024-12-20 07:00:00', 'UPI', 'Pending'),                -- Payment for Booking 4
(5, 30000, '2025-01-10 08:00:00', 'Cash', 'Approved'),              -- Payment for Booking 5
(6, 10000, '2024-09-25 08:00:00', 'Credit Card', 'Pending'),        -- Payment for Booking 6
(7, 15000, '2024-10-15 09:00:00', 'Debit Card', 'Approved'),        -- Payment for Booking 7
(8, 20000, '2024-11-22 10:30:00', 'Net Banking', 'Pending'),        -- Payment for Booking 8
(9, 25000, '2024-12-29 07:30:00', 'UPI', 'Approved'),               -- Payment for Booking 9
(10, 30000, '2025-01-15 09:00:00', 'Cash', 'Pending');              -- Payment for Booking 10

INSERT INTO Travellers (BookingId, PersonName, PersonPhoneNumber, AddressId)
VALUES
(1, 'Amit Sharma', '9876543211', 1),              -- Traveller for Booking 1
(2, 'Neha Singh', '8765432110', 2),               -- Traveller for Booking 2
(3, 'Ravi Kumar', '7654321109', 3),               -- Traveller for Booking 3
(4, 'Priya Desai', '6543211098', 4),              -- Traveller for Booking 4
(5, 'Rahul Verma', '5432109876', 5),              -- Traveller for Booking 5
(16, 'Amit Sharma', '9876543211', 1),             -- Another booking for Amit Sharma (Booking 16)
(17, 'Neha Singh', '8765432110', 2),              -- Another booking for Neha Singh (Booking 17)
(18, 'Ravi Kumar', '7654321109', 3),              -- Another booking for Ravi Kumar (Booking 18)
(19, 'Priya Desai', '6543211098', 4),             -- Another booking for Priya Desai (Booking 19)
(20, 'Rahul Verma', '5432109876', 5),             -- Another booking for Rahul Verma (Booking 20)
(21, 'Manik Manro', '4321567890', 1),             -- Traveller for Booking 21
(22, 'John Doe', '1234567890', 17),               -- Traveller for Booking 22
(23, 'Amit Sharma', '9876543211', 1),             -- Amit Sharma for another booking (Booking 23)
(24, 'Neha Singh', '8765432110', 2),              -- Neha Singh for another booking (Booking 24)
(25, 'Ravi Kumar', '7654321109', 3);              -- Ravi Kumar for another booking (Booking 25)

INSERT INTO UserSection (UserId, PackageId, Section)
VALUES
(1, 1, 'Wishlist'),         -- Amit Sharma adds Package 1 to Watchlist
(2, 2, 'Cart'),          -- Neha Singh adds Package 2 to Specials
(3, 3, 'Wishlist'),         -- Ravi Kumar adds Package 3 to Watchlist
(4, 4, 'Cart'),          -- Priya Desai adds Package 4 to Specials
(5, 5, 'Wishlist'),         -- Rahul Verma adds Package 5 to Watchlist
(11, 1, 'Cart'),         -- Manik Manro adds Package 1 to Specials
(13, 2, 'Wishlist'),        -- John Doe adds Package 2 to Watchlist
(1, 3, 'Cart'),          -- Amit Sharma adds Package 3 to Specials
(2, 4, 'Wishlist'),         -- Neha Singh adds Package 4 to Watchlist
(3, 5, 'Cart');          -- Ravi Kumar adds Package 5 to Specials

INSERT IGNORE INTO AdminDetails (adminEmail , adminPassword)
VALUES
('admin@admin.com' , 'admin'),
('joshi.ishaan.2001@gmail.com' , 'ishaanjoshi');