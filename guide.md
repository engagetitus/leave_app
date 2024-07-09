# Leave App: Detailed Explanation of HTTP POST, UPDATE, DELETE, and GET
We will create a simple Leave Application that allows users to log in, submit leave requests, update leave requests, delete leave requests, and fetch leave requests. We will also handle file attachments using multipart requests.

## 1. Setting Up the Project
First, make sure to add the http package to your pubspec.yaml file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.4
  ```
### Import the necessary packages in your Dart files:

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
```
## 2. User Login (HTTP POST)
Create a simple login form that sends the user's credentials to an API endpoint.
### Login Form POST Function:

```dart

  Future<void> login() async {
    final url = Uri.parse('https://example.com/api/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': _username, 'password': _password}),
    );

    if (response.statusCode == 200) {
      print('Login successful: ${response.body}');
      // Handle successful login (e.g., navigate to another page)
    } else {
      print('Login failed: ${response.statusCode}');
      // Handle login error
    }
  }

  
```
## 3. Submitting a Leave Request (HTTP POST)
Create a form for submitting leave requests.

```dart

  Future<void> submitLeaveRequest() async {
    final url = Uri.parse('https://example.com/api/leave-requests');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'reason': _reason,
        'startDate': _startDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      print('Leave request submitted: ${response.body}');
      // Handle successful submission
    } else {
      print('Failed to submit leave request: ${response.statusCode}');
      // Handle submission error
    }
  }

  
```
## 4. Updating a Leave Request (HTTP PUT)
Create a form for updating existing leave requests.

### Update Leave Request Form:

```dart

  Future<void> updateLeaveRequest() async {
    final url = Uri.parse('https://example.com/api/leave-requests/${widget.requestId}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'reason': _reason,
        'startDate': _startDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      print('Leave request updated: ${response.body}');
      // Handle successful update
    } else {
      print('Failed to update leave request: ${response.statusCode}');
      // Handle update error
    }
  }

  
```

## 5. Deleting a Leave Request (HTTP DELETE)
Create a function to delete leave requests.

### Delete Leave Request Function:

```dart
Future<void> deleteLeaveRequest(int requestId) async {
  final url = Uri.parse('https://example.com/api/leave-requests/$requestId');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Leave request deleted');
    // Handle successful deletion
  } else {
    print('Failed to delete leave request: ${response.statusCode}');
    // Handle deletion error
  }
}
```
## 6. Fetching Leave Requests (HTTP GET) using Future and Stream
Fetching Leave Requests with Future:

```dart
Future<List<dynamic>> fetchLeaveRequests() async {
  final url = Uri.parse('https://example.com/api/leave-requests');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load leave requests');
  }
}
```
### Fetching Leave Requests with Stream:

```dart
Stream<List<dynamic>> streamLeaveRequests() async* {
  final url = Uri.parse('https://example.com/api/leave-requests');
  while (true) {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      yield json.decode(response.body);
    } else {
      yield [];
    }
    await Future.delayed(Duration(seconds: 5)); // Polling interval
  }
}
```

### Leave Request Form with Attachments:
```dart
class LeaveRequestWithAttachmentsForm extends StatefulWidget {
  @override
  _LeaveRequestWithAttachmentsFormState createState() => _LeaveRequestWithAttachmentsFormState();
}

class _LeaveRequestWithAttachmentsFormState extends State<LeaveRequestWithAttachmentsForm> {
  final _formKey = GlobalKey<FormState>();
  String _reason = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<File> _attachments = [];

  Future<void> submitLeaveRequestWithAttachments() async {
    final url = Uri.parse('https://example.com/api/leave-requests');
    var request = http.MultipartRequest('POST', url);

    request.fields['reason'] = _reason;
    request.fields['startDate'] = _startDate.toIso8601String();
    request.fields['endDate'] = _endDate.toIso8601String();

    for (File file in _attachments) {
      request.files.add(await http.MultipartFile.fromPath('attachments', file.path));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Leave request submitted with attachments');
      // Handle successful submission
    } else {
      print('Failed to submit leave request: ${response.statusCode}');
      // Handle submission error
    }
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _attachments = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Reason for Leave'),
            onSaved: (value) {
              _reason = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the reason for leave';
              }
              return null;
            },
          ),
          // Date pickers for start and end dates (implementation not shown)
          ElevatedButton(
            onPressed: _pickFiles,
            child: Text('Pick Files'),
          ),
          Text('Selected Files: ${_attachments.length}'),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                submitLeaveRequestWithAttachments();
              }
            },
            child: Text('Submit Leave Request'),
          ),
        ],
      ),
    );
  }
}
```