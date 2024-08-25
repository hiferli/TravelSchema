# Database Schema Documentation

This document provides the schema definition for the database tables used in the project. Below is the detailed schema for the `Address` table.

## Tables

### Address Table

The `Address` table stores information related to addresses, including city, state, and geolocation data.

#### Schema Definition

```sql
CREATE TABLE IF NOT EXISTS Address
(
    AddressId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(255),
    State VARCHAR(255),
    Pincode INT NOT NULL,
    Lat VARCHAR(255),
    Lon VARCHAR(255)
);
```

#### Columns

- **AddressId**: An integer that uniquely identifies each address. It is the primary key and is auto-incremented.
- **Address**: A string that holds the full address (e.g., street, house number).
- **City**: A string that stores the name of the city.
- **State**: A string that stores the name of the state.
- **Pincode**: An integer that represents the postal code.
- **Lat**: A string that stores the latitude for the location.
- **Lon**: A string that stores the longitude for the location.

#### Notes

- The `Address` field is required and cannot be null.
- The `Pincode` field is also required and cannot be null.
- Latitude and Longitude fields (`Lat`, `Lon`) are stored as strings to accommodate different formats and precision.

### Suppliers Table

The `Suppliers` table stores information about suppliers, including contact details and address information.

#### Schema Definition

```sql
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
    AdminStatus ENUM('Pending', 'Approved') DEFAULT 'Pending',
    
    FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);
```

#### Columns

- **SupplierId**: An integer that uniquely identifies each supplier. It is the primary key and is auto-incremented.
- **SupplierName**: A string that stores the name of the supplier.
- **SupplierContact**: A string that stores the contact number of the supplier. This is unique.
- **SupplierEmail**: A string that stores the email of the supplier. This is unique.
- **SupplierPassword**: A string that stores the password for the supplier's account.
- **SupplierGSTNumber**: A string that stores the GST number of the supplier. This is unique.
- **SupplierAadhar**: A string that stores the Aadhar number of the supplier. This is unique.
- **AddressId**: An integer that references the `AddressId` from the `Address` table.
- **AdminStatus**: An enum that indicates whether the supplier's account is 'Pending' or 'Approved'. The default value is 'Pending'.

### Users Table

The `Users` table stores information about users, including their contact details and address information.

#### Schema Definition

```sql
CREATE TABLE IF NOT EXISTS Users
(
    UserId INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    UserName VARCHAR(255) NOT NULL,
    UserEmail VARCHAR(255) NOT NULL UNIQUE,
    UserPassword VARCHAR(255) NOT NULL,
    UserPhoneNumber VARCHAR(255) NOT NULL UNIQUE,
    AddressId INT NOT NULL,
    UserDOB DATE,
    UserGender ENUM('Male', 'Female', 'Others'),
    DateTimeOfRegistration DATETIME DEFAULT CURRENT_TIMESTAMP,
    AdminStatus ENUM('Approved', 'Pending') DEFAULT 'Pending',
    
    FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);
```

#### Columns

- **UserId**: An integer that uniquely identifies each user. It is the primary key and is auto-incremented.
- **UserName**: A string that stores the name of the user.
- **UserEmail**: A string that stores the email of the user. This is unique.
- **UserPassword**: A string that stores the password for the user's account.
- **UserPhoneNumber**: A string that stores the phone number of the user. This is unique.
- **AddressId**: An integer that references the `AddressId` from the `Address` table.
- **UserDOB**: A date field that stores the date of birth of the user.
- **UserGender**: An enum that stores the gender of the user. Possible values are 'Male', 'Female', and 'Others'.
- **DateTimeOfRegistration**: A datetime field that stores the registration date and time of the user. The default value is the current timestamp.
- **AdminStatus**: An enum that indicates whether the user's account is 'Approved' or 'Pending'. The default value is 'Pending'.

### Packages Table

The `Packages` table stores information about packages offered by suppliers, including details like source, destination, and pricing.

#### Schema Definition

```sql
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
    SupplierStatus ENUM('Active', 'Inactive') DEFAULT 'Active',
    AdminStatus ENUM('Approved', 'Pending') DEFAULT 'Pending',
    
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId)
);
```

#### Columns

- **PackageId**: An integer that uniquely identifies each package. It is the primary key and is auto-incremented.
- **SupplierId**: An integer that references the `SupplierId` from the `Suppliers` table.
- **PackageName**: A string that stores the name of the package.
- **PackageDesc**: A string that provides a description of the package.
- **Source**: A string that stores the source location of the package.
- **Destination**: A string that stores the destination location of the package.
- **FASL**: A string that stores the four-character code for the package.
- **Duration**: An integer that stores the duration of the package.
- **PackagePrice**: An integer that stores the price of the package.
- **CompanyProfit**: An integer that stores the profit amount for the company. The default value is 5000.
- **Quantity**: An integer that stores the quantity available for the package. The default value is 1.
- **SupplierStatus**: An enum that indicates whether the package is 'Active' or 'Inactive'. The default value is 'Active'.
- **AdminStatus**: An enum that indicates whether the package is 'Approved' or 'Pending'. The default value is 'Pending'.
