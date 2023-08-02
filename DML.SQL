--How do you insert a new row into a table called "staff" with columns (ID, Name, Age, Department)?

INSERT INTO sales.staff  (ID, full_name, Age, salary)
VALUES (1, 'John Doe', 30, 5000)

---to see the available tables in the databse 

SELECT name
FROM sys.tables;

--How do you update the "Salary" column of an employee with ID 1 in the "sales.staff" table?
UPDATE sales.staff
SET Salary = 6000
WHERE ID = 1;

--What is the difference between the "DELETE" and "TRUNCATE" statements in SQL?

/*The "DELETE" and "TRUNCATE" statements in SQL are used to remove data from a table, 
but they have some key differences in terms of their behavior and functionality:*/
/*DELETE Statement:
The DELETE statement is used to remove one or more rows from a table based on a 
specified condition (using a WHERE clause). It allows you to selectively delete 
specific rows from the table.

The DELETE statement is a DML (Data Manipulation Language) operation and 
can be rolled back using the transaction control commands (e.g., ROLLBACK) 
if it is executed within a transaction.

The DELETE statement generates individual row delete operations, which means
it can trigger associated triggers or constraints for each row deletion.

DELETE is slower than TRUNCATE, especially when deleting a large number of
rows, as it involves logging each deleted row and maintaining the transaction log.

Example of DELETE statement:*/

DELETE FROM sales.staff WHERE salary = 6000;

/*TRUNCATE Statement:
The TRUNCATE statement is used to remove all the rows from a table. 
It doesn't use a WHERE clause, and it removes all data in one operation.

TRUNCATE is also a DDL (Data Definition Language) operation, meaning 
it is used for structural changes in the database. As a result, TRUNCATE 
cannot be rolled back using the standard transaction control commands.

TRUNCATE doesn't generate individual row delete operations, and it doesn't 
trigger associated triggers or constraints during the operation, which makes 
it faster and more efficient than DELETE, especially when deleting a large number of rows.

TRUNCATE resets the table's identity or auto-increment columns to their initial seed value, 
whereas DELETE does not reset these columns.

Example of TRUNCATE statement:*/

TRUNCATE TABLE sales.staff;

/*In summary, use the DELETE statement when you need to selectively remove specific rows based on 
a condition, and use the TRUNCATE statement when you want to quickly remove all the data from 
a table without the need for individual row deletions and associated triggers/constraints. 
Be cautious when using TRUNCATE, as it cannot be undone, and it resets identity columns. 
Always double-check the conditions and ensure you have proper backups before performing any 
mass deletion operations.*/

--Write a SQL query to retrieve all employees whose ages are between 25 and 35.

SELECT *
FROM sales.staff
WHERE Age >= 25 AND Age <= 35;

/*How do you delete all records from a table named "Customers" where the "Status" column is set to "Inactive"?
For example, if your "Customers" table looks like this:

ID	Name	    Status
1	John Smith	Active
2	Jane Doe	Inactive
3	Bob Johnson	Inactive
4	Mary Brown	Active */


DELETE FROM Customers
WHERE Status = 'Inactive';

/*After the DELETE operation, the "Customers" table will look like this:

ID	Name	    Status
1	John Smith	Active
4	Mary Brown	Active
*/

/*Write a SQL statement to update the "Quantity" column of a table named "Products" 
by adding 10 to the existing values.*/

UPDATE Products
SET Quantity = Quantity + 10;

--Explain the purpose of the "ROLLBACK" statement in SQL.
/*The "ROLLBACK" statement in SQL is used to undo or cancel the changes made within a transaction. 
A transaction is a sequence of one or more SQL statements that are treated as a single unit of work. 
The purpose of using transactions is to ensure that a group of related database operations either 
all succeed or all fail together, maintaining data integrity and consistency.

When you issue SQL commands within a transaction, the changes are not immediately committed to the database.
Instead, they are held in a temporary space called the "transaction log" or "undo log." 
The transaction remains in a pending state until you either commit it, making the changes permanent,
or rollback the transaction, undoing the changes.

The "ROLLBACK" statement is used to cancel all the changes made within a transaction since it began. 
It reverts the database to the state it was in at the start of the transaction, effectively 
"rolling back" the changes. After a rollback, it is as if the transaction never occurred, 
and the database returns to its original state.

Here's an example of using the "ROLLBACK" statement:*/

