-- Script Name: inserts.sql
-- Author: Aaron Colmeanres
-- Purpose: test the sample data in easyinventoryDB

-- the database to be used and have data inserted into
USE easyinventoryDB;

#THE TRUNCATE STATEMENTS ARE AT THE END OF THE FILE UNCOMMENTED
#Triggers worked to fill in all tables with data

-- Testing procedure countSupplierShip
CALL longestTrip(@length);
SELECT @length AS Trip;

-- Testing function supplierAvgShip
SELECT supplierAvgShip(2);


-- 1. Testing employee table
UPDATE employee SET employee_id = 13 WHERE employee_id = 10; SELECT * FROM employee;
-- 1. ERROR IN EMPLOYEE DELETE
-- QUERY: DELETE FROM employee WHERE employee_id = 7; 
-- ERROR: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`sender`, CONSTRAINT `sender to account` FOREIGN KEY (`sender_id`) REFERENCES `ezi account` (`easy_id`))

-- 2. Testing partners table
UPDATE partners SET partner_name = "Fun Factory" WHERE partner_id = 4;
DELETE FROM partners WHERE partner_id = 1;

-- 3. Testing tables table
UPDATE `tables` SET table_name = "Delivery Partners" WHERE table_id = 15;
DELETE FROM `tables` WHERE table_id = 10;

-- 4. Testing requests table
UPDATE requests SET count = 5 WHERE request_id = 3;
DELETE FROM requests WHERE request_id = 7;

-- 5. Testing permissions table
UPDATE permissions SET permission_level = 9 WHERE fk_ezi_account = 4;
DELETE FROM permissions WHERE fk_ezi_account = 12;

-- 6. Testing trips table
UPDATE trips SET trip_id = 7 WHERE trip_id = 1;
DELETE FROM trips WHERE trip_id = 2;

-- 7. Testing driver table
UPDATE driver SET driver_id = 3 WHERE driver_id = 4;
DELETE FROM driver WHERE driver_id = 5;

-- 8. Testing `ezi account` table
-- 2. ERROR IN EZI ACCOUNT UPDATE
-- QUERY: UPDATE `ezi account` SET easy_id = 8 WHERE easy_id = 1;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`sender`, CONSTRAINT `sender to account` FOREIGN KEY (`sender_id`) REFERENCES `ezi account` (`easy_id`))
-- 3. ERROR IN EZI ACCOUNT DELETE
-- QUERY: DELETE FROM `ezi account` WHERE easy_id = 1;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`sender`, CONSTRAINT `sender to account` FOREIGN KEY (`sender_id`) REFERENCES `ezi account` (`easy_id`))

-- 9. Testing devices table
UPDATE devices SET type = "Accounting" WHERE device_id = 3;
DELETE FROM devices WHERE device_id = 1;

-- 10. Testing sender table
-- 4. ERROR IN SENDER UPDATE
-- QUERY: UPDATE sender SET sender_id = 5 WHERE sender_id = 6;
-- ERROR: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`confirmation`, CONSTRAINT `confirmation to sender` FOREIGN KEY (`fk_sender`) REFERENCES `sender` (`sender_id`))
-- 5. ERROR IN SENDER DELETE
-- QUERY: DELETE FROM sender WHERE sender_id = 1;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`confirmation`, CONSTRAINT `confirmation to sender` FOREIGN KEY (`fk_sender`) REFERENCES `sender` (`sender_id`))

-- 11. Testing manager table
UPDATE manager SET manager_id = 7 WHERE manager_id = 3;
-- 6. ERROR IN MANAGER DELETE
-- QUERY: DELETE FROM manager WHERE manager_id = 9;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`orders`, CONSTRAINT `orders to manager` FOREIGN KEY (`fk_manager`) REFERENCES `manager` (`manager_id`) ON UPDATE CASCADE)

-- 12. Testing record table
UPDATE record SET fk_package = 002 WHERE fk_trip_id = 1;
DELETE FROM record WHERE fk_trip_id = 1;

-- 13. Testing packages table
UPDATE packages SET day = 7 WHERE package_id = 8; 
DELETE FROM packages WHERE package_id = 4;

-- 14. Testing `partner deliver` table
UPDATE `partner deliver` SET fk_package = 5 WHERE fk_package = 3;
DELETE FROM `partner deliver` WHERE fk_package = 2;

-- 15. Testing vehicle table
UPDATE vehicle SET vehicle_number = 4 WHERE vehicle_number = 2; 
DELETE FROM vehicle WHERE vehicle_number = 1;

-- 16. Testing locations table
UPDATE locations SET location_number = 4 WHERE location_number = 2; 
DELETE FROM locations WHERE location_number= 1;

-- 17. Testing orders table
-- 7. ERROR IN ORDERS UPDATE
-- QUERY: UPDATE orders SET fk_manager = 4 WHERE order_id = 3;
-- ERROR: Cannot add or update a child row: a foreign key constraint fails (`easyinventorydb`.`orders`, CONSTRAINT `orders to manager` FOREIGN KEY (`fk_manager`) REFERENCES `manager` (`manager_id`) ON UPDATE CASCADE)
DELETE FROM orders WHERE order_id = 1;

