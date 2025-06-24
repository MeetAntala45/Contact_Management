Contact Management System
=========================

This project is a contact management system built using ASP.NET Web . which allows users to manage their contacts, including adding, editing, searching, and deleting contacts.

Project Details/overview
----------------
The Contact Management System in that users can:
- View: List all their contacts.
- Add: Add new contacts to the system.
- Edit: Modify existing contact details.
- Delete: Remove contacts from the system.
- Search: Find contacts by name or phone number.

Database Setup
--------------
1. Create the following tables in your SQL Server database:

   Contacts Table:
   ----------------
   CREATE TABLE Contacts (
       ContactID INT IDENTITY(1,1) PRIMARY KEY,
       ContactName NVARCHAR(100) NOT NULL,
       ContactPhone NVARCHAR(15) NOT NULL,
       UserID INT NOT NULL,
       FOREIGN KEY (UserID) REFERENCES Users(UserID)
   );

   Users Table:
   ------------
   CREATE TABLE Users (
       UserID INT IDENTITY(1,1) PRIMARY KEY,
       Username NVARCHAR(50) UNIQUE NOT NULL,
       Password NVARCHAR(255) NOT NULL
   );

2. Insert sample data for testing:

   Insert Sample Users:
   ---------------------
   INSERT INTO Users (Username, Password) VALUES ('user1', 'password1');
   INSERT INTO Users (Username, Password) VALUES ('user2', 'password2');

   Insert Sample Contacts:
   ------------------------
   INSERT INTO Contacts (ContactName, ContactPhone, UserID) VALUES ('John Doe', '1234567890', 1);
   INSERT INTO Contacts (ContactName, ContactPhone, UserID) VALUES ('Jane Smith', '0987654321', 1);

Configuration
-------------
1. Update the connection string in your Web.config file with your database details:

   <connectionStrings>
	<add name="ContactDB" connectionString="Data Source=LAPTOP-3PO353FA\SQLEXPRESS;Initial Catalog=ContactDB;Integrated Security=True" providerName="System.Data.SqlClient" />
</connectionStrings>

2. Ensure the Contact.aspx and Contact.aspx.cs files are correctly configured to interact with your database.

For Run the Project
-------------------
1. Open Visual Studio and load the solution file.
2. Build the project to ensure there are no compilation errors.
3. Run the project 

Usage
------
1. Login: Users must log in to access the contact management features.
2. View Contacts: After logging in, users can view their contacts in a GridView.
3. Add Contacts: Click the "Add" button to open the form to add a new contact.
4. Edit Contacts: Click the "Edit" button next to a contact to modify its details.
5. Delete Contacts: Click the "Delete" button next to a contact to remove it from the system.
6. Search Contacts: Use the search functionality to find contacts by name or phone number.