BEGIN TRANSACTION;

UPDATE Account
SET Balance = Balance - 100
WHERE AccountNumber = '123';

INSERT INTO TransactionLog (AccountNumber, Amount)
VALUES ('123', -100);

-- If something goes wrong, you can rollback the transaction
ROLLBACK;

--How do you insert multiple records into a table using a single SQL statement?
/*To insert multiple records into a table using a single SQL statement, 
you can use the SQL INSERT INTO statement with the VALUES clause. 
The VALUES clause allows you to specify multiple sets of
values to be inserted into the table in one go.*/

--Write a SQL query to find the names of customers who have placed orders in the "Orders" table.

/*To find the names of customers who have placed orders in the "Orders" table, 
you can use a SQL SELECT statement with a JOIN. Assuming you have a "Customers"
table containing customer information with a column "CustomerName" and an "Orders" 
table containing order information with a column "CustomerID" representing the customer 
who placed the order,you can use the following SQL query:*/

SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

/*In this query, we are performing an INNER JOIN between the "Customers" 
table (aliased as c) and the "Orders" table (aliased as o) based on the common 
column "CustomerID". The JOIN operation links the two tables together, 
allowing us to retrieve the customer names who have placed orders.

The DISTINCT keyword is used to eliminate duplicate names from the result set, 
ensuring that each customer name appears only once.*/

--What is the purpose of the "COMMIT" statement in SQL, and when is it typically used?

/*The "COMMIT" statement in SQL is used to make the changes made within a transaction 
permanent and visible to other transactions. A transaction is a sequence of one or more 
SQL statements that are treated as a single unit of work. The purpose of using transactions 
is to ensure that a group of related database operations either all succeed or all fail together,
maintaining data integrity and consistency.

When you issue SQL commands within a transaction, the changes are not immediately committed to 
the database. Instead, they are held in a temporary space called the "transaction log" or "undo 
log." The transaction remains in a pending state until you either commit it or rollback the transaction.

The "COMMIT" statement is used to finalize a transaction and permanently apply 
the changes made within the transaction to the database. After the "COMMIT" 
statement is executed, the changes are written to the database, and they become 
visible to other transactions. Once committed, the transaction is completed, and 
it cannot be undone or rolled back.*/

BEGIN TRANSACTION;

UPDATE Account
SET Balance = Balance - 100
WHERE AccountNumber = '123';

INSERT INTO TransactionLog (AccountNumber, Amount)
VALUES ('123', -100);

-- If everything is fine, you can commit the transaction
COMMIT;

/*The "COMMIT" statement in SQL is used to make the changes made within a transaction permanent and visible to other transactions. A transaction is a sequence of one or more SQL statements that are treated as a single unit of work. The purpose of using transactions is to ensure that a group of related database operations either all succeed or all fail together, maintaining data integrity and consistency.

When you issue SQL commands within a transaction, the changes are not immediately committed to the database. Instead, they are held in a temporary space called the "transaction log" or "undo log." The transaction remains in a pending state until you either commit it or rollback the transaction.

The "COMMIT" statement is used to finalize a transaction and permanently apply the changes made within the transaction to the database. After the "COMMIT" statement is executed, the changes are written to the database, and they become visible to other transactions. Once committed, the transaction is completed, and it cannot be undone or rolled back.

Here's an example of using the "COMMIT" statement:*/


BEGIN TRANSACTION;

UPDATE Account
SET Balance = Balance - 100
WHERE AccountNumber = '123';

