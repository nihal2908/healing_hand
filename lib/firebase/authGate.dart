import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/NewPages/first.dart';
import 'package:healing_hand/NewPages/second.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/pages/HelpPage.dart';
import 'package:healing_hand/pages/UserTypePage.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print('login hua to hai ');
            return FirstPage();
          }
          else{
            print('bahar nikal');
            return PatientSignupPage();
          }
        },
    );
  }
}
