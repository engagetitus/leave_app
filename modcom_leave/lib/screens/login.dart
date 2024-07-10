import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http; // import packege
import 'package:modcom_leave/data/api.dart';
import 'leave_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  var first = TextEditingController(text: 'John');
  var last = TextEditingController(text: 'Doe');
  var email =
      TextEditingController(text: 'engage${DateTime.now().second}@titus.co.ke');
  var password = TextEditingController(text: 'Password');

  Future<bool> postUsertoDB() async {
    final url = Uri.parse('$baseUrl/register');

    // body
    var body = {
      "firstname": first.text,
      "lastname": last.text,
      "email": email.text,
      "password": password.text
    };
    // Work on this
    http.Response response = await http.post(
        //endpoint
        url,
        // headers -
        headers: {
          "Content-Type": "application/json"
        }, // declares data we are sending
        body: json.encode(body)); // converts body to json
    // Confirm that our request was successful
    if (response.statusCode == 200) {
      // we know the operation was successful


      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body)));
      return false;
      // we know the operation was not successful
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Leave App'),
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: first,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            hintText: 'e.g Jane',
                            prefixIcon: Icon(Icons.person)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty || value.contains('@,#,%,^,*,&')) {
                            return 'Enter a valid name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: last,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Second Name',
                            hintText: 'e.g Williams',
                            prefixIcon: Icon(Icons.person_2_outlined)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty || value.contains('@#%^*,&')) {
                            return 'Enter a valid name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'jane@gmail.com',
                            prefixIcon: Icon(Icons.email_outlined)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          var validation = EmailValidator.validate('$value');

                          if (validation) {
                            return null;
                          } else {
                            return 'Enter a valid email';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.password_rounded)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  var isValid = formKey.currentState!.validate();
                  if (isValid) {
                    try {
                      Map<String, String> results = {
                        'firstname': first.text,
                        'lastname': last.text,
                        'email': email.text,
                        'password': password.text
                      };

                      postUsertoDB().then((v) {
                        if (v == true) {
                          //Login
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Leavescreen(
                                        results: results,
                                      )));
                        } else {
                          return;
                        }
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Check your input fields')));
                  }
                },
                child: const Text('Log In'))
          ],
        ),
      ]),
    );
  }
}
