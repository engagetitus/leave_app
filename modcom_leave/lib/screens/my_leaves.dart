import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modcom_leave/data/api.dart';

class LeaveApplications extends StatefulWidget {
  const LeaveApplications({super.key});

  @override
  State<LeaveApplications> createState() => _LeaveApplicationsState();
}

class _LeaveApplicationsState extends State<LeaveApplications> {
  // show a List of Applications
  //- user_id, serial_number,leave_type, serial_number,
  List<dynamic> getApplications() {
    return applications;
  }

  @override
  void initState() {
    super.initState();
    getLeaves();
  }

  List applications = [];
  // function to fetch our data from the api /leave-app
  Future getLeaves() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/leave-apps'));
    if (response.statusCode == 200) {
      showAlert('FOUND', context);
      setState(() {
        applications = json.decode(response.body) as List<dynamic>;
      });
    } else {}
  }

  Future deleteLeave(int id) async {
    http.Response response =
        await http.delete(Uri.parse('$baseUrl/leave-apps/$id'));
    if (response.statusCode == 200) {
      getLeaves();
    } else {
      return;
    }
    showAlert(response.body, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getLeaves();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('My Applications'),
            Column(
              children: List.generate(applications.length, (index) {
                return ListTile(
                  title: Text(
                    applications[index]['leave_type'],
                  ),
                  leading: CircleAvatar(
                    child: Text(applications[index]['user_id'].toString()),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                          onPressed: () {
                            deleteLeave(applications[index]['id']);
                          },
                          icon: Icon(Icons.delete)),
                      IconButton.filled(
                          onPressed: () {
                            //Implement a Update / Put
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applications[index]['serial_number'],
                      ),
                      Text(
                        applications[index]['createdAt'],
                      ),
                      const Divider(
                        thickness: 3,
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
