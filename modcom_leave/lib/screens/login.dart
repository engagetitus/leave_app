import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'leave_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  var first = TextEditingController();
  var last = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Leave App'),),),
      body: ListView(
        children:[ Column(
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
                          prefixIcon: Icon(Icons.person)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                            if(value!.isEmpty || value.contains('@,#,%,^,*,&')){
                              return 'Enter a valid name';
                            }
                            else{
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
                          prefixIcon: Icon(Icons.person_2_outlined)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                            if(value!.isEmpty || value.contains('@#%^*,&')){
                              return 'Enter a valid name';
                            }
                            else{
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
                          prefixIcon: Icon(Icons.email_outlined)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                            var validation = EmailValidator.validate('$value');
                            
                            if(!validation){
                              return null;
                            }
                            else{
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
                          prefixIcon: Icon(Icons.password_rounded)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                            if(value!.isEmpty){
                              return 'Enter a password';
                            }
                            else if(value.length < 6){
                              return 'Password must be at least 6 characters';
                            }
                            else{
                              return null;
                            }
                        },
                    ),
                  ),
                ],
              )
              ),
        
          ElevatedButton(
            onPressed: (){
              var isValid = formKey.currentState!.validate();
              if(isValid){
                try{
        
                  Map<String, String> results = {
                  'First Name': first.text,
                  'Last Name': last.text,
                  'Email': email.text,
                  'Password': password.text
                };
        
                Navigator.push(context, MaterialPageRoute(builder: (_)=>  Leavescreen(results: results,)));
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
                
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your input fields')));
              }
        
        
        
            }, 
            child: const Text('Log In'))
        
          ],
        ),
      ]),


    );
  }
}