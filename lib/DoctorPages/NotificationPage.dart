import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index){
                if(appointments[index].status == 'waiting')
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                                title: Text(appointments[index].patient.name),
                                subtitle: Text(appointments[index].purpose),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          appointments[index].status = 'denied';
                                        });
                                      },
                                      child: Text('Deny', style: TextStyle(color: Colors.red),)
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          appointments[index].status = 'accepted';
                                          appointments[index].date = DateTime(2024, 03, 20);
                                          appointments[index].startTime = TimeOfDay(hour: 10, minute: 00);
                                          appointments[index].endTime = TimeOfDay(hour: 10, minute: 30);
                                        });
                                      },
                                      child: Text('Accept', style: TextStyle(color: Colors.green),)
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 7,)
                    ],
                  );
                else
                  return Container();
              },
              itemCount: appointments.length
          ),
        ),
      ),
    );
  }
}
