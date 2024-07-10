import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modcom_leave/data/api.dart';

import 'my_leaves.dart';

class Leavescreen extends StatefulWidget {
  const Leavescreen({super.key, required this.results});
  final Map results;

  @override
  State<Leavescreen> createState() => _LeavescreenState();
}

class _LeavescreenState extends State<Leavescreen> {
  String time() {
    if (DateTime.now().hour >= 6 && DateTime.now().hour < 12) {
      return 'Good Morning ${widget.results['firstname']}';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour <= 16) {
      return 'Good Afternoon ${widget.results['firstname']}';
    } else if (DateTime.now().hour > 16 && DateTime.now().hour <= 21) {
      return 'Good Evening ${widget.results['firstname']}';
    } else {
      return 'Good Night ${widget.results['firstname']}';
    }
  }

  var serial_number = TextEditingController();
  var userId = TextEditingController();
  String? type;
  final keys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton.filledTonal(
            onPressed: () {}, icon: const Icon(Icons.person_2_rounded)),
        Text(
          '${(widget.results['email']).split('@')[0]}',
        ),
      ], title: const Text('Your Leaves')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: keys,
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      time(),
                      style: const TextStyle(fontSize: 35.0),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextFormField(
                controller: serial_number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Serial Number',
                    hintText: 'e.g 567889',
                    prefixIcon: Icon(Icons.hail_sharp)),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid Serial';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: type,
                items: const [
                  DropdownMenuItem(
                    value: 'Academic',
                    child: Text('Academic'),
                  ),
                  DropdownMenuItem(
                    value: 'Annual',
                    child: Text('Annual'),
                  )
                ],
                onChanged: (String? v) {
                  setState(() {
                    type = v!;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Leave Type',
                    hintText: 'e.g Williams',
                    prefixIcon: Icon(Icons.person_2_outlined)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: userId,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Id',
                    hintText: 'e.g Williams',
                    prefixIcon: Icon(Icons.person_2_outlined)),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty || value.contains('@#%^*,&')) {
                    return 'Enter a valid UID';
                  } else {
                    return null;
                  }
                },
              ),
              OutlinedButton(
                  onPressed: () async {
                    //post to api
                    try {
                      var response = await http.post(
                          Uri.parse('$baseUrl/apply'),
                          body: json.encode({
                            'serial_number': serial_number.text,
                            'leave_type': type,
                            'user_id': userId.text
                          }),
                          headers: {'Content-type': 'application/json'});
                      if (response.statusCode == 200) {
                        //Successful
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response.body)));
                      } else {
                        // Failed
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response.body)));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));

                      // alert user
                      return;
                    }
                  },
                  child: const Text('Apply')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LeaveApplications()));
                  },
                  child: const Text('Applications'))
            ],
          ),
        ),
      ),
    );
  }
}
