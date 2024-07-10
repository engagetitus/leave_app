from flask import Flask, redirect, render_template, request, url_for
from functions import *

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'flutterway'

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Registration Form Submission
        if 'firstname' in request.form and 'lastname' in request.form and 'email' in request.form and 'password' in request.form:
            firstname = request.form['firstname']
            lastname = request.form['lastname']
            email = request.form['email']
            password = request.form['password']

            register_user(firstname, lastname, email, password)

            return redirect(url_for('index'))

        # Leave Application Form Submission
        elif 'serial_number' in request.form and 'leave_type' in request.form and 'user_id' in request.form:
            serial_number = request.form['serial_number']
            leave_type = request.form['leave_type']
            user_id = request.form['user_id']

            submit_leave_application(serial_number, leave_type, user_id)

            return redirect(url_for('index'))

    # Fetching Data for Dashboard Display
    users = get_registered_users()
    leave_apps = get_created_leave_apps()

    return render_template('index.html', users=users, leave_apps=leave_apps)

@app.route('/register', methods = ['POST'], )
def post_user():
    data = request.get_json()
    firstname = data['firstname']
    lastname = data['lastname']
    email = data['email']
    password = data['password']
    return jsonify(register_user(firstname = firstname,lastname=lastname,email=email,password=password)) 

@app.route('/users', methods=['GET'])
def get_all_users_route():
    return get_all_users()

@app.route('/users/<int:user_id>', methods=['GET'])
def get_user_route(user_id):
    return get_user(user_id)

@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user_route(user_id):
    data = request.get_json()
    return update_user(user_id, data)

@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user_route(user_id):
    return delete_user(user_id)

@app.route('/leave-apps', methods=['GET'])
def get_all_leave_apps_route():
    return get_all_leave_apps()

@app.route('/leave-apps/<int:app_id>', methods=['GET'])
def get_leave_app_route(app_id):
    return get_leave_app(app_id)

@app.route('/leave-apps/<int:app_id>', methods=['PUT'])
def update_leave_app_route(app_id):
    data = request.get_json()
    return update_leave_app(app_id, data)

@app.route('/leave-apps/<int:app_id>', methods=['DELETE'])
def delete_leave_app_route(app_id):
    return delete_leave_app(app_id)

if __name__ == '__main__':
    app.run(debug=True,host='192.168.129.96')
