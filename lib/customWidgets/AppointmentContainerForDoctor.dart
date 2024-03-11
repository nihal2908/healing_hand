import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/PatientViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

TextStyle nameSytle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600
);

class DocAppointmentContainer extends StatelessWidget {
  final Appointment appointment;
  DocAppointmentContainer({required this.appointment});

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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
                      backgroundImage: appointment.patient.profile.image,
                    ),
                  ),
                ),
                title: Text(appointment.patient.name),
                subtitle: Text('Age: '+appointment.patient.age.toString()+' / Gender: '+appointment.patient.gender),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientViewPage(patient: appointment.patient)));
                },
              ),
            )
          ],
        )
    );
  }
}
