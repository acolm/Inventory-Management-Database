-- Script Name: inserts.sql
-- Author: Aaron Colmeanres
-- Purpose: insert sample data to test the easyinventoryDB


-- the database to be used and have data inserted into
-- USE easyinventoryDB;

-- Employee Table inserts
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Bob','Testo',30,2, 2000);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Dash','Par',15,4, 1996);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Reed','Richards',19,7, 1963);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Mia','Wallace',14,10, 1994);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Travis','Bickle',11, 3, 1976);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Paul','Smith',4, 1, 1976);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Terrance','Park',12, 30, 1995);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Jake','kim',4, 9, 1997);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Robert','Brown',29, 5, 1970);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Drake','Hale',13, 6, 1959);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Thomas','Anderson',31, 3, 1999);
INSERT INTO employee (`firstname`, `lastname`, `day`, `month`, `year`) VALUES ('Howard','Bale',15, 4, 1978);

-- Table table inserts
INSERT INTO `tables` (`table_name`) VALUES ("employee");
INSERT INTO `tables` (`table_name`) VALUES ("partners");
INSERT INTO `tables` (`table_name`) VALUES ("tables");
INSERT INTO `tables` (`table_name`) VALUES ("requests");
INSERT INTO `tables` (`table_name`) VALUES ("permissions");
INSERT INTO `tables` (`table_name`) VALUES ("trips");
INSERT INTO `tables` (`table_name`) VALUES ("driver");
INSERT INTO `tables` (`table_name`) VALUES ("ezi account");
INSERT INTO `tables` (`table_name`) VALUES ("devices");
INSERT INTO `tables` (`table_name`) VALUES ("sender");
INSERT INTO `tables` (`table_name`) VALUES ("manager");
INSERT INTO `tables` (`table_name`) VALUES ("record");
INSERT INTO `tables` (`table_name`) VALUES ("partner deliver");
INSERT INTO `tables` (`table_name`) VALUES ("vehicle");
INSERT INTO `tables` (`table_name`) VALUES ("locations");
INSERT INTO `tables` (`table_name`) VALUES ("packages");
INSERT INTO `tables` (`table_name`) VALUES ("orders");
INSERT INTO `tables` (`table_name`) VALUES ("suppliers");
INSERT INTO `tables` (`table_name`) VALUES ("content");
INSERT INTO `tables` (`table_name`) VALUES ("inventory");
INSERT INTO `tables` (`table_name`) VALUES ("confirmation");
INSERT INTO `tables` (`table_name`) VALUES ("supply");
INSERT INTO `tables` (`table_name`) VALUES ("stock");
INSERT INTO `tables` (`table_name`) VALUES ("shipment");
INSERT INTO `tables` (`table_name`) VALUES ("product");
INSERT INTO `tables` (`table_name`) VALUES ("purchases");
INSERT INTO `tables` (`table_name`) VALUES ("customer");

-- Partners Table inserts
INSERT INTO partners (`partner_name`, `country`) VALUES ("FEDEX","USA");
INSERT INTO partners (`partner_name`, `country`) VALUES ("UPS","USA");
INSERT INTO partners (`partner_name`, `country`) VALUES ("DHL","USA");
INSERT INTO partners (`partner_name`, `country`) VALUES ("ROYAL POST","UK");
INSERT INTO partners (`partner_name`, `country`) VALUES ("Australia Post","Australia");

-- Locations table insets
INSERT INTO locations (`capacity`, `city`, `street`, `zipcode`, `state`) VALUES (FLOOR(1000 + RAND()*2000), "San Leandro", "990 Beecher St", "94577", "CA");
INSERT INTO locations (`capacity`, `city`, `street`, `zipcode`, `state`) VALUES (FLOOR(1000 + RAND()*2000), "Tracy", "1565 N MacArthur Dr", "95376", "CA");
INSERT INTO locations (`capacity`, `city`, `street`, `zipcode`, `state`) VALUES (FLOOR(1000 + RAND()*2000), "Bremerton", "5149 WA-3", "98312", "WA");

