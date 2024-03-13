import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class AppointmentContainer extends StatelessWidget {
  Appointment appointment;

  //abto appointment class ke according data aega nhi yha ?? to ui me changes karne padenge

  AppointmentContainer({required this.appointment});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();


    return WhiteContainer(
      child: InkWell(

        // there will be option for patient to call doctor between start ans endtime
        onTap: (appointment.status == 'accepted' && appointment.date.day == now.day && appointment.date.month == now.month &&
            appointment.date.year == now.year && appointment.startTime.hour < now.hour &&
            appointment.startTime.minute < now.minute && appointment.endTime.hour < now.hour &&
            appointment.endTime.minute < now.minute) ? (){
          showAppointmentActions(context);
        } : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.purpose, style: nameSytle,),
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
                      Text(appointment.date.day.toString()+'-'+appointment.date.month.toString()+'-'+appointment.date.year.toString()),
                      Text('${appointment.startTime.hour.toString()+':'+appointment.startTime.minute.toString()}-${appointment.endTime.hour.toString()+':'+appointment.endTime.minute.toString()}')
                    ],
                  ),
                ),
                Text(appointment.type),
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
            title: Text(appointment.purpose),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: (){
                      print('Chat with Doctor');
                    },
                    child: Column(children: [Icon(Icons.message), Text('Chat with Doctor')],)
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: (){
                      print('Make a voice call');
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
