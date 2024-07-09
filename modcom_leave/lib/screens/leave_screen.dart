import 'package:flutter/material.dart';

class Leavescreen extends StatelessWidget {
  const Leavescreen({super.key, required this.results});
  final Map results;

  String time(){
    if(DateTime.now().hour >= 6 && DateTime.now().hour < 12){
      return 'Good Morning ${results['First Name']}';

    }
    else if(DateTime.now().hour >= 12 && DateTime.now().hour <= 16){
      return 'Good Afternoon ${results['First Name']}';
    }
    else if(DateTime.now().hour > 16 && DateTime.now().hour <= 21){
      return 'Good Evening ${results['First Name']}';
    }
    else{
      return 'Good Night ${results['First Name']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.handshake),
        title: Center(
          child: Column(
            children: [
              Text(time(), style: const TextStyle(fontSize: 25.0),),
              Text('${(results['Email']).split('@')[0]}',  style: const TextStyle(fontSize: 12.0),),
                 
            ],
          ),
        )
      ),);
  }
}