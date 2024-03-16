import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/PatientViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/userer.dart';
import 'package:healing_hand/pages/ChatRoom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart' as ds;
import 'package:url_launcher/url_launcher_string.dart';

TextStyle nameSytle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600
);
String? num1,date1,time1, purpose1;
DateTime? sdate,edate;
class DocAppointmentContainer extends StatelessWidget {
  //final Appointment appointment;
  DocAppointmentContainer(String purpose, String num, String? date, String? time)
  {
    purpose1 = purpose;
    num1=num;
    date1=date;
    time1=time;
    sdate=DateTime.parse(date1.toString());
    edate=DateTime.parse(time1.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<prodModal3>>(
      future: http.getAllPost5(num1),
      builder: ((context, snapshot) {
        
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
  Widget ShowPostList(BuildContext context,List<prodModal3> posts)
  {
    return GestureDetector(
      onTap: (){
        (sdate!.isAfter(DateTime.now()) && edate!.isBefore(DateTime.now())) ?
        showAppointmentActions(context) : null ;
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(purpose1.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.access_time_filled),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((sdate!.day).toString()+' - '+(sdate!.month.toString()+' - '+sdate!.year.toString())),
                        Text(sdate!.hour.toString()+' : '+sdate!.minute.toString()+' - '+edate!.hour.toString()+':'+sdate!.minute.toString())
                      ],
                    ),
                  ),
               //   Text(appointment.type),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 32.0,
                        backgroundImage: AssetImage('assets/images/demo_user.jpg'),
                      ),
                    ),
                  ),
                  title: Text(posts[0].user_name.toString()),
                  subtitle: Text('Age: '+posts[0].age.toString()+' / Gender: '+posts[0].gender.toString()),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientViewPage(
                       posts[0].user_name,
                       posts[0].user_email,
                       posts[0].pass,
                       posts[0].phone,
                       posts[0].weight,
                       posts[0].height,
                       posts[0].age,
                       posts[0].gender
                    )));
                  },
                ),
              )
            ],
          )
      ),
    );
  }
  void showAppointmentActions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(purpose1.toString()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: ()async{
                      //ChatService chat = ChatService();
                      //String docId = await chat.getUIDFromEmail(phone1!);
                      //chat.connectDoctorPatient(docId, currentUserId);
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>ChatRoom3(senderemail: ds.phoneController.text, recieveremail: num1!, name: num1!,)));
                      print('Chat with Patient');
                    },
                    child: Column(children: [Icon(Icons.message), Text('Chat with Patient')],)
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: (){
                      print('Make a voice call');
                      launchUrl(
                          Uri(scheme: 'tel', path: '9569399400'),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    child: Column(children: [Icon(Icons.call), Text('Make a Voice Call')],)
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: (){
                      print('Make a video call');
                    },
                    child: Column(children: [Icon(Icons.video_call), Text('Make a Video Call')],)
                ),
              ],
            ),
          );
        }
    );
  }
}
