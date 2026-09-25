from flask import Flask , render_template , request  , redirect , url_for , Response
import mysql.connector
import json
from flask import jsonify

#connection varibale to database
db = mysql.connector.connect(
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
    cursor = db.cursor()
    cursor.execute("SHOW TABLES;")
    tables = cursor.fetchall()
    cursor.close()
    table_names = [table[0] for table in tables]
    return jsonify({"tables":table_names}),200


@app.route("/addBooking", methods=["POST" , "GET"])
def add_booking():
    if request.method == "POST":
        fname = request.form.get("fname")
        lname = request.form.get("lname")
    else:
        return render_template("create.html")
    
    print("fname:", fname)
    print("lname:", lname)
    
    print(request.form)
    
    cursor = db.cursor()
    sql_query = "INSERT INTO reservations (firstname,lastname) VALUES (%s,%s)"
    
    cursor.execute(sql_query,(fname, lname))
    db.commit()
    return jsonify({"message":"posted"}),200
    


#route to home page and display home.html
@app.route("/")
def home():
    return render_template('home.html')



if __name__ == "__main__":
   app.run(debug=True)
   

