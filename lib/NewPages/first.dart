import 'package:flutter/material.dart';
import 'package:healing_hand/NewPages/ProfileScreen.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login hai'),
        actions: [
          IconButton(onPressed: (){
            AuthServices().signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientAccountRequest()));
                },
              icon: Icon(Icons.forward, color: Colors.white,),
            ),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },
              icon: Icon(Icons.person, color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