-- 18. Testing suppliers table
UPDATE suppliers SET supplier_name = "Produceless Co" WHERE supplier_id = 3; 
-- 8. ERROR IN ORDERS UPDATE
-- QUERY: DELETE FROM suppliers WHERE supplier_id = 2;
-- ERROR:Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`orders`, CONSTRAINT `orders to supplier` FOREIGN KEY (`fk_supplier`) REFERENCES `suppliers` (`supplier_id`) ON UPDATE CASCADE)

-- 19. Testing content table
UPDATE content SET count = 9 WHERE fk_package = 7;
DELETE FROM content WHERE fk_package = 7;

-- 20. Testing inventory table
UPDATE inventory SET fk_product = 3 WHERE fk_location = 4;
DELETE FROM inventory WHERE fk_location = 3;

-- 21. Testing confirmation table
-- 8. ERROR IN CONFIRMATION UPDATE
-- QUERY: UPDATE confirmation SET fk_purchase = 9 WHERE confirm_id = 4;
-- ERROR: Cannot add or update a child row: a foreign key constraint fails (`easyinventorydb`.`confirmation`, CONSTRAINT `confirmation to purchase` FOREIGN KEY (`fk_purchase`) REFERENCES `purchases` (`purchase_id`))
DELETE FROM confirmation WHERE confirm_id = 1;

-- 22. Testing supply table
-- 10. ERROR IN SUPPLY UPDATE
-- QUERY: UPDATE supply SET fk_stock = 5 WHERE fk_stock = 1;
-- ERROR: Cannot add or update a child row: a foreign key constraint fails (`easyinventorydb`.`supply`, CONSTRAINT `supply to stock` FOREIGN KEY (`fk_stock`) REFERENCES `stock` (`stock_id`) ON UPDATE CASCADE)
DELETE FROM supply WHERE fk_stock = 3;

-- 23. Testing stock table
UPDATE stock SET stock_id = 5 WHERE stock_id = 1;
-- 11. ERROR IN SUPPLY DELETE
-- QUERY: DELETE FROM stock WHERE stock_id = 2;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`supply`, CONSTRAINT `supply to stock` FOREIGN KEY (`fk_stock`) REFERENCES `stock` (`stock_id`) ON UPDATE CASCADE)

-- 24. Testing shipment table
UPDATE shipment SET fk_product = 3 WHERE fk_stock = 3;
DELETE FROM shipment WHERE fk_stock = 3;

-- 25. Testing product table
UPDATE product SET product_id = 1 WHERE product_id = 5;
-- 12. ERROR IN SUPPLY DELETE
-- QUERY: DELETE FROM product WHERE product_id = 2;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`content`, CONSTRAINT `content to product` FOREIGN KEY (`fk_product`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE)


-- 26. Testing purchases table
-- 13. ERROR IN SUPPLY UPDATE
-- QUERY: UPDATE purchases SET purchase_id = 9 WHERE purchase_id = 4;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`confirmation`, CONSTRAINT `confirmation to purchase` FOREIGN KEY (`fk_purchase`) REFERENCES `purchases` (`purchase_id`))
-- 14. ERROR IN SUPPLY DELETE
-- QUERY: DELETE FROM purchases WHERE purchase_id = 4;
-- ERROR: Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`confirmation`, CONSTRAINT `confirmation to purchase` FOREIGN KEY (`fk_purchase`) REFERENCES `purchases` (`purchase_id`))

-- 27. Testing customer table
UPDATE customer SET firstname = "BOB" WHERE customer_id = 2;
-- 15. ERROR IN SUPPLY DELETE
-- QUERY: DELETE FROM customer WHERE customer_id = 3;
-- ERROR: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`easyinventorydb`.`purchases`, CONSTRAINT `purchases to customer` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE)

-- TRUNCATE TABLE customer;
TRUNCATE TABLE purchases;
TRUNCATE TABLE product;
TRUNCATE TABLE shipment;
TRUNCATE TABLE inventory;
TRUNCATE TABLE confirmation;
TRUNCATE TABLE supply;
TRUNCATE TABLE stock;
TRUNCATE TABLE orders;
TRUNCATE TABLE suppliers;
TRUNCATE TABLE content;
TRUNCATE TABLE vehicle;
TRUNCATE TABLE locations;
TRUNCATE TABLE packages;
TRUNCATE TABLE `partner deliver`;
TRUNCATE TABLE record;
TRUNCATE TABLE manager;
TRUNCATE TABLE sender;
TRUNCATE TABLE devices;
TRUNCATE TABLE `ezi account`;
TRUNCATE TABLE permissions;
TRUNCATE TABLE trips;
TRUNCATE TABLE driver;
TRUNCATE TABLE partners;
TRUNCATE TABLE `tables`;
TRUNCATE TABLE requests;
TRUNCATE TABLE employee;