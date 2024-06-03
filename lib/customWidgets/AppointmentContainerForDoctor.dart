import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/PatientViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';

TextStyle nameSytle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600
);

class DocAppointmentContainer extends StatelessWidget {
  final Map<String, dynamic> app;
  DocAppointmentContainer({required this.app});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return WhiteContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(app['purpose'], style: nameSytle,),
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
                      Text((app['date'].day).toString()+'-'+app['date'].month.toString()+'-'+app['date'].year.toString()),
                      Text('${app['start'].hour.toString()+':'+app['start'].minute.toString()}-${app['end'].hour.toString()+':'+app['end'].minute.toString()}')
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
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: FutureBuilder(
                  future: firestore.collection('Patient').doc(app['patient']).get(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      else {
                        Map<String, dynamic> patient = snapshot.data!.data() as Map<String, dynamic>;
                        return ListTile(
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
                                backgroundImage: NetworkImage(patient['profile']),
                              ),
                            ),
                          ),
                          title: Text(patient['name']),
                          subtitle: Text('Age: '+patient['age'].toString()+' / Gender: '+patient['gender']),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientViewPage(uid: patient['uid'],)));
                          },
                        );
                      }
                    }
                  }
              ),
            )
          ],
        )
    );
  }
}