INSERT INTO TransactionLog (AccountNumber, Amount)
VALUES ('123', -100);

-- If everything is fine, you can commit the transaction
COMMIT;

/*In this example, we start a transaction using BEGIN TRANSACTION. We then update the balance of 
an account and insert a record into a transaction log table. If everything is executed correctly 
and there are no errors, we can use the "COMMIT" statement to permanently apply the changes to the database.

The "COMMIT" statement ensures that the changes made within a transaction are consistently applied 
to the database, and other transactions can now see these changes. It helps to maintain data integrity 
by enforcing the all-or-nothing principle of transactions.

It's important to note that not all databases support transactions, and the behavior and 
syntax of the "COMMIT" statement might vary depending on the database management system you are 
using. However, the concept of committing a transaction to make changes permanent is fundamental 
to the ACID (Atomicity, Consistency, Isolation, Durability) properties of database systems that 
support transactions.*/


/*How do you update the "Email" column of a table named "Contacts" 
with the value 'N/A' for all records where the "Email" is currently NULL?*/

/*To update the "Email" column of the "Contacts" table with the value 'N/A' for all records where the "Email" is currently NULL, you can use the SQL UPDATE statement along with the WHERE clause. Here's the SQL query:
*/

UPDATE Contacts
SET Email = 'N/A'
WHERE Email IS NULL;

/*In this query, the SET clause updates the "Email" column to 'N/A' for all rows where the 
"Email" is currently NULL. 
The WHERE clause filters the rows to include only those where the "Email" column is NULL.

The IS NULL condition checks for NULL values in the "Email" column, 
as standard comparison operators (e.g., =, <, >) cannot be used to directly compare NULL values. 
The IS NULL operator specifically checks for NULL values.

When you execute this SQL statement, it will update all records in the 
"Contacts" table where the "Email" is NULL, setting their "Email" values to 'N/A'.*/

--Explain the difference between "UNDO" and "REDO" operations in the context of DML.

/*UNDO Operation:
The "UNDO" operation is related to the concept of rollback and provides a way to revert or 
undo changes made during a transaction. When you perform a DML operation (such as INSERT, 
UPDATE, DELETE) within a transaction, the changes are temporarily stored in the transaction 
log or undo log. If the transaction is rolled back (either explicitly using 
ROLLBACK or implicitly due to an error or transaction abort), the UNDO operation is used to
revert the changes made during the transaction, restoring the database to its state before 
the transaction started.
For example, consider a transaction that updates the balance of an account but encounters an 
error and is rolled back before committing. The UNDO operation will be used to revert the update 
made during the transaction, bringing the balance back to its original value.

REDO Operation:
The "REDO" operation is related to the concept of recovery and provides a way to reapply 
changes made during a transaction in case of system failure or crash. When a DML operation 
modifies data, the changes are first written to the database buffer in memory and later flushed to disk. 
The REDO operation is used to reapply those changes from the database log in case they were not 
yet permanently written to disk before a failure occurred. This ensures that all committed changes 
are re-executed and made durable in the database, maintaining data consistency even after a system crash.
For example, consider a transaction that performs an INSERT operation, adding a new record to a table.
Before the changes are written to disk, a system crash occurs. During recovery, the REDO operation will 
be used to reapply the INSERT operation from the database log, adding the new record to the table and 
making it permanent.

In summary, "UNDO" is used for rollback to revert changes made within a transaction that is not committed, 
while "REDO" is used for recovery to reapply changes made within a committed transaction in case of system 
failure or crash. Both UNDO and REDO are essential components of transaction management and recovery 
mechanisms, ensuring data consistency and integrity in the database.*/


--Write a SQL query to retrieve the top 5 highest-paid employees from the "EmployeeDetails" table.

/*To retrieve the top 5 highest-paid employees from the "EmployeeDetails" table, 
you can use the SQL SELECT statement along with the ORDER BY clause and the LIMIT or 
TOP clause (depending on the database system you are using). Here's an example using the LIMIT clause, 
which is common in many database systems:*/

