import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/chat_services/chatServices.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/pages/ChatRoom.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentContainer extends StatelessWidget {
//  Appointment appointment;
  final String? phone1;
  final String? email1;
  final String? date1;
  final String? time1;
  final String? status1;
  final String? purpose1;
  final String? enddate1;

  //abto appointment class ke according data aega nhi yha ?? to ui me changes karne padenge

  AppointmentContainer({required this.phone1, required this.email1,
  required this.date1, required this.status1, required this.enddate1, required this.purpose1, required this.time1});
  // {
  //   phone1=phone;
  //   email1=email;
  //   date1=date;
  //   time1=time;
  //   status1=status;
  //   purpose1=purpose;
  //   enddate1=enddate;
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();


    return WhiteContainer(
        child: InkWell(
          // there will be option for patient to call/chat with doctor between start ans endtime
          onTap: (DateTime.parse(date1.toString()).isBefore(DateTime.now()) && DateTime.parse(enddate1.toString()).isAfter(DateTime.now())) ? (){
            showAppointmentActions(context);
          } : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(purpose1.toString(), style: TextStyle(fontSize: 19,),),
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
                        Text(DateTime.parse(date1.toString()).day.toString()+' - '+DateTime.parse(date1.toString()).month.toString()+' - '+DateTime.parse(date1.toString()).year.toString()),
                        Text(DateTime.parse(date1.toString()).hour.toString()+':'+DateTime.parse(date1.toString()).minute.toString()+' - '+DateTime.parse(enddate1.toString()).hour.toString()+':'+DateTime.parse(enddate1.toString()).minute.toString())
                      ],
                    ),
                  ),
                  Text('Online')
                  // Text(appointment.type),
                ],
              ),
              SizedBox(height: 5,),
              //DoctorTile(doc: appointment.doctor)
            ],
          ),
        )
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom3(senderemail: currentUserEmail, recieveremail: email1!, name: email1!,)));
                      print('Chat with Doctor');
                    },
                    child: Column(children: [Icon(Icons.message), Text('Chat with Doctor')],)
                ),
                // SizedBox(height: 5,),
                // ElevatedButton(
                //     onPressed: (){
                //       print('Make a voice call');
                //       launchUrl(
                //           Uri(scheme: 'tel', path: '9569399400'),
                //           mode: LaunchMode.externalApplication
                //       );
                //     },
                //     child: Column(children: [Icon(Icons.call), Text('Make a Voice Call')],)
                // ),
                // SizedBox(height: 5,),
                // ElevatedButton(
                //     onPressed: (){
                //       print('Make a video call');
                //     },
                //     child: Column(children: [Icon(Icons.video_call), Text('Make a Video Call')],)
                // ),
              ],
            ),
          );
        }
    );
  }
}
