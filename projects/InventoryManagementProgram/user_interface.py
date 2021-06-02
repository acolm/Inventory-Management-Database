"""
This is the user interface where the program interacts with the user.
USAGE: 1. Go to sqlconfig.conf file and change the username and password
          values to the ones from you are using in your mysql instance
       2. Open a terminal windows and run the following command:
       python3 user_interface.py
NOTE: Only option 3 and 4 from the menu is implemented so students can
      understand the flow of the program as a base to
      implement the rest of the options
"""

class account:
    loggedIn = False
    id = None
    name = None

rinzler = account

def checkTransaction():
    f = open("transactions.sql", "r")
    test = f.read(1)
    f.close()
    if test:
        db.run_sql_file("transactions.sql")

def show_menu():
    """
    Prints in console the main menu
    :return: VOID
    """
    print("User Menu \n"
          "1. Create Account \n"
          "2. Login \n"
          "3. Search \n"
          "4. Insert \n"
          "5. Update \n"
          "6. Delete \n"
          "7. Exit \n")


def show_table_names(tables):
    """
    Show all the tables names
    :param tables: a list with the tables names.
                   You can get it by calling the method
                   get_table_names() from DB object
    :return: VOID
    """
    index = 1
    print("\nTables:")
    for table in tables:
        print(table[0])  # print tables names
        index += 1

def option1(db):
    namef = input("\nFirst Name: ")
    namel = input("Last Name: ")
    dob = input("Date of birth (ex. 1/15/1990): ")
    pword = input("Password: ")
    first = dob.find("/")
    last = dob.rfind("/")
    attributes = ["firstname", "lastname", "day", "month", "year"]
    values = []
    values.append(namef)
    values.append(namel)
    values.append(dob[0:first])
    values.append(dob[first+1:last])
    values.append(dob[last+1:])


    db.insert(table="employee", attributes=attributes, values=values)
    query="""SELECT employee_id FROM employee WHERE firstname = %s AND lastname = %s"""
    values.clear()
    num = db.select(query=query, values=[namef, namel])
    query = """UPDATE `ezi account` SET password = %s WHERE easy_id = %s"""
    db.update(query=query, values=[pword, num])
    power = "0"
    while not (int(power)>0 and int(power)<4): 
        power = input("\nSelect Account Type:\n1. Driver\n2. Sender\n3. Manager\n\nSelect one: ")
        if power == "1":
            drive = input("License Number for Driver (12 characters or less): ")
            values.append(str(num[0][0]))
            values.append("0")
            values.append(drive)
            db.insert(table="driver", attributes = ["driver_id", "working", "license_number"], values=values)
        elif power == "2":
            values.append(str(num[0][0]))
            db.insert(table="sender", attributes = ["sender_id"], values=values)
        elif power == "3":
            values.append(str(num[0][0]))
            db.insert(table="manager", attributes=["manager_id"], values=values)
    print("Account has been created for "+ namef+ " with ID: "+ str(num[0][0]) + "\n\n")

def option2(db):
    if not rinzler.loggedIn:
        id = input("\nID: ")
        pword = input("Password: ")
        query = """SELECT password FROM `ezi account` WHERE easy_id = %s """
        password = db.select(query=query, values=[int(id)])
        if password[0][0] == pword:
            rinzler.loggedIn = True
            rinzler.id = id
            query = """SELECT firstname FROM employee WHERE employee_id = %s"""
            name = db.select(query=query, values=[int(id)])
            print("You are logged as {}!\n\n".format(name[0][0]))
            rinzler.name = name[0][0]
        else:
            print("That password was incorrect\n\n")
    else:
        print("You are already logged in\n\n")

def tableHeader(number, tables):
    switcher = {
        0: "\nTables with read permissions for "+rinzler.name+".",
        1:"\nTables with write/read permissions for "+rinzler.name+".",
        9:"\nTables with all permissions for "+rinzler.name+"."
    }
    print(switcher.get(number))
    i=1
    for table, perm in tables:
        if perm == number:
            number = perm
            print(str(i)+". "+table)
        else:
            number = perm
            print(switcher.get(perm))
            print(str(i)+". "+table)
        i +=1

