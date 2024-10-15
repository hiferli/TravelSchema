DELIMITER //
CREATE PROCEDURE GetSupplierInfo
(
	IN SupplierEmail VARCHAR(255), 
    IN SupplierPassword VARCHAR(255)
)
BEGIN
	SELECT 
    Suppliers.SupplierId , Suppliers.SupplierName , Suppliers.SupplierContact , Suppliers.SupplierEmail , 
    Suppliers.SupplierGSTNumber , Suppliers.SupplierAadhar , Suppliers.AdminStatus , 
    Address.AddressDesc , Address.City , Address.State , Address.Pincode
    FROM Suppliers
    INNER JOIN Address
    ON Address.AddressId = Suppliers.AddressId
    WHERE Suppliers.SupplierEmail = SupplierEmail
    AND Suppliers.SupplierPassword = SupplierPassword;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAvailablePackages
()
BEGIN
	SELECT * 
    FROM Packages
    WHERE Packages.Quantity > 0
    AND Packages.AdminStatus = 'Approved'
    AND Packages.SupplierStatus = 'Active';
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE CheckSupplierGST
(
	IN GSTNumber VARCHAR(255)
)
BEGIN
	SELECT COUNT(*) 
    FROM Suppliers WHERE 
    Suppliers.SupplierGSTNumber = GSTNumber;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllBookings
()
BEGIN
	SELECT 
	Bookings.BookingId , Bookings.JourneyStartDatetime , Bookings.SupplierStatus , Users.UserId , Users.UserName , CONCAT(Address.AddressDesc , Address.City , Address.State , Address.Pincode) AS 'Address' , Packages.PackageId , Packages.PackageName , Packages.Source , Packages.Destination , Packages.AdminStatus , Packages.SupplierStatus
	FROM Bookings 
	INNER JOIN Users
	ON Users.Userid = Bookings.UserId
	INNER JOIN Address
	ON Address.AddressId = Users.AddressId
	INNER JOIN Packages 
	ON Packages.PackageId = Bookings.PackageId;
END;
// DELIMITER ;

CALL GetAllBookings();

DELIMITER //
CREATE PROCEDURE GetBookingById
(
	IN p_BookingId INT
)
BEGIN
	SELECT 
	Bookings.BookingId , Bookings.JourneyStartDatetime , Bookings.SupplierStatus , Users.UserId , Users.UserName , CONCAT(Address.AddressDesc , Address.City , Address.State , Address.Pincode) AS 'Address' , Packages.PackageId , Packages.PackageName , Packages.Source , Packages.Destination , Packages.AdminStatus , Packages.SupplierStatus
	FROM Bookings 
	INNER JOIN Users
	ON Users.Userid = Bookings.UserId
	INNER JOIN Address
	ON Address.AddressId = Users.AddressId
	INNER JOIN Packages 
	ON Packages.PackageId = Bookings.PackageId
    WHERE Bookings.BookingId = p_BookingId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetBookingsByPackageId
(
	IN p_PackageId INT
)
BEGIN
	SELECT 
	Bookings.BookingId , Bookings.JourneyStartDatetime , Bookings.SupplierStatus , Users.UserId , Users.UserName , CONCAT(Address.AddressDesc , Address.City , Address.State , Address.Pincode) AS 'Address' , Packages.PackageId , Packages.PackageName , Packages.Source , Packages.Destination , Packages.AdminStatus , Packages.SupplierStatus
	FROM Bookings 
	INNER JOIN Users
	ON Users.Userid = Bookings.UserId
	INNER JOIN Address
	ON Address.AddressId = Users.AddressId
	INNER JOIN Packages 
	ON Packages.PackageId = Bookings.PackageId
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetPackages
()
BEGIN
	SELECT * FROM Packages;
END;
// DELIMITER ;