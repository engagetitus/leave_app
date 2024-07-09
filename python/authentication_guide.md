# Part 1: ADVANCED: Securing Data Transfer with Authorization Headers in app.py
## Explanation:
To secure data transfer between your Flutter application and the server, you can use authorization headers to authenticate requests. This involves setting up the server (`app.py` in Flask) to require and validate these headers.

### Adjusting app.py:
Here's how you can adjust `app.py` to handle authentication using authorization headers:
```python
from flask import Flask, request, jsonify
from functools import wraps
from .functions import *

app = create_app()

# Example function to validate authorization token
def authorize_token(token):
    # Replace with your authentication logic (e.g., JWT validation)
    return token == 'your_secret_token'

# Example decorator to protect routes requiring authentication
def require_auth(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token or not authorize_token(token.replace('Bearer ', '')):
            return jsonify({'message': 'Unauthorized'}), 401
        return func(*args, **kwargs)
    return wrapper

# Protected route example
@app.route('/protected', methods=['GET'])
@require_auth
def protected_route():
    return jsonify({'message': 'Welcome to protected route!'})

if __name__ == '__main__':
    app.run(debug=True)
```
### Explanation of app.py Adjustments:
Authorization Logic (`authorize_token`): Implement your token validation logic. This example uses a simple comparison for demonstration (``token == 'your_secret_token'``). Replace this with your actual authentication mechanism, such as JWT validation.

Decorator (`require_auth`): This decorator function (`require_auth`) checks for the presence of the Authorization header and validates the token using the authorize_token function. If the token is missing or invalid, it returns a 401 Unauthorized response.

Protected Route (`protected_route`): An example route (/protected) demonstrates how to protect routes by applying the require_auth decorator. Only requests with a valid authorization token will be allowed access.

## Part 2: Adjusting Flutter Code for Authentication Headers
### Explanation:
In Flutter, you'll adjust your HTTP requests to include the authorization header when consuming protected API endpoints. This involves modifying your Future methods to set the appropriate headers.

#### Adjusting Flutter Code:
Here's how you can adjust your Flutter code to include authorization headers when registering a user or sending an application:

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> registerUser(String firstname, String lastname, String email, String password) async {
  var url = Uri.parse('https://api.example.com/register');
  var token = 'your_access_token_here'; // Replace with your actual access token

  try {
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      print('Failed to register user. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error registering user: $e');
  }
}

Future<void> sendApplication(String serialNumber, String leaveType) async {
  var url = Uri.parse('https://api.example.com/leave-application');
  var token = 'your_access_token_here'; // Replace with your actual access token

  try {
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'serial_number': serialNumber,
        'leave_type': leaveType,
      }),
    );

    if (response.statusCode == 201) {
      print('Leave application sent successfully');
    } else {
      print('Failed to send leave application. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending leave application: $e');
  }
}

void main() {
  runApp(MyApp());
}

// Example widget and usage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Secure HTTP Requests')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              registerUser('John', 'Doe', 'john.doe@example.com', 'password123');
              // Alternatively, call sendApplication function
            },
            child: Text('Register User'),
          ),
        ),
      ),
    );
  }
}
```
**Explanation of Flutter Code Adjustments:**
Setting Authorization Header: In each HTTP request (`http.post`), include the Authorization header with the access token (`Bearer $token`). Replace '`your_access_token_here`' with your actual access token obtained during user authentication.

**Handling Responses:** Check the response status code (`response.statusCode`) to determine if the request was successful (`201` for created) or if there was an error. You can customize error handling based on your application's requirements.

**Widget and Usage Example:** Demonstrates an example ElevatedButton in a Flutter app's MyApp widget. Modify the button's onPressed callback to call either registerUser or sendApplication functions as per your application flow.

## Summary:
This guide explains how to secure data transfer using authorization headers in `app.py` (Flask) and adjust Flutter code to handle authentication headers when consuming API endpoints. Implement these adjustments to ensure secure and authenticated communication between your Flutter application and the server. Adjustments can also be made for other HTTP methods (`GET`, `PUT`, `DELETE`) following similar patterns.