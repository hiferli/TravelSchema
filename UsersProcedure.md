# Users Procedures Documentation

This document describes the stored procedures related to user operations in the project. Each procedure is briefly described below.

## Procedures

### RegisterUser

This procedure registers a new user by inserting their details into the `Users` table and their address into the `Address` table. It handles duplicate address entries and ensures that the user is linked to the correct address.

**Parameters:**
- `p_UserName` (IN): The name of the user.
- `p_UserEmail` (IN): The email of the user.
- `p_UserPassword` (IN): The password for the user's account.
- `p_UserPhoneNumber` (IN): The phone number of the user.
- `p_UserDOB` (IN): The date of birth of the user.
- `p_UserGender` (IN): The gender of the user (can be 'Male', 'Female', or 'Others').
- `p_Address` (IN): The address of the user.
- `p_City` (IN): The city of the user.
- `p_State` (IN): The state of the user.
- `p_Pincode` (IN): The pincode of the user's address.
- `p_Lat` (IN): The latitude of the user's address.
- `p_Lon` (IN): The longitude of the user's address.
- `p_UserId` (OUT): The ID of the newly registered user.

**Effects:**
- Inserts a new address into the `Address` table if it does not already exist.
- Inserts a new user into the `Users` table with the associated address ID.
- Returns the `UserId` of the newly registered user.

