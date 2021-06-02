# Final Course Project 



## Step By Step

   1. Python 3.6 was used for this project
   2. pymysql module must be installed for program to work
   3. You will need to change out the sqlconfig.conf file with credentials to connect to mysql on your machine
   4. Start the program in command line with: python3 user_interface.py


## Help with Inserting

   1. Inserting into Sender, Driver, and Manager require an ID to be given. This must be an EXISTING ID from an employee's EZI Account
   2. License Plate Numbers adhere to the length of real license plates, 7 characters
   3. Driver's License Numbers also adhere to real license numbers, 12(varries by state but 12 is max)
   4. When Inserting into the Driver table, the column 'working' is a boolean in MySQL but you need to use 1 or 0 instead
   5. You will need to sign in to a manager account


## Challenges

It was very challenging to initially work out all of the quirks with the python API. I was much more familiar with using javascript
connecting to a MySQL database, so learning how methods were implemented took up a lot of time. Other than that, most of
the rest of the difficulty came from getting errors from conflicting SQL statements which had to be removed. I also noticed that a
holdover functionality from milestone 2 that randomized data everytime the database was created was still in effect. I ened up
leaving it in as it only effects a couple of tables and doesn't actually introduce any problems with the functionality of the python
program. The coding of python was the least intensive part of the class as coming up with the database was much harder.