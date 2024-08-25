# General Procedures Documentation

This document describes the stored procedures used in the project. For each procedure, a brief overview is provided.

## Procedures

### GetSupplierInfo

This procedure retrieves detailed information about a supplier based on their email and password. It includes supplier details and address information.

**Parameters:**
- `SupplierEmail` (IN): The email of the supplier.
- `SupplierPassword` (IN): The password of the supplier.

**Returns:**
- Supplier details including `SupplierId`, `SupplierName`, `SupplierContact`, `SupplierEmail`, `SupplierGSTNumber`, `SupplierAadhar`, `AdminStatus`, and address information (`Address`, `City`, `State`, `Pincode`).

### GetUserInfo

This procedure retrieves detailed information about a user based on their email and password. It also calls another procedure to approve the user before retrieving the information.

**Parameters:**
- `UserEmail` (IN): The email of the user.
- `UserPassword` (IN): The password of the user.

**Returns:**
- User details including `UserId`, `UserName`, `UserPhoneNumber`, `UserEmail`, `UserDOB`, `UserGender`, `AdminStatus`, and address information (`Address`, `City`, `State`, `Pincode`).

### GetAvailablePackages

This procedure retrieves a list of packages that are available for booking. It filters out packages that are not approved or not active.

**Returns:**
- A list of available packages with details such as `PackageId`, `SupplierId`, `PackageName`, `PackageDesc`, `Source`, `Destination`, `FASL`, `Duration`, `PackagePrice`, `CompanyProfit`, `Quantity`, `SupplierStatus`, and `AdminStatus`.

### CheckSupplierGST

This procedure checks if a given GST number is already registered in the system.

**Parameters:**
- `GSTNumber` (IN): The GST number to check.
- `RegisteredGSTNumberCount` (OUT): The count of registered suppliers with the given GST number.

**Returns:**
- The count of registered suppliers with the specified GST number.

### AddPackage

This procedure adds a new package to the `Packages` table and returns the ID of the newly added package.

**Parameters:**
- `p_SupplierId` (IN): The ID of the supplier adding the package.
- `p_PackageName` (IN): The name of the package.
- `p_PackageDesc` (IN): A description of the package.
- `p_Source` (IN): The source location of the package.
- `p_Destination` (IN): The destination location of the package.
- `p_FASL` (IN): A four-character code for the package.
- `p_Duration` (IN): The duration of the package.
- `p_PackagePrice` (IN): The price of the package.
- `p_Quantity` (IN): The quantity available for the package.
- `p_PackageId` (OUT): The ID of the newly added package.

**Returns:**
- The ID of the newly added package.

