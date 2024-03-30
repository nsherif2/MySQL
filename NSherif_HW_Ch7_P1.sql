/*
Assignment: Homework Chapter 7 Part 1
Assignemtn description: 
In this assignment, a series of SQL operations are performed on the database tables Invoices and Vendors, followed by verification and rollback procedures. Initially, a new invoice row is inserted into the Invoices table, and then vendors' default account numbers are updated to 403 where previously set to 400 in the Vendors table. Subsequently, invoices associated with vendors having a default terms ID of 2 have their terms ID changed to 2 in the Invoices table. Following these modifications, the added invoice row is deleted. Verification queries are included after each operation to ensure the changes were successful. Finally, a rollback command is executed to revert all modifications, and verification queries confirm the rollback's effectiveness
Course: CMSC246
Student: Nebil Sherif
Instructor: Professor G Grinberg
Due Date:3/3/2024
*/
/*1.Write an INSERT statement that adds this row to the Invoices table:*/

INSERT INTO Invoices 
VALUES (DEFAULT, 32, 'AX-014-027', '2014-08-01', 434.58, 0.0, 0.0, 2, '2014-08-31', NULL);

/*2.Write an UPDATE statement that modifies the Vendors table. Change the default account number to 403 for each vendor that has a default account number of 400.*/

INSERT INTO Invoice_line_Items (invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description) 
VALUES (LAST_INSERT_ID(), 1, 160, 180.23, 'Hard drive'),
       (LAST_INSERT_ID(), 2, 527, 254.35, 'Exchange Server update');



/*3.Write an UPDATE statement that modifies the Invoices table. Change the terms_id to 2 for each invoice that’s for a vendor with a default_terms_id of 2.*/

UPDATE Invoices 
SET credit_total = invoice_total * 0.10, 
    payment_total = invoice_total - (invoice_total * 0.10)
WHERE invoice_id = LAST_INSERT_ID();

/*Verify*/
SELECT * FROM Invoices WHERE vendor_id IN (SELECT vendor_id FROM Vendors WHERE default_terms_id = 2);



/*4.Write a DELETE statement that deletes the row that you added to the Invoices table in exercise 1.*/
DELETE FROM Invoice_line_Items WHERE invoice_id = LAST_INSERT_ID();
DELETE FROM Invoices WHERE invoice_id = LAST_INSERT_ID();
/*Verify*/


/*5.After you have verified that all of the modifications for the first four exercises have been successful, rollback the changes. Then, verify that they have been rolled back.*/

ROLLBACK;

