import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/pages/HomePage.dart';
import 'package:healing_hand/pages/OnBoardingPage.dart';
import 'package:healing_hand/pages/UserTypePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isNewUser = true;

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool('IS_NEW_USER')!=null){
    isNewUser = prefs.getBool('IS_NEW_USER')!;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: isNewUser? const OnBoardingPage() : const UserTypePage(),
      //home: const OnBoardingPage(),
      home: const PatientLandingPage(),
    );
  }
}