def querySelect(values):
    switcher = {
        "confirmation": """SELECT confirm_id, store_ready, ready_date, product.product_name, employee.fullname FROM confirmation \
            JOIN purchases ON purchases.purchase_id = confirmation.fk_purchase\
                JOIN product ON product.product_id = purchases.fk_product \
                    JOIN employee ON employee.employee_id = confirmation.fk_sender\
                        WHERE {} = %s""".format(values[1]),
        "requests": """SELECT requests.request_id, product.product_name, requests.count, employee.fullname FROM requests\
            JOIN product ON product.product_id = requests.fk_product\
                JOIN employee ON employee.employee_id = requests.fk_sender\
                    WHERE {} = %s""".format(values[1]),
        "purchases": """SELECT purchases.purchase_id, product.product_name, requests.count FROM purchases\
            JOIN product ON product.product_id = purchases.fk_product\
                JOIN confirmation ON confirmation.fk_purchase = purchases.purchase_id\
                    JOIN requests ON requests.fk_sender = confirmation.fk_sender\
                        WHERE {} = %s""".format(values[1]),
        "trips": """SELECT * FROM trips WHERE {} = %s""".format(values[1]),
        "vehicle": """SELECT * FROM vehicle WHERE {} = %s""".format(values[1]),
        "record": """SELECT record.fk_trip_id, employee.fullname, vehicle.license_plate, record.fk_package FROM record\
            JOIN employee ON employee.employee_id = record.fk_driver_id\
                JOIN vehicle ON vehicle.vehicle_number = record.fk_vehicle_number\
                    WHERE {} = %s""".format(values[1]),
        "packages": """SELECT package_id, weight, tracking_number, deliver_date FROM packages \
            WHERE {} = %s""".format(values[1]),
        "sender": """SELECT employee_id, fullname, dob FROM employee \
            JOIN sender ON sender.sender_id = employee.employee_id\
                WHERE {} = %s""".format(values[1]),
        "driver": """SELECT employee_id, fullname, dob FROM employee \
            JOIN driver ON driver.driver_id = employee_id\
                WHERE {} = %s""".format(values[1]),
        "manager": """SELECT employee_id, fullname, dob FROM employee\
            JOIN manager ON manager.manager_id = employee_id\
                WHERE {} = %s""".format(values[1]),
        "orders": """SELECT orders.order_id, employee.fullname, product.product_name, locations.address, suppliers.supplier_name FROM orders\
            JOIN employee ON employee.employee_id = orders.fk_manager\
                JOIN product ON product.product_id = orders.fk_product\
                    JOIN locations ON locations.location_number = orders.fk_location\
                        JOIN suppliers ON suppliers.supplier_id = orders.fk_supplier\
                            WHERE {} = %s""".format(values[1])
    }
    return switcher.get(values[0], "broken")

def readResults(table, values):
    switcher = {
        "confirmation": ["Confirm ID","Store Ready","Pickip Date (d/m)", "Product", "Sender"],
        "requests": ["Request ID", "Product", "Count", "Sender"],
        "purchases": ["Purchase ID", "Product", "Count"],
        "trips": ["Trip ID", "Package Count", "Distance"],
        "vehicle": ["Vehicle ID", "License Plate", "Location"],
        "record": ["Trip ID", "Driver", "Vehicle License Plate", "Package ID"],
        "packages": ["Package ID", "Weight", "Tracking Number", "Deliver Date"],
        "driver": ["Driver ID", "Full Name", "Birthday"],
        "sender": ["Sender ID", "Full Name", "Birthday"],
        "manager": ["Manager ID", "Full Name", "Birthday"],
        "orders": ["Order ID", "Manager", "Product", "Location", "Supplier"]
    }
    columns = switcher.get(table)
    print("\nResults:")
    i = 0
    for column in columns:
        print("{:22} {}".format(column+":", values[0][i]))
        i +=1

def option3(db):
    """
    Search option
    :param db_object: database object
    :param tables: the name of the tables in the database
    :return: VOID
    """
    try:
        if rinzler.loggedIn:
            query = """SELECT tables.table_name, permissions.permission_level FROM permissions JOIN tables ON tables.table_id = \
                permissions.fk_table WHERE fk_ezi_account = %s"""
            tables = db.select(query=query, values=[int(rinzler.id)])
            fperm = tables[0][1]
            tableHeader(fperm, tables)
            selection = input("\nSelect a table to search: ")
            field = input("Enter a field: ")
            value = input("Enter value: ")

            values = [tables[int(selection)-1][0], field]
            query = querySelect(values)
            values.clear()
            if query == "broken":
                print("\nPlease select a proper table\n\n")
                return
        
            values.append(value)
            values = db.select(query=query, values=values)
            readResults(tables[int(selection)-1][0], values)
            print("\n")
            return
        else:
            print("\nPlease log in first\n\n")
            return

    except Exception as err:  # handle error
        print("The data requested couldn't be found\n")



