import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart' as ds;
import 'package:provider/provider.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  bool gotLocation = false;
  bool nosched = true;

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
    Widget ShowPostList(BuildContext context,List<prodModal2> posts) {
    print(posts.length);
    for(int i=0; i<posts.length; i++){
      // print(posts[i].email);
      // print(posts[i].phone);
      // print(posts[i].purpose);
      // print(posts[i].enddate);
      // print(posts[i].date);
      // print(posts[i].status);
      if(posts[i].email == ds.phoneController.text && posts[i].status == 'accepted' && DateTime.parse(posts[i].enddate!).isAfter(DateTime.now())){
        nosched = false;
      }
    }


      return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            leadingWidth: 300,
            toolbarHeight: 150,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImage(image: DoctorUser.profile.image),
                Text('Welcome back,'),
                Text('Doctor', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
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
          SizedBox(height: 20,),
          Expanded(
            //color: Colors.black,
            child: SingleChildScrollView(
                    child: nosched ?
                    WhiteContainer(
                        child: Container(
                          height: 150,
                          width: 80,
                          child: Center(
                            child: Text('Your do not have any Upcomming Appointments.\n'
                                'Check Notifications for any new appointment request',textAlign: TextAlign.center,),
                          ),
                        )
                    ):
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            print('ye hai galat');
                            print(posts[0].date); // null hai kuchh hai hi nhi
                            //if(index == 0 ) return null; // abhi ke lie pahle do appointment skip kar die
                            // hain unme error aa rahi hai ,,, bad me ye condition hata denge
                            if(posts[index].email == ds.phoneController.text && posts[index].status == 'accepted' && DateTime.parse(posts[index].enddate!).isAfter(DateTime.now())){

                              return Column(
                                children: [
                                  DocAppointmentContainer(
                                    posts[index].purpose!,
                                      posts[index].phone.toString(),
                                      posts[index].date, posts[index].enddate),
                                  SizedBox(height: 10,)
                                ],
                              );
                            }
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
