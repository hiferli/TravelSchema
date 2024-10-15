CREATE DATABASE IF NOT EXISTS TafriHolidays;
USE TafriHolidays;

CREATE TABLE IF NOT EXISTS Address
(
	AddressId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    AddressDesc VARCHAR(255) NOT NULL,
    City VARCHAR(255),
    State VARCHAR(255),
    Pincode INT NOT NULL,
    Lat VARCHAR(255),
    Lon VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Suppliers
(
	SupplierId INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	SupplierName VARCHAR(255) NOT NULL,
    SupplierContact VARCHAR(255) NOT NULL UNIQUE,
    SupplierEmail VARCHAR(255) NOT NULL UNIQUE,
    SupplierPassword VARCHAR(255) NOT NULL,
    SupplierGSTNumber VARCHAR(255) NOT NULL UNIQUE, 	
    SupplierAadhar VARCHAR(255) NOT NULL UNIQUE,
    AddressId INT NOT NULL,
    AdminStatus ENUM('Pending' , 'Approved') DEFAULT 'Pending',
    
	FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);

CREATE TABLE IF NOT EXISTS Users
(
	UserId INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    UserName VARCHAR(255) NOT NULL,
    UserEmail VARCHAR(255) NOT NULL UNIQUE,
    UserPassword VARCHAR(255) NOT NULL,
    UserPhoneNumber VARCHAR(255) NOT NULL UNIQUE,
    AddressId INT NOT NULL,
    UserDOB DATE,
    UserGender ENUM('Male' , 'Female' , 'Others'),
    DateTimeOfRegistration DATETIME DEFAULT CURRENT_TIMESTAMP,
    AdminStatus ENUM('Approved' , 'Pending') DEFAULT 'Pending',
    
    FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);

CREATE TABLE IF NOT EXISTS Packages
(
	PackageId INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    SupplierId INT NOT NULL,
    PackageName VARCHAR(255) NOT NULL,
    PackageDesc VARCHAR(255),
    Source VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL,
    FASL VARCHAR(4) NOT NULL,
    Duration INT NOT NULL,
    PackagePrice INT NOT NULL,
    CompanyProfit INT NOT NULL DEFAULT 5000,
    Quantity INT NOT NULL DEFAULT 1,
    SupplierStatus ENUM('Active' , 'Inactive') DEFAULT 'Active',
    AdminStatus ENUM('Approved' , 'Pending') DEFAULT 'Pending',
    
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId)
);

CREATE TABLE IF NOT EXISTS Bookings
(
	BookingId INT AUTO_INCREMENT NOT NULL PRIMARY KEY UNIQUE,
    UserId INT NOT NULL,
    PackageId INT NOT NULL,
    JourneyStartDatetime DATETIME NOT NULL,
    SupplierStatus ENUM('Confirmed' , 'Under Process') DEFAULT 'Under Process',
    
	FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (PackageId) REFERENCES Packages(PackageId)
);

CREATE TABLE IF NOT EXISTS Payments 
(
	PaymentId INT AUTO_INCREMENT NOT NULL PRIMARY KEY UNIQUE,
	BookingId INT NOT NULL,
    PaymentAmount INT NOT NULL,
    PaymentDatetime DATETIME NOT NULL,
    PaymentMode VARCHAR(255),
    PaymentStatus ENUM('Approved' , 'Pending') DEFAULT 'Pending',

	FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId)
);

CREATE TABLE IF NOT EXISTS Travellers
(
	BookingId INT NOT NULL,
    PersonName VARCHAR(255) NOT NULL,
    PersonPhoneNumber VARCHAR(255),
    AddressId INT,
    
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId)
);

CREATE TABLE IF NOT EXISTS UserSection
(
	UserId INT NOT NULL,
    PackageId INT NOT NULL,
    Section VARCHAR(255),
    
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (PackageId) REFERENCES Packages(PackageId)
);

CREATE TABLE IF NOT EXISTS AdminDetails 
(
	adminId INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
	adminEmail VARCHAR(255) NOT NULL UNIQUE,
    adminPassword VARCHAR(255) NOT NULL
);