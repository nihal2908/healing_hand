import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart' as ps;
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';

import '../customWidgets/styles.dart';
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
        print("calm downn");
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
    print(posts.length);
    for(int i=0; i<posts.length; i++) {
      if (posts[i].phone == ps.phoneController.text && posts[i].status == 'accepted') {
        if (DateTime.parse(posts[i].enddate!).isBefore(DateTime.now())) {
          noPastApp = false;
        }
        else if(DateTime.parse(posts[i].enddate!).isAfter(DateTime.now())){
          noUpComApp = false;
        }
      }
      print("flag");
      print(posts[i].status);
      print(posts[i].purpose);
      print(posts[i].email);
      print(posts[i].phone);
      print(posts[i].toString());
      print(DateTime.parse(posts[i].date.toString()));
      print(DateTime.parse(posts[i].enddate.toString()));
      // if(DateTime.parse(posts[i].date.toString()).isAfter(DateTime.now()))
      //   noUpComApp = false;
      // else
      //   noPastApp = false;
      print(noPastApp);
      print(noUpComApp);
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
              style: headingStyle,
            ),
            SizedBox(height: 15,),
            !noUpComApp ?
            ListView(
              shrinkWrap: true,
              children: posts.map((e) =>
                (e.phone == ps.phoneController.text && e.status == 'accepted' && DateTime.parse(e.enddate!).isAfter(DateTime.now()))?
                  //print(e.purpose);
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppointmentContainer(
                      email1: e.email,
                      enddate1: e.enddate,
                      date1: e.date,
                      status1: e.status,
                      phone1: e.phone,
                      purpose1: e.purpose,
                      time1: e.enddate,
                    ),
                  )
                 :
                  // Return an empty container if the condition doesn't match
                  Container()
              ).toList(),
            ) : WhiteContainer(child: Text('No Upcoming Consultations', style: nameSytle,)),
            SizedBox(height: 15,),
            Text(
              'Past Consultations',
              style: headingStyle,
            ),
            SizedBox(height: 15,),
            noPastApp ?
              WhiteContainer(child: Text('No Past Consultations', style: nameSytle,)) :
            ListView(
              shrinkWrap: true,
              children: posts.map((e) {
                if (e.phone == ps.phoneController.text && e.status == 'accepted' && DateTime.parse(e.enddate!).isBefore(DateTime.now())) {
                  print(e.purpose);
                  return Column(
                    children: [
                      AppointmentContainer(
                        email1: e.email,
                        enddate1: e.enddate,
                        date1: e.date,
                        status1: e.status,
                        phone1: e.phone,
                        purpose1: e.purpose,
                        time1: e.enddate,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