-- Suppliers table inserts
INSERT INTO suppliers (`supplier_name`, `street`, `city`, `country`) VALUES ("Senor Wooly", "2017 S Bell Ave", "Denton", "USA");
INSERT INTO suppliers (`supplier_name`, `street`, `city`, `country`) VALUES ("Electrical Components BULK", "Tong Mi Rd", "Mong Kok", "Hong Kong");
INSERT INTO suppliers (`supplier_name`, `street`, `city`, `country`) VALUES ("Time Wasters", "King William House", "Bristol", "UK");

-- Vehicle table inserts
INSERT INTO vehicle (`license_plate`,`fk_location`) VALUES ("6TRJ244",001);
INSERT INTO vehicle (`license_plate`,`fk_location`) VALUES ("7TYP290",002);
INSERT INTO vehicle (`license_plate`,`fk_location`) VALUES ("AZM9590",003);

-- Device table inserts
INSERT INTO devices (`type`, `fk_location`) VALUES ("Packing Station", 001);
INSERT INTO devices (`type`, `fk_location`) VALUES ("Manager Console", 001);
INSERT INTO devices (`type`, `fk_location`) VALUES ("Packing Station", 002);
INSERT INTO devices (`type`, `fk_location`) VALUES ("Manager Console", 002);
INSERT INTO devices (`type`, `fk_location`) VALUES ("Packing Station", 003);
INSERT INTO devices (`type`, `fk_location`) VALUES ("Manager Console", 003);

-- Product table inserts
INSERT INTO product (`product_name`, `product_descrip`) VALUES ("wool", "This cleaned wool comes right off the sheep");
INSERT INTO product (`product_name`, `product_descrip`) VALUES ("Transistors", "50,000 transistors of all resistances");
INSERT INTO product (`product_name`, `product_descrip`) VALUES ("Capacitorts", "40,00 capacitors to power up your device");
INSERT INTO product (`product_name`, `product_descrip`) VALUES ("Mysery Bag", "A whole lot of something, who knows what");

-- Customer table inserts
INSERT INTO customer (`firstname`, `lastname`) VALUES ("Joe", "Smoe");
INSERT INTO customer (`firstname`, `lastname`) VALUES ("Wendy", "Torrance");
INSERT INTO customer (`firstname`, `lastname`) VALUES ("Rick", "Deckard");
  
-- Sender table inserts
INSERT INTO sender (`sender_id`) VALUES (011);
INSERT INTO sender (`sender_id`) VALUES (008);
INSERT INTO sender (`sender_id`) VALUES (007);
INSERT INTO sender (`sender_id`) VALUES (006);
INSERT INTO sender (`sender_id`) VALUES (001);
INSERT INTO sender (`sender_id`) VALUES (012);

-- Driver table inserts
INSERT INTO driver (`driver_id`, `working`, `license_number`) VALUES (002, false, "N5036591");
INSERT INTO driver (`driver_id`, `working`, `license_number`) VALUES (004, false, "M8378263");
INSERT INTO driver (`driver_id`, `working`, `license_number`) VALUES (005, false, "MASCGLB50783");

-- Manager table inserts
INSERT INTO manager (`manager_id`) VALUES (003);
INSERT INTO manager (`manager_id`) VALUES (009);
INSERT INTO manager (`manager_id`) VALUES (010);
  
-- Purchases table inserts
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (001, 001);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (004, 001);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (002, 003);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (003, 002);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (004, 003);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (002, 002);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (003, 001);
INSERT INTO purchases (`fk_product`, `fk_customer`) VALUES (001, 002);

-- Orders table inserts
INSERT INTO orders (`fk_location`,`fk_product`,`fk_supplier`,`fk_manager`) VALUES (001,001,001,010);
INSERT INTO orders (`fk_location`,`fk_product`,`fk_supplier`,`fk_manager`) VALUES (002,002,002,003);
INSERT INTO orders (`fk_location`,`fk_product`,`fk_supplier`,`fk_manager`) VALUES (003,003,002,003);
INSERT INTO orders (`fk_location`,`fk_product`,`fk_supplier`,`fk_manager`) VALUES (003,004,003,009);

-- Trips table inserts
INSERT INTO trips (`distance`,`package_count`) VALUES (100, 1);
INSERT INTO trips (`distance`,`package_count`) VALUES (27, 1);
INSERT INTO trips (`distance`,`package_count`) VALUES (82, 1);
