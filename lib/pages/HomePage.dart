import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helping Hand'),
        centerTitle: true,
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
    );
  }
}
