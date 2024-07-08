from flask import Flask

def create_app():
    app = Flask(__name__)
    
    # Database Configuration (replace with your MySQL details)
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_USER'] = 'root'
    app.config['MYSQL_PASSWORD'] = ''
    app.config['MYSQL_DB'] = 'flutterway'
    
    return app