Copy code
SELECT *
FROM EmployeeDetails
ORDER BY Salary DESC
LIMIT 5;

/*In this query, we are selecting all columns (*) from the "EmployeeDetails" table. 
The ORDER BY Salary DESC clause sorts the rows in descending order based on the "Salary" 
column, meaning the highest-paid employees will appear first. Finally, the LIMIT 5 clause 
restricts the result set to only the top 5 rows, effectively retrieving the 5 highest-paid employees.

Please note that some database systems, such as SQL Server or MS Access, use the TOP 
clause instead of LIMIT. In those cases, the query would look like this:*/

SELECT TOP 5 *
FROM EmployeeDetails
ORDER BY Salary DESC;

/*The result of either query will be the top 5 highest-paid employees from the 
"EmployeeDetails" table, sorted in descending order of their salaries. 
Adjust the column names or table names accordingly if they differ in your database.*/

--How do you delete all rows from a table called "Products" and reset the primary key sequence?

/*Delete all rows from the "Products" table:
To delete all rows from the "Products" table, you can use a simple DELETE statement without a WHERE clause:
*/
DELETE FROM Products;
/*
Run this query in SSMS, and it will delete all the rows from the "Products" table.

Reset the primary key sequence:
In SQL Server, resetting the primary key sequence (specifically the identity seed value)
is not done directly using a SQL statement like in some other database systems. Instead, 
it's handled by managing the identity column properties. When you delete all the rows from 
a table that has an identity column, SQL Server automatically resets the identity seed value 
to the original starting value (by default, it's usually 1).

Therefore, if you've deleted all rows from the "Products" table, the primary
key sequence should be automatically reset to its original starting value when you insert new records.

Here's an example of how the identity column works in SQL Server:

Assuming "Products" table has an identity column named "ProductID":

*/
-- Delete all rows from the "Products" table
DELETE FROM Products;

-- Insert new records
INSERT INTO Products (ProductName, Price) VALUES ('Product A', 10.99);
INSERT INTO Products (ProductName, Price) VALUES ('Product B', 15.99);

-- The identity column (ProductID) will start with 1 for the first inserted record.
/*By performing these steps, the "Products" table will have all rows deleted, 
and the primary key sequence will be automatically reset to its starting value 
when you insert new records into the table.*/

--What is the purpose of the "SAVEPOINT" statement in SQL?

/*The "SAVEPOINT" statement in SQL is used to create a named point within a transaction 
to which you can later roll back if needed. It is a part of the larger concept of transaction 
control statements, which allow you to manage and control the behavior of transactions in SQL databases.

When you issue a "SAVEPOINT" statement, you create a savepoint within the transaction, 
which serves as a marker or reference point. This savepoint allows you to perform partial 
rollbacks within a transaction, reverting only a portion of the changes made since the 
savepoint was created. It's particularly useful when you want to maintain some changes 
made within a transaction while undoing others.

The syntax for the "SAVEPOINT" statement is as follows:*/

SAVEPOINT savepoint_name;

/*The "savepoint_name" is a user-defined name that identifies the savepoint within 
the transaction. You can then use this name later to perform a rollback to the savepoint if needed.

Here's an example of using "SAVEPOINT" in a transaction:*/

BEGIN TRANSACTION;

UPDATE Account
SET Balance = Balance - 100
WHERE AccountNumber = '123';

SAVEPOINT before_deposit;

UPDATE Account
SET Balance = Balance + 200
WHERE AccountNumber = '456';

-- If something goes wrong, rollback to the "before_deposit" savepoint
ROLLBACK TO before_deposit;

