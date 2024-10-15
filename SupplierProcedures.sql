DELIMITER //
CREATE PROCEDURE RegisterSupplier
(
    IN p_SupplierName VARCHAR(255),
    IN p_SupplierContact VARCHAR(255),
    IN p_SupplierEmail VARCHAR(255),
    IN p_SupplierPassword VARCHAR(255),
    IN p_SupplierGSTNumber VARCHAR(255),
    IN p_SupplierAadhar VARCHAR(255),
    
    IN p_Address VARCHAR(255),
    IN p_City VARCHAR(255),
    IN p_State VARCHAR(255),
    IN p_Pincode INT,
    IN p_Lat VARCHAR(255),
    IN p_Lon VARCHAR(255)
    
    -- Was returning PackageId before the update
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

    INSERT INTO Suppliers
    (SupplierName, SupplierContact, SupplierEmail, SupplierPassword, SupplierGSTNumber, SupplierAadhar, AddressId)
    VALUES
    (p_SupplierName, p_SupplierContact, p_SupplierEmail, p_SupplierPassword, p_SupplierGSTNumber, p_SupplierAadhar, v_RegisteredAddressId);

END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActivatePackage -- For Supplier
(
	IN p_PackageId INT
)
BEGIN
	UPDATE Packages 
    SET Packages.SupplierStatus = 'Active'
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeactivatePackage -- For Supplier
(
	IN p_PackageId INT
)
BEGIN
	UPDATE Packages 
    SET Packages.SupplierStatus = 'Inactive'
    WHERE Packages.PackageId = p_PackageId;
    
    UPDATE Packages 
    SET Packages.AdminStatus = 'Pending'
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DROP PROCEDURE AddPackage;
DELIMITER //
CREATE PROCEDURE AddPackage
(
	IN p_SupplierId INT,
    IN p_PackageName VARCHAR(255),
    IN p_PackageDesc VARCHAR(255),
	IN p_Source VARCHAR(255),
    IN p_Destination VARCHAR(255),
    IN p_FASL VARCHAR(4), 
    IN p_Duration INT,
    IN p_PackagePrice INT,
    IN p_Quantity INT
    
    -- Was returning PackageId before update
)
BEGIN
	INSERT INTO Packages
    ( Packages.SupplierId , Packages.PackageName , Packages.PackageDesc , Packages.Source , Packages.Destination , Packages.FASL , Packages.Duration , Packages.PackagePrice , Packages.Quantity )
    VALUES
    ( p_SupplierId , p_PackageName , p_PackageDesc , p_Source , p_Destination , p_FASL , p_Duration , p_PackagePrice , p_Quantity);
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdatePackage
(
	IN p_PackageId INT,
    IN p_SupplierId INT,
    IN p_PackageName VARCHAR(255),
    IN p_PackageDesc VARCHAR(255),
	IN p_Source VARCHAR(255),
    IN p_Destination VARCHAR(255),
    IN p_FASL VARCHAR(4), 
    IN p_Duration INT,
    IN p_PackagePrice INT,
    IN p_Quantity INT
)
BEGIN
	UPDATE Packages 
    SET Packages.SupplierId = p_SupplierId,
    Packages.PackageName = p_PackageName,
    Packages.PackageDesc = p_PackageDesc,
    Packages.Source = p_Source,
    Packages.Destination = p_Destination,
    Packages.FASL = p_FASL,
    Packages.Duration = p_Duration,
    Packages.PackagePrice = p_PackagePrice,
    Packages.Quantity = p_Quantity
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetSupplierProfits
()
BEGIN
	SELECT 
	Packages.PackageId , Packages.PackagePrice , Count(Packages.PackageId) AS 'Total Bookings' , Packages.PackagePrice * Count(Packages.PackageId) AS 'Total Profit'
	FROM Bookings 
	INNER JOIN Packages 
	ON Bookings.PackageId = Packages.PackageId 
	GROUP BY Packages.PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllPackagesBySupplier
(
	IN p_SupplierId INT
)
BEGIN
	SELECT Packages.PackageId , Packages.PackageName , Packages.PackageDesc , Packages.Source , Packages.Destination , Packages.FASL , Packages.Duration , Packages.PackagePrice , Packages.Quantity , Packages.SupplierStatus , Packages.AdminStatus 
	FROM Packages 
	WHERE Packages.SupplierId = p_SupplierId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetSupplierRevenue
(
	IN p_SupplierId INT
)
BEGIN
	SELECT 
	SUM(Packages.PackagePrice) 
	FROM Bookings
	INNER JOIN Packages
	ON Packages.PackageId = Bookings.PackageId
	WHERE Packages.SupplierId = p_SupplierId;
END
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetBookingsBySupplierId
(
	IN p_SupplierId INT
)
BEGIN
	SELECT 
	Bookings.BookingId , Bookings.UserId , Bookings.JourneyStartDatetime , Packages.PackageId , Packages.PackageName , Packages.Source , Packages.Destination , Packages.FASL , Packages.SupplierStatus , Packages.AdminStatus
	FROM Bookings
	INNER JOIN Packages
	ON Bookings.PackageId = Packages.PackageId
	WHERE Packages.SupplierId = p_SupplierId;
END;
// DELIMITER ;