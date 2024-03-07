import 'package:flutter/material.dart';

class PatientSettingPage extends StatefulWidget {
  const PatientSettingPage({super.key});

  @override
  State<PatientSettingPage> createState() => _PatientSettingPageState();
}

class _PatientSettingPageState extends State<PatientSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 100,),
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
                      children: [
                        ListView(
                          children: [
                            ListTile(
                              title: Text('Choose theme'),
                              subtitle: Text('Light'),
                              onTap: (){
                                selectTheme();
                              },
                            )
                          ],
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

  void selectTheme() {}
}
