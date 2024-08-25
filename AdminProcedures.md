# Admin Procedures Documentation

This document describes the administrative stored procedures used in the project. For each procedure, a brief overview is provided.

## Procedures

### ApproveUser

This procedure updates a user's status to 'Approved' if the user’s registration time is more than 15 minutes old. It ensures that only users who have been registered long enough are approved.

**Parameters:**
- `UserEmail` (IN): The email of the user to be approved.
- `UserPassword` (IN): The password of the user to be approved.

**Effects:**
- Sets the `AdminStatus` of the user to 'Approved' in the `Users` table.

### ActivateSupplier

This procedure updates a supplier's status to 'Approved', effectively activating the supplier account.

**Parameters:**
- `p_SupplierId` (IN): The ID of the supplier to be activated.

**Effects:**
- Sets the `AdminStatus` of the supplier to 'Approved' in the `Suppliers` table.

### DeactivateSupplier

This procedure updates a supplier's status to 'Pending', effectively deactivating the supplier account.

**Parameters:**
- `p_SupplierId` (IN): The ID of the supplier to be deactivated.

**Effects:**
- Sets the `AdminStatus` of the supplier to 'Pending' in the `Suppliers` table.

### ActivateUser

This procedure updates a user's status to 'Approved', effectively activating the user account.

**Parameters:**
- `p_UserId` (IN): The ID of the user to be activated.

**Effects:**
- Sets the `AdminStatus` of the user to 'Approved' in the `Users` table.

### DeactivateUser

This procedure updates a user's status to 'Pending', effectively deactivating the user account.

**Parameters:**
- `p_UserId` (IN): The ID of the user to be deactivated.

**Effects:**
- Sets the `AdminStatus` of the user to 'Pending' in the `Users` table.

### AddCompanyProfit

This procedure calculates and updates the company's profit for a given package. The profit is set as 25% of the package price.

**Parameters:**
- `p_PackageId` (IN): The ID of the package for which the profit is to be calculated.

**Effects:**
- Updates the `CompanyProfit` field in the `Packages` table.

### ApprovePackage

This procedure updates the status of a package to 'Approved' and calculates the company profit for that package. It is intended for administrative use.

**Parameters:**
- `p_PackageId` (IN): The ID of the package to be approved.

**Effects:**
- Sets the `AdminStatus` of the package to 'Approved' in the `Packages` table.
- Calls `AddCompanyProfit` to update the company's profit for the package.

### DisapprovePackage

This procedure updates the status of a package to 'Pending'. It is intended for administrative use.

**Parameters:**
- `p_PackageId` (IN): The ID of the package to be disapproved.

**Effects:**
- Sets the `AdminStatus` of the package to 'Pending' in the `Packages` table.

