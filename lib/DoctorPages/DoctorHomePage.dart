import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:provider/provider.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  bool gotLocation = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            leadingWidth: 300,
            toolbarHeight: 130,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImage(imagePath: 'assets/images/doctor.png'),
                Text('Welcome back,'),
                Text(DoctorUser.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
              ],
            ),
            actionsIconTheme: IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
                  },
                  icon: Icon(Icons.notifications)
              ),
            ],
          ),
          Text('Scheduled Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
          Expanded(
            //color: Colors.black,
            child: Consumer<DoctorProvider>(
              builder: (context, DoctorModel, child) =>
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            if(appointments[index].date.isAfter(DateTime.now()) && appointments[index].status == 'accepted')
                              return Column(
                                children: [
                                  DocAppointmentContainer(appointment: appointments[index]),
                                  SizedBox(height: 10,)
                                ],
                              );
                            else
                              return Container();
                          },
                          itemCount: appointments.length,
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
