DELIMITER //
CREATE PROCEDURE RegisterUser
(
    IN p_UserName VARCHAR(255),
    IN p_UserEmail VARCHAR(255),
    IN p_UserPassword VARCHAR(255),
    IN p_UserPhoneNumber VARCHAR(255),
    IN p_UserDOB DATE,
    IN p_UserGender ENUM('Male', 'Female', 'Others'),

    IN p_Address VARCHAR(255),
    IN p_City VARCHAR(255),
    IN p_State VARCHAR(255),
    IN p_Pincode INT,
    IN p_Lat VARCHAR(255),
    IN p_Lon VARCHAR(255)
    
    -- Was returning UserId before the update
)
BEGIN
    DECLARE v_RegisteredAddressId INT;

    INSERT IGNORE INTO Address
    (AddressDesc, City, State, Pincode, Lat, Lon)
    VALUES
    (p_Address, p_City, p_State, p_Pincode, p_Lat, p_Lon);

    SELECT AddressId 
    INTO v_RegisteredAddressId 
    FROM Address
    WHERE AddressDesc = p_Address 
      AND City = p_City 
      AND State = p_State 
      AND Pincode = p_Pincode 
      AND Lat = p_Lat 
      AND Lon = p_Lon
    LIMIT 1;

    INSERT IGNORE INTO Users
    (UserName, UserEmail, UserPassword, UserPhoneNumber, UserDOB, UserGender, AddressId)
    VALUES
    (p_UserName, p_UserEmail, p_UserPassword, p_UserPhoneNumber, p_UserDOB, p_UserGender, v_RegisteredAddressId);
    
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetUserInfo
(
	IN UserEmail VARCHAR(255), 
    IN UserPassword VARCHAR(255)
)
BEGIN
	CALL ApproveUser(UserEmail , UserPassword);
    
	SELECT 
    Users.UserId , Users.UserName , Users.UserPhoneNumber , Users.UserEmail , 
    Users.UserDOB , Users.UserGender , Users.AdminStatus , 
    Address.AddressDesc , Address.City , Address.State , Address.Pincode
    FROM Users
    INNER JOIN Address
    ON Address.AddressId = Users.AddressId
    WHERE Users.UserEmail = UserEmail
    AND Users.UserPassword = UserPassword;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetBookingsByUserId
(
	IN p_UserId INT
)
BEGIN
	SELECT 
	Bookings.BookingId , Bookings.UserId , Bookings.JourneyStartDatetime , Packages.PackageId , Packages.PackageName , Packages.Source , Packages.Destination , Packages.FASL , Packages.SupplierStatus , Packages.AdminStatus
	FROM Bookings
	INNER JOIN Packages
	ON Bookings.PackageId = Packages.PackageId
	WHERE Bookings.UserId = p_UserId;	
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddToWishlist
(
	IN p_UserId INT,
    IN p_PackageId INT
)
BEGIN
	INSERT INTO UserSection
    (UserId , PackageId , Section)
    VALUES
    (p_UserId , p_PackageId , 'Wishlist');
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeleteFromWishlist
(
	IN p_UserId INT,
    IN p_PackageId INT
)
BEGIN
	DELETE FROM UserSection
    WHERE UserSection.UserId = p_UserId
    AND UserSection.PackageId = p_PackageId
	AND UserSection.Section = 'Wishlist';
END;
// DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddToCart
(
	IN p_UserId INT,
    IN p_PackageId INT
)
BEGIN
	INSERT INTO UserSection
    (UserId , PackageId , Section)
    VALUES
    (p_UserId , p_PackageId , 'Cart');
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeleteFromCart
(
	IN p_UserId INT,
    IN p_PackageId INT
)
BEGIN
	DELETE FROM UserSection
    WHERE UserSection.UserId = p_UserId
    AND UserSection.PackageId = p_PackageId
	AND UserSection.Section = 'Cart';
END;
// DELIMITER ;

CALL DeleteFromCart(2 , 2);

