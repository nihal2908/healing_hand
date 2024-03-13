import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/PatientPages/PatientAppointmentsPage.dart';
import 'package:healing_hand/PatientPages/PatientSettingPage.dart';

class PatientLandingPage extends StatefulWidget {
  const PatientLandingPage({super.key});

  @override
  State<PatientLandingPage> createState() => _PatientLandingPageState();
}

List<Widget> HomePageScreen = [
  PatientHomePage(),
  PatientSchedulePage(),
  PatientSettingPage(),
];

class _PatientLandingPageState extends State<PatientLandingPage> {
  int currentPageIndex = 0;
  bool gotLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: HomePageScreen[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.deepPurple.shade200,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointments',
          ),
          NavigationDestination(
            //selectedIcon: Icon(),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}