import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/pages/HelpPage.dart';

class PatientSettingPage extends StatefulWidget {
  const PatientSettingPage({super.key});

  @override
  State<PatientSettingPage> createState() => _PatientSettingPageState();
}

class _PatientSettingPageState extends State<PatientSettingPage> {
  int selectedTheme = 0;
  int newTheme = 0;
  List<String> themename = ['Light', 'Dark', 'System default'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(child: Text('Settings', style: titleStyle,)),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Your Profile'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PatientAccountPage()));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.light_mode),
                          title: const Text('Choose theme'),
                          subtitle: Text(themename[selectedTheme]),
                          onTap: (){
                            selectTheme();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('Help & feedback'),
                          onTap: (){
                            print('Help pressed');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpPage()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.star),
                          title: Text('Rate Helping Hand'),
                          onTap: (){
                            print('Rating pressed');
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  void selectTheme(){
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: const Text('Choose theme'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Radio<int>(
                      value: 0,
                      groupValue: selectedTheme,
                      onChanged: (value){
                        setState(() {
                          selectedTheme = value!;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(themename[0]),
                  ),
                  ListTile(
                    leading: Radio<int>(
                      value: 1,
                      groupValue: selectedTheme,
                      onChanged: (value){
                        setState(() {
                          selectedTheme = value!;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(themename[1]),
                  ),
                  ListTile(
                    leading: Radio<int>(
                      value: 2,
                      groupValue: selectedTheme,
                      onChanged: (value){
                        setState(() {
                          selectedTheme = value!;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(themename[2]),
                  ),
                ],
              ),
            )
    );
  }

}

