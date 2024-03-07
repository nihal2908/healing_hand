import 'package:flutter/material.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

List<Widget> HomePageScreen = [Text('1'), Text('2'), Text('3')];

class _PatientHomePageState extends State<PatientHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome "username"'),
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                    child: Text('Settings'),
                    onTap: (){},
                  ),
                  PopupMenuItem(
                    child: Text('Help & feedback'),
                    onTap: (){},
                  ),
                ];
              }
          )
        ],
      ),
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
            //selectedIcon: Icon(Icons.looks_one),
            icon: Icon(Icons.looks_one),
            label: 'first',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.access_time_filled),
            icon: Badge(label: Icon(Icons.looks_two, color: Colors.white, size: 10,),
              child: Icon(Icons.looks_two),),
            label: 'second',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.looks_3),
            label: 'third',
          ),
        ],
      ),

    );
  }
}