# option 4 when user selects insert
def option4(db):
    try:
        if rinzler.loggedIn:
            query = """SELECT tables.table_name, permissions.permission_level FROM permissions JOIN tables ON tables.table_id = \
                permissions.fk_table WHERE fk_ezi_account = %s AND permission_level > 0"""
            tables = db.select(query=query, values=[int(rinzler.id)])
            if not bool(tables):
                print("\nYou do not have permission to write to any table\n\n")
                return
            fperm = tables[0][1]
            tableHeader(fperm, tables)
            selection = input("\nSelect a table to insert data: ")
            options = db.get_column_names(tables[int(selection)-1][0])
            printColumns(options)
            fields = input("Enter field/s separated by comma: ")
            values_str = input("Enter values: ")

            # from string to list of attributes and values
            if "," in fields:  # multiple attributes
                attributes = fields.split(",")
                values = values_str.split(",")
            else:  # one attribute
                attributes = [fields]
                values = [values_str]
            
            if db.insert(table=tables[int(selection)-1][0], attributes=attributes, values=values):
                print("Data successfully inserted into {} \n".format(tables[int(selection)-1][0]))
        else:
            print("\nPlease log in first\n\n")
            return

    except: # data was not inserted, then handle error
        print("Error:", values_str, "failed to be inserted in ", tables[int(selection)-1][0], "\n")

def printColumns(columns):
    final = ""
    for column in columns:
        final += column[0] + ", "
    print("Avaliable fields: "+ final+ "\n")

def option5(db):
    try:
        if rinzler.loggedIn:
            query = """SELECT tables.table_name, permissions.permission_level FROM permissions JOIN tables ON tables.table_id = \
                permissions.fk_table WHERE fk_ezi_account = %s AND permission_level > 1"""
            tables = db.select(query=query, values=[int(rinzler.id)])
            if not bool(tables):
                print("\nYou do not have permission to update any table\n\n")
                return
            fperm = tables[0][1]
            tableHeader(fperm, tables)
            selection = input("\nSelect a table to update data: ")
            options = db.get_column_names(tables[int(selection)-1][0])
            printColumns(options)
            identify = input("Enter field to identify row: ")
            proof = input("Enter value to select row: ")
            query= """SELECT * FROM {} WHERE {} = %s""".format(tables[int(selection)-1][0], identify)
            check = db.select(query=query, values=[proof])
            if not bool(check):
                print("The information you privided did not correspond to any data in the database\n\n")
                return
            fields = input("Enter field to update: ")
            values = input("Enter value: ")
            
            query ="""UPDATE {} SET {} = {} WHERE {} = %s""".format(tables[int(selection)-1][0], fields, values, identify)
            if db.update(query=query, values=[proof]):
                print("Data successfully updated into {} \n".format(tables[int(selection)-1][0]))
        else:
            print("\nPlease log in first\n\n")
            return

    except: # data was not inserted, then handle error
        print("Error:", values, "failed to be inserted in ", tables[int(selection)-1][0], "\n")

def option6(db):
    try:
        if rinzler.loggedIn:
            query = """SELECT tables.table_name, permissions.permission_level FROM permissions JOIN tables ON tables.table_id = \
                permissions.fk_table WHERE fk_ezi_account = %s AND permission_level > 1"""
            tables = db.select(query=query, values=[int(rinzler.id)])
            if not bool(tables):
                print("\nYou do not have permission to delete any table\n\n")
                return
            fperm = tables[0][1]
            tableHeader(fperm, tables)
            selection = input("\nSelect a table to delete data: ")
            fields = input("Enter field: ")
            values = input("Enter value: ")
            query = """DELETE FROM {} WHERE {} = %s""".format(tables[int(selection)-1][0], fields)
            if db.delete(query=query, values=[values]):
                print("Data successfully deleted from {} \n".format(tables[int(selection)-1][0]))
        else:
            print("\nPlease log in first\n\n")
            return

    except:
        print("Error:", values, "failed to be deleted in ", tables[int(selection)-1][0], "\n")


##### Driver execution.....
from database import DB

print("Setting up the database......\n")

# DB API object
db = DB(config_file="sqlconfig.conf")

# create a database (must be the same as the one is in your config file)
database = "easyinventoryDB"
if db.create_database(database=database, drop_database_first=True):        #DATA BASE IS NOT BEING DROPPED
    print("Created database {}".format(database))
else:
    print("An error occurred while creating database {} ".format(database))

# create all the tables from databasemodel.sql
db.run_sql_file("databasemodel.sql")

# insert sample data from insert.sql
db.run_sql_file("insert.sql")

checkTransaction()

print("\nSet up process finished\n")

show_menu()
option = int(input("Select one option from the menu: "))
while option != 7:
    if option == 1:
        option1(db)
    elif option == 2:
        option2(db)
    elif option == 3:
        option3(db)
    elif option == 4:
        option4(db)
    elif option == 5:
        option5(db)
    elif option == 6:
        option6(db)
    show_menu()
    option = int(input("Select one option from the menu: "))