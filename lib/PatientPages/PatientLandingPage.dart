import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/PatientPages/PatientEmergencyPage.dart';
import 'package:healing_hand/PatientPages/PatientSettingPage.dart';
import 'package:healing_hand/customWidgets/roundedImageBox.dart';

class PatientLandingPage extends StatefulWidget {
  const PatientLandingPage({super.key});

  @override
  State<PatientLandingPage> createState() => _PatientLandingPageState();
}

List<Widget> HomePageScreen = [
  PatientHomePage(),
  PatientSchedulePage(),
  PatientSettingPage(),
  PatientAccountPage()
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
            selectedIcon: Icon(Icons.warning),
            icon: Badge(
              backgroundColor: Colors.deepPurple,
              label: SizedBox.square(dimension: 7,),
              child: Icon(Icons.warning_amber),
            ),
            label: 'Emergency',
          ),
          NavigationDestination(
            //selectedIcon: Icon(),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}