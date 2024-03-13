import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
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
                if(posts[index].status.toString() == "wait" || posts[index].status.toString() == "denied")
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(imagePath: 'assets/images/doctor.png'),
                                title: Text(posts[index].purpose.toString()),
                                subtitle: Text(posts[index].email.toString()),
                              ),
                              Divider(),
                              posts[index].status == "wait" ? Text('Status: Waiting') : Text('Status: Denied'),
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
          ),
        ),
      ),
    );
  }
}
