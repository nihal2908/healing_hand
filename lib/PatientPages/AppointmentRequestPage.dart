import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  State<AppointmentRequestPage> createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {
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
                if(appointments[index].status == 'waiting' || appointments[index].status == 'denied')
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(imagePath: 'assets/images/doctor.png'),
                                title: Text(appointments[index].purpose),
                                subtitle: Text(appointments[index].doctor.name),
                              ),
                              Divider(),
                              appointments[index].status == 'waiting' ? Text('Status: Waiting') : Text('Status: Denied'),
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
