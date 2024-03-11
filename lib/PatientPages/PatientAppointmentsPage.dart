import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({super.key});

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {
  @override
  Widget build(BuildContext context) {
    bool noUpComApp = true;
    bool noPastApp = true;
    for(int i=0; i<appointments.length; i++){
      if(appointments[i].date.isAfter(DateTime.now()))
        noUpComApp = false;
      else
        noPastApp = false;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(child: Text('Appointments', style: titleStyle)),
            ),
            SizedBox(height: 10,),
            Text(
              'Upcoming Appointments',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 15,),
            if(appointments.length == 0 || noUpComApp)
              WhiteContainer(child: Text('No Upcoming Appointments', style: nameSytle,)),
            //not used listview builder because it altered the scroll above the list
            for(int i=0; i<appointments.length; i++)
              if(appointments[i].date.isAfter(DateTime.now()))
              Column(
                children: [
                  AppointmentContainer(appointment: appointments[i]),
                  SizedBox(height: 10),
                ],
              ),
            SizedBox(height: 15,),
            Text(
              'Past Consultations',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 15,),
            if(appointments.length == 0 || noPastApp)
              WhiteContainer(child: Text('No Past Consultations', style: nameSytle,)),
            //not used listview builder because it altered the scroll above the list
            for(int i=0; i<appointments.length; i++)
              if(appointments[i].date.isBefore(DateTime.now()))
              Column(
                children: [
                  AppointmentContainer(appointment: appointments[i]),
                  SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
