from flask import Flask , render_template , request  , redirect , url_for , Response
import mysql.connector
import json
from flask import jsonify

#connection varibale to database
con = mysql.connector.connect(
    host = 'localhost',
    username = 'root',
    password = '',
    database = "Bookings"
)

# create an instance of flask
app = Flask(__name__)  


#fetch tables

@app.route("/getTable", methods=['GET'])
def get_tables():
    cursor = con.cursor()
    cursor.execute("SHOW TABLES;")
    tables = cursor.fetchall()
    cursor.close()
    table_names = [table[0] for table in tables]
    return jsonify({"tables":table_names}),200
    
    


# sample date will be replaced with a real database !
reservations = [
    { "res_id": 101, "firstname": "John", "lastname": "Smith" },
    { "res_id": 102, "firstname": "Jane", "lastname": "Doe" },
    { "res_id": 103, "firstname": "Michael","lastname": "Brown"}
]


#route to home page and display home.html
@app.route("/")
def home():
    return render_template('home.html')

#route to create page
#use methods POST and GET
@app.route("/create", methods = ["POST", "GET"])
def create():
    if request.method == "POST":
        
        new_reservation = {'id':len(reservations)+1,'firstname': request.form.get("fname"),'lastname':request.form.get("lname")}
        reservations.append(new_reservation)
        return render_template("view.html")
        
    else:
        return render_template("create.html")
   
#@app.route("/view/<firstname>")
#def view(firstname):
    #return f"<h1>{firstname}</h1>"

@app.route("/view", methods = ["GET"])
def view():
 return reservations




if __name__ == "__main__":
   app.run(debug=True)
   

