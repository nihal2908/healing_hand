import 'package:flutter/material.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart' as ps;

import '../customWidgets/styles.dart';
httpServices13 http=new httpServices13();
class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  State<AppointmentRequestPage> createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<prodModal2>>(
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
            return ShowPostList(context, snapshot.data!);

          case ConnectionState.done:

            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
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

    bool waiting = false;
    bool denied = false;

    for(int i=0; i<posts.length; i++){
      if(posts[i].phone == ps.phoneController.text && posts[i].status == 'wait'){
        waiting = true;
      }
      else if(posts[i].phone == ps.phoneController.text && posts[i].status == 'denied'){
        denied = true;
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Pending Requests',
                style: headingStyle,
              ),
              SizedBox(height: 15,),
              waiting ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    if(posts[index].phone == ps.phoneController.text && posts[index].status.toString() == "wait")
                      return Column(
                        children: [
                          WhiteContainer(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                    title: Text(posts[index].purpose.toString()),
                                    subtitle: Text(posts[index].email.toString()),
                                  ),
                                  Divider(),
                                  Text('Status: Pending', style: TextStyle(color: Colors.blue),) // Text('Status: Denied', style: TextStyle(color: Colors.red),),
                                ],
                              )
                          ),
                          SizedBox(height: 7,)
                        ],
                      );
                    else
                      return Container();
                  },
                  itemCount: posts.length
              ) : WhiteContainer(child: Text('No Pending Requests', style: nameSytle,)),
              Text(
                'Denied Requests',
                style: headingStyle,
              ),
              SizedBox(height: 15,),
              denied ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    if(posts[index].phone == ps.phoneController.text && posts[index].status.toString() == "denied")
                      return Column(
                        children: [
                          WhiteContainer(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                    title: Text(posts[index].purpose.toString()),
                                    subtitle: Text(posts[index].email.toString()),
                                  ),
                                  Divider(),
                                  Text('Status: Denied', style: TextStyle(color: Colors.red),) // Text('Status: Denied', style: TextStyle(color: Colors.red),),
                                ],
                              )
                          ),
                          SizedBox(height: 7,)
                        ],
                      );
                    else
                      return Container();
                  },
                  itemCount: posts.length
              ) : WhiteContainer(child: Text('No Denied Requests', style: nameSytle,)),
            ],
          ),
        ),
      ),
    );
  }
}
