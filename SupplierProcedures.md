# Supplier Procedures Documentation

This document describes the stored procedures related to supplier operations in the project. For each procedure, a brief overview is provided.

## Procedures

### RegisterSupplier

This procedure registers a new supplier by inserting their details into the `Suppliers` table and their address into the `Address` table. It handles duplicate address entries and ensures that the supplier is linked to the correct address.

**Parameters:**
- `p_SupplierName` (IN): The name of the supplier.
- `p_SupplierContact` (IN): The contact number of the supplier.
- `p_SupplierEmail` (IN): The email of the supplier.
- `p_SupplierPassword` (IN): The password for the supplier's account.
- `p_SupplierGSTNumber` (IN): The GST number of the supplier.
- `p_SupplierAadhar` (IN): The Aadhar number of the supplier.
- `p_Address` (IN): The address of the supplier.
- `p_City` (IN): The city of the supplier.
- `p_State` (IN): The state of the supplier.
- `p_Pincode` (IN): The pincode of the supplier's address.
- `p_Lat` (IN): The latitude of the supplier's address.
- `p_Lon` (IN): The longitude of the supplier's address.
- `p_SupplierId` (OUT): The ID of the newly registered supplier.

**Effects:**
- Inserts a new address into the `Address` table if it does not already exist.
- Inserts a new supplier into the `Suppliers` table with the associated address ID.
- Returns the `SupplierId` of the newly registered supplier.

### ActivatePackage

This procedure activates a package by updating its status in the `Packages` table. It is intended for use by suppliers.

**Parameters:**
- `p_PackageId` (IN): The ID of the package to be activated.

**Effects:**
- Sets the `SupplierStatus` of the package to 'Active' in the `Packages` table.

### DeactivatePackage

This procedure deactivates a package by updating its status in the `Packages` table. It also sets the `AdminStatus` of the package to 'Pending'.

**Parameters:**
- `p_PackageId` (IN): The ID of the package to be deactivated.

**Effects:**
- Sets the `SupplierStatus` of the package to 'Inactive' and the `AdminStatus` to 'Pending' in the `Packages` table.

