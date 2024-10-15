DELIMITER //
CREATE PROCEDURE ApproveUser
(
	IN UserEmail VARCHAR(255),
    IN UserPassword VARCHAR(255)
)
BEGIN
	UPDATE Users
	SET AdminStatus = 'Approved'
    WHERE Users.UserEmail = UserEmail
    AND Users.UserPassword = UserPassword
    AND TIMESTAMPDIFF(MINUTE, Users.DateTimeOfRegistration , NOW()) > 15;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActivateSupplier
(
	IN p_SupplierId INT
)
BEGIN
	UPDATE Suppliers
    SET Suppliers.AdminStatus = 'Approved'
    WHERE Suppliers.SupplierId = p_SupplierId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeactivateSupplier
(
	IN p_SupplierId INT
)
BEGIN
	UPDATE Suppliers
    SET Suppliers.AdminStatus = 'Pending'
    WHERE Suppliers.SupplierId = p_SupplierId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActivateUser
(
	IN p_UserId INT
)
BEGIN
	UPDATE Users
    SET Users.AdminStatus = 'Approved'
    WHERE Users.UserId = p_UserId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeactivateUser
(
	IN p_UserId INT
)
BEGIN
	UPDATE Users
    SET Users.AdminStatus = 'Pending'
    WHERE Users.UserId = p_UserId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddCompanyProfit
(
	IN p_PackageId INT
)
BEGIN
	UPDATE Packages 
    SET Packages.CompanyProfit = Packages.PackagePrice * 0.25
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE ApprovePackage -- For Admins
(
	IN p_PackageId INT
)
BEGIN
	UPDATE Packages 
    SET Packages.AdminStatus = 'Approved'
    WHERE Packages.PackageId = p_PackageId;
    
    CALL AddCompanyProfit(p_PackageId);
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE DisapprovePackage -- For Admins
(
	IN p_PackageId INT
)
BEGIN
	UPDATE Packages 
    SET Packages.AdminStatus = 'Pending'
    WHERE Packages.PackageId = p_PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetCompanyProfits
()
BEGIN
	SELECT 
	Packages.PackageId , Packages.PackagePrice , Packages.CompanyProfit AS 'Margin' , Count(Packages.PackageId) AS 'Total Bookings' , Packages.CompanyProfit * Count(Packages.PackageId) AS 'Total Profit'
	FROM Bookings 
	INNER JOIN Packages 
	ON Bookings.PackageId = Packages.PackageId 
	GROUP BY Packages.PackageId;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetRevenueByPackage
()
BEGIN
	SELECT 
	Packages.PackageId , Packages.SupplierId , Packages.PackageName , CalculateSupplierProfitByPackage(Packages.PackageId) AS 'SupplierProfit' , CalculateRevenueByPackage(Packages.PackageId) AS 'Revenue'
	FROM Packages;
END;
// DELIMITER ;

DELIMITER //
CREATE FUNCTION CalculateRevenueByPackage
( p_PackageId INT ) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE revenue INT;
    
    SELECT IFNULL(SUM(Packages.CompanyProfit), 0)
    INTO revenue
    FROM Packages 
    INNER JOIN Bookings 
    ON Bookings.PackageId = Packages.PackageId 
    WHERE Packages.PackageId = p_PackageId;
    
    RETURN revenue;
END;
// DELIMITER ;

DELIMITER //
CREATE FUNCTION CalculateSupplierProfitByPackage
( p_PackageId INT ) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE revenue INT;
    
    SELECT IFNULL(SUM(Packages.PackagePrice), 0)
    INTO revenue
    FROM Packages 
    INNER JOIN Bookings 
    ON Bookings.PackageId = Packages.PackageId 
    WHERE Packages.PackageId = p_PackageId;
    
    RETURN revenue;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE LoginAdmin
()
BEGIN
END;
// DELIMITER ;
