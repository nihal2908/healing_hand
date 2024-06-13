import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorHomePage.dart';
import 'package:healing_hand/DoctorPages/DoctorNotePage.dart';
import 'package:healing_hand/DoctorPages/DoctorSettingPage.dart';
import 'package:healing_hand/pages/ChatPage.dart';


class DoctorLandingPage extends StatefulWidget {
  const DoctorLandingPage({super.key});

  @override
  State<DoctorLandingPage> createState() => _DoctorLandingPageState();
}

List<Widget> HomePageScreen = [
  DoctorHomePage(),
  DoctorNotePage(),
  ChatPage(usertype: 'doctor',),
  DoctorSettingPage(),
];

class _DoctorLandingPageState extends State<DoctorLandingPage> {
  int currentPageIndex = 0;
  bool gotLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            selectedIcon: Icon(Icons.note_alt_sharp),
            icon: Icon(Icons.note_alt_outlined),
            label: 'Notes',
          ),
          NavigationDestination(
            //selectedIcon: Icon(),
            icon: Icon(Icons.message),
            label: 'Chats',
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