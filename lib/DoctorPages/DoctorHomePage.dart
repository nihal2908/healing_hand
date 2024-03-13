import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
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
    return  FutureBuilder<List<prodModal2>>(
      future: http.getAllPost2(""),
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
    Widget ShowPostList(BuildContext context,List<prodModal2> posts)
    {
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
                CircleImage(image: AssetImage('assets/images/doctor.png')),
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
            child:          SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            if(DateTime.parse(posts[index].date.toString()).isAfter(DateTime.now()) && posts[index].status == 'accepted')
                              return Column(
                                children: [
                                  DocAppointmentContainer(posts[index].phone.toString(),posts[index].date,posts[index].enddate),
                                  SizedBox(height: 10,)
                                ],
                              );
                            else
                              return Container();
                          },
                          itemCount: posts.length,
                        ),
                      ],
                    ),
                  ),
            ),

    ]),
    );

    }
}
