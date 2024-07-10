from pymysql import connect, cursors
from flask import jsonify
from config import get_db_connection


#dashboard
# Register User
def register_user(firstname, lastname, email, password):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            sql = "INSERT INTO leave_user (firstname, lastname, email, password) VALUES (%s, %s, %s, %s)"
            cursor.execute(sql, (firstname, lastname, email, password))
        conn.commit()
        return 'User registered successfully'
    except ():
        return 'User Not Saved'
    finally:
        conn.close()

# Submit Leave Application
def submit_leave_application(serial_number, leave_type, user_id):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            sql = "INSERT INTO leaveapp (serial_number, leave_type, user_id) VALUES (%s, %s, %s)"
            cursor.execute(sql, (serial_number, leave_type, user_id))
        conn.commit()
        return 'Leave application submitted successfully'
    finally:
        conn.close()

# Get All Users
def get_registered_users():
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM leave_user"
            cursor.execute(sql)
            users = cursor.fetchall()
        return users
    finally:
        conn.close()

# Get All Leave Applications
def get_created_leave_apps():
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM leaveapp"
            cursor.execute(sql)
            leave_apps = cursor.fetchall()
        return leave_apps
    finally:
        conn.close()
# User Functions

def get_all_users():
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM leave_user"
            cursor.execute(sql)
            users = cursor.fetchall()
            return jsonify(users), 200
    finally:
        connection.close()

def get_user(user_id):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM leave_user WHERE id = %s"
            cursor.execute(sql, (user_id,))
            user = cursor.fetchone()
            if user:
                return jsonify(user), 200
            else:
                return jsonify({'message': 'User not found'}), 404
    finally:
        connection.close()

def update_user(user_id, data):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "UPDATE leave_user SET firstname = %s, lastname = %s, email = %s, password = %s WHERE id = %s"
            cursor.execute(sql, (data['firstname'], data['lastname'], data['email'], data['password'], user_id))
            connection.commit()
            return jsonify({'message': 'User updated successfully'}), 200
    finally:
        connection.close()

def delete_user(user_id):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "DELETE FROM leave_user WHERE id = %s"
            cursor.execute(sql, (user_id,))
            connection.commit()
            return jsonify({'message': 'User deleted successfully'}), 200
    finally:
        connection.close()

# LeaveApp Functions

def get_all_leave_apps():
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM leaveapp"
            cursor.execute(sql)
            leave_apps = cursor.fetchall()
            return jsonify(leave_apps), 200
    finally:
        connection.close()

def get_leave_app(app_id):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM leaveapp WHERE id = %s"
            cursor.execute(sql, (app_id,))
            leave_app = cursor.fetchone()
            if leave_app:
                return jsonify(leave_app), 200
            else:
                return jsonify({'message': 'Leave app not found'}), 404
    finally:
        connection.close()

def update_leave_app(app_id, data):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "UPDATE leaveapp SET serial_number = %s, leave_type = %s WHERE id = %s"
            cursor.execute(sql, (data['serial_number'], data['leave_type'], app_id))
            connection.commit()
            return jsonify({'message': 'Leave app updated successfully'}), 200
    finally:
        connection.close()

def delete_leave_app(app_id):
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "DELETE FROM leaveapp WHERE id = %s"
            cursor.execute(sql, (app_id,))
            connection.commit()
            return jsonify({'message': 'Leave app deleted successfully'}), 200
    finally:
        connection.close()
