

import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
httpServices13 http=new httpServices13();
class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({super.key});

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<prodModal2>>(
      future: http.getAllPost2(key),
      builder: ((context, snapshot) {
        print("calm down");
        // print(key);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Scaffold(
              body:
                  Center(heightFactor: 1.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.waiting:
            return Scaffold(
              body:
                  Center(heightFactor: 0.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.active:
          if(snapshot.data!=null)
            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
            else
            return CircularProgressIndicator();
          case ConnectionState.done:
          if(snapshot.data!=null)
            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
            else
            return CircularProgressIndicator();
        }
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      }),
    );
  }
  Widget ShowPostList(BuildContext context,List<prodModal2> posts )
  {
    bool noUpComApp = true;
    bool noPastApp = true;
    for(int i=0; i<posts.length; i++){
      print("flag");
      print(posts[i].status);
      print(DateTime.parse(posts[i].date.toString()));
      if(DateTime.parse(posts[i].date.toString()).isAfter(DateTime.now()))
        noUpComApp = false;
      else
        noPastApp = false;
    }
    return  SingleChildScrollView(
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
            if(posts.length == 0 || noUpComApp)
              WhiteContainer(child: Text('No Upcoming Appointments', style: nameSytle,)),
            //not used listview builder because it altered the scroll above the list
            for(int i=0; i<posts.length; i++)
              if(DateTime.parse(posts[i].date.toString()).isAfter(DateTime.now()) && posts[i].phone==remember.toString())
              Column(
                children: [
                  AppointmentContainer(email:posts[i].email,enddate: posts[i].enddate,date: posts[i].date,
                  status: posts[i].status,phone: posts[i].phone,purpose: posts[i].purpose,),
                  SizedBox(height: 10),
                ],
              ),
            SizedBox(height: 15,),
            Text(
              'Past Consultations',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 15,),
            if(posts.length == 0 || noPastApp)
              WhiteContainer(child: Text('No Past Consultations', style: nameSytle,)),
            //not used listview builder because it altered the scroll above the list
            for(int i=0; i<posts.length; i++)
              if(DateTime.parse(posts[i].date.toString()).isBefore(DateTime.now()) && posts[i].phone==remember.toString())
              Column(
                children: [
                  AppointmentContainer(email:posts[i].email,enddate: posts[i].enddate,date: posts[i].date,
                  status: posts[i].status,phone: posts[i].phone,purpose: posts[i].purpose,),
                  SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