-- If everything is fine, commit the transaction
COMMIT;
/*In this example, we start a transaction using BEGIN TRANSACTION. We then update the balance of two 
accounts. After the first update, we create a savepoint named "before_deposit." The second update is 
made to a different account.

If something goes wrong in the transaction (e.g., an error occurs during the second update), 
we can use the "ROLLBACK TO" statement with the "before_deposit" savepoint name to undo only 
the changes made after the savepoint. This will effectively undo the second update while keeping 
the changes made by the first update.

The "SAVEPOINT" statement allows for more granular control over transactions and provides a way 
to handle complex operations where you might need to revert some changes while keeping others intact.
However, not all database systems support "SAVEPOINT." It's important to consult your database 
documentation to ensure compatibility and to understand the behavior of "SAVEPOINT" in your 
specific database system.*/

---Write a SQL query to calculate the average salary of employees in the "Salaries" table.

SELECT AVG(Salary) AS AverageSalary
FROM Salaries;

--How do you update the "Discount" column of a table named "Orders" to 0.15 for all records where the "TotalAmount" is greater than 1000?

UPDATE Orders
SET Discount = 0.15
WHERE TotalAmount > 1000;

--Explain the use of the "MERGE" statement in SQL and provide an example.
/*The "MERGE" statement in SQL is a powerful and versatile operation that combines the 
functionality of both "INSERT" and "UPDATE" statements within a single query. 
It allows you to conditionally insert or update data in a target table based on 
the existence of matching rows in a source table or a specified condition. 
The "MERGE" statement is especially useful when dealing with data synchronization 
or upsert (update or insert) scenarios, where you need to perform different actions 
depending on whether a record already exists in the target table.

The basic syntax of the "MERGE" statement is as follows: */

MERGE INTO target_table AS target
USING source_table AS source
ON condition
WHEN MATCHED THEN
    UPDATE SET target.column1 = source.column1, target.column2 = source.column2, ...
WHEN NOT MATCHED THEN
    INSERT (column1, column2, ...) VALUES (source.column1, source.column2, ...);

	/*Example:

Suppose we have two tables: "Employee" (target table) and "EmployeeStaging" 
(source table). We want to merge data from the "EmployeeStaging" 
table into the "Employee" table based on the "EmployeeID" column.*/

-- Target Table: Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Source Table: EmployeeStaging
CREATE TABLE EmployeeStaging (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Sample data in the source table (EmployeeStaging)
INSERT INTO EmployeeStaging (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (101, 'John', 'Doe', 'HR', 45000),
       (102, 'Jane', 'Smith', 'Marketing', 52000),
       (103, 'Michael', 'Brown', 'IT', 60000);

-- Merge the data from the source table (EmployeeStaging) into the target table (Employee)
MERGE INTO Employee AS target
USING EmployeeStaging AS source
ON target.EmployeeID = source.EmployeeID
WHEN MATCHED THEN
    UPDATE SET target.FirstName = source.FirstName,
               target.LastName = source.LastName,
               target.Department = source.Department,
               target.Salary = source.Salary
WHEN NOT MATCHED THEN
    INSERT (EmployeeID, FirstName, LastName, Department, Salary)
    VALUES (source.EmployeeID, source.FirstName, source.LastName, source.Department, source.Salary);

/* In this example, the "MERGE" statement is used to synchronize data between the "Employee" 
and "EmployeeStaging" tables based on the "EmployeeID" column. If a match is found based on the 
"EmployeeID," the existing row in the "Employee" 
table will be updated with data from the "EmployeeStaging" table. If there is no match based on 
the "EmployeeID," a new row will be inserted into the "Employee" table using data from the 
"EmployeeStaging" table.

The "MERGE" statement simplifies the process of handling data synchronization and upsert scenarios, 
making it more efficient and concise compared to using separate "INSERT" and "UPDATE" statements.
It's particularly useful when working with large datasets and performing complex data integration tasks.*/

--Write a SQL query to retrieve the count of orders placed by each customer from the "Orders" table.

SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID;

--How do you perform a bulk insert of data from one table to another in SQL?

INSERT INTO DestinationTable (Column1, Column2, Column3, ...)
SELECT SourceColumn1, SourceColumn2, SourceColumn3, ...
FROM SourceTable;