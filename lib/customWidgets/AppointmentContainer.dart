import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

class AppointmentContainer extends StatelessWidget {
  Appointment appointment;
  AppointmentContainer({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
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
         // DoctorTile(doc: appointment.doctor)
        ],
      )
    );
  }
}