DELIMITER //
CREATE PROCEDURE PushToCart
(
	IN p_UserId INT,
    IN p_PackageId INT
)
BEGIN
	DELETE FROM UserSection
    WHERE UserSection.UserId = p_UserId
    AND UserSection.PackageId = p_PackageId
    AND UserSection.Section = 'Wishlist';
    
    CALL AddToCart(p_UserId , p_PackageId);
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetWishlist
(
	IN p_UserId INT
)
BEGIN
	SELECT Packages.PackageName , Packages.PackageDesc , Packages.Source , Packages.Destination , Packages.FASL , Packages.Duration , Suppliers.SupplierName , Suppliers.SupplierContact , Suppliers.SupplierEmail
	FROM UserSection
	INNER JOIN Packages
	ON Packages.PackageId = UserSection.PackageId
	INNER JOIN Suppliers
	ON Suppliers.SupplierId = Packages.SupplierId
	WHERE UserSection.UserId = p_UserId
	AND UserSection.Section = 'Wishlist';
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetCart
(
	IN p_UserId INT
)
BEGIN
	SELECT Packages.PackageName , Packages.PackageDesc , Packages.Source , Packages.Destination , Packages.FASL , Packages.Duration , Suppliers.SupplierName , Suppliers.SupplierContact , Suppliers.SupplierEmail
	FROM UserSection
	INNER JOIN Packages
	ON Packages.PackageId = UserSection.PackageId
	INNER JOIN Suppliers
	ON Suppliers.SupplierId = Packages.SupplierId
	WHERE UserSection.UserId = p_UserId
	AND UserSection.Section = 'Cart';
END;
// DELIMITER ;

DROP PROCEDURE ConfirmBooking;;
DELIMITER //
CREATE PROCEDURE ConfirmBooking
(
	IN p_UserId INT,
    IN p_PackageId INT,
    IN StartDateTime DATETIME,
    IN TotalNumberOfPeople INT,
    IN Amount INT,
    IN PaymentMode VARCHAR(255)
)
BEGIN
	DECLARE CurrentUserBookingId INT;
	
    INSERT INTO Bookings
    (Bookings.UserId , Bookings.PackageId , Bookings.JourneyStartDatetime)
    VALUES
    (p_UserId , p_PackageId , StartDateTime);
    
    SELECT Bookings.BookingId 
    INTO CurrentUserBookingId
    FROM Bookings
    WHERE Bookings.UserId = p_UserId
    AND Bookings.PackageId = p_PackageId
    AND Bookings.JourneyStartDatetime = StartDateTime
    LIMIT 1;
	
	INSERT INTO Payments
    (Payments.BookingId , Payments.PaymentAmount , Payments.PaymentDatetime , Payments.PaymentMode , Payments.PaymentStatus)
    VALUES
    (CurrentUserBookingId , Amount , NOW() , PaymentMode , 'Approved');
    
    UPDATE Packages
    SET Packages.Quantity = Packages.Quantity - 1
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateUser
(
	IN p_UserId INT,
	IN p_UserName VARCHAR(255),
    IN p_UserPassword VARCHAR(255),
    IN p_UserPhoneNumber VARCHAR(255),
    IN p_UserDOB DATE,
    IN p_UserGender ENUM('Male', 'Female', 'Others'),

	IN p_AddressId INT,
    IN p_Address VARCHAR(255),
    IN p_City VARCHAR(255),
    IN p_State VARCHAR(255),
    IN p_Pincode INT,
    IN p_Lat VARCHAR(255),
    IN p_Lon VARCHAR(255)
)
BEGIN
	UPDATE Address
    SET Address.AddressDesc = p_Address,
    Address.City = p_City,
    Address.State = p_State,
    Address.Pincode = p_Pincode,
    Address.Lat = p_Lat,
    Address.Lon = p_Lon
    WHERE Address.AddressId = p_AddressId;
    
    UPDATE Users
    SET Users.UserName = p_UserName,
    Users.UserPassword = p_UserPassword,
    Users.UserPhoneNumber = p_UserPhoneNumber,
    Users.UserDOB = p_UserDOB,
    Users.UserGender = p_UserGender
    WHERE Users.UserId = p_UserId;
END;
// DELIMITER ;
