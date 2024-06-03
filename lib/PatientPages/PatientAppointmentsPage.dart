// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
// import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
// import 'package:healing_hand/customWidgets/CircleImage.dart';
// import 'package:healing_hand/customWidgets/WhiteContainer.dart';
// import 'package:healing_hand/firebase/AuthServices.dart';
//
// final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
// class PatientSchedulePage extends StatefulWidget {
//   const PatientSchedulePage({super.key});
//
//   @override
//   State<PatientSchedulePage> createState() => _PatientSchedulePageState();
// }
//
// class _PatientSchedulePageState extends State<PatientSchedulePage> {
//   @override
//   Widget build(BuildContext context){
//     return FutureBuilder(
//         future: firestore.collection('Patient').doc(currentUserId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text('No data found for this patient.'));
//           }
//           else {
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             else {
//               Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//               List<String> appointmentIds = List<String>.from(data['appointments'] ?? []);
//               return Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                     children: [
//                       Text('Scheduled Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: appointmentIds.map((appointmentId) {
//                               return FutureBuilder<DocumentSnapshot>(
//                                 future: firestore.collection('Appointment').doc(appointmentId).get(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState == ConnectionState.waiting) {
//                                     return const CircularProgressIndicator();
//                                   }
//                                   if (!snapshot.hasData || !snapshot.data!.exists) {
//                                     return const SizedBox(); // Or some error widget
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text('Error: ${snapshot.error}');
//                                   }
//
//                                   Map<String, dynamic> appointmentData = snapshot.data!.data() as Map<String, dynamic>;
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                     child: WhiteContainer(
//                                         child: Column(
//                                           children: [
//                                             ListTile(
//                                               leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
//                                               title: Text(appointmentData['purpose']),
//                                               subtitle: Text(appointmentData['mode']),
//                                             ),
//                                             Divider(),
//                                             appointmentData['status'] == 'waiting' ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
//                                           ],
//                                         )
//                                     ),
//                                   );
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ]
//                 ),
//               );
//             }
//           }
//         }
//     );
//   }
//
//   // Widget ShowPostList(BuildContext context, posts )
//   // {
//   //   bool noUpComApp = true;
//   //   bool noPastApp = true;
//   //   for(int i=2; i<posts.length; i++){
//   //     if(DateTime.parse(posts[i].date.toString()).isAfter(DateTime.now()))
//   //       noUpComApp = false;
//   //     else
//   //       noPastApp = false;
//   //   }
//   //   return  SingleChildScrollView(
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(10),
//   //       child: Column(
//   //         children: [
//   //           SizedBox(
//   //             height: 100,
//   //             child: Center(child: Text('Appointments',)),
//   //           ),
//   //           SizedBox(height: 10,),
//   //           Text(
//   //             'Upcoming Appointments',
//   //             style: headingStyle,
//   //           ),
//   //           SizedBox(height: 15,),
//   //           if(posts.length == 0 || noUpComApp)
//   //             WhiteContainer(child: Text('No Upcoming Appointments', style: nameSytle,)),
//   //           //not used listview builder because it altered the scroll above the list
//   //           for(int i=2; i<posts.length; i++)
//   //             //if(posts[i].phone==remember.toString() && posts[i].status == 'accepted' && DateTime.parse(posts[i].enddate.toString()).isAfter(DateTime.now()))
//   //             Column(
//   //               children: [
//   //                 AppointmentContainer(email:posts[i].email,enddate: posts[i].enddate,date: posts[i].date,
//   //                 status: posts[i].status,phone: posts[i].phone,purpose: posts[i].purpose,),
//   //                 SizedBox(height: 10),
//   //               ],
//   //             ),
//   //           SizedBox(height: 15,),
//   //           Text(
//   //             'Past Consultations',
//   //             style: headingStyle,
//   //           ),
//   //           SizedBox(height: 15,),
//   //           if(posts.length == 0 || noPastApp)
//   //             WhiteContainer(child: Text('No Past Consultations', style: nameSytle,)),
//   //           //not used listview builder because it altered the scroll above the list
//   //           for(int i=2; i<posts.length; i++)
//   //             //if(posts[i].phone==remember.toString() && posts[i].status == 'accepted' && DateTime.parse(posts[i].enddate.toString()).isBefore(DateTime.now()))
//   //             Column(
//   //               children: [
//   //                 AppointmentContainer(email:posts[i].email,enddate: posts[i].enddate,date: posts[i].date,
//   //                 status: posts[i].status,phone: posts[i].phone,purpose: posts[i].purpose,),
//   //                 SizedBox(height: 10),
//   //               ],
//   //             ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({Key? key}) : super(key: key);

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {

  List<Map<String, dynamic>> upcomingAppointments = [];
  List<Map<String, dynamic>> pastAppointments = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getList(),
        builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text('Upcoming Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: upcomingAppointments.map((e) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: WhiteContainer(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                          title: Text(e['purpose']),
                                          subtitle: Text(e['mode']),
                                        ),
                                        Divider(),
                                        e['status'] == "waiting" ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
                                      ],
                                    )
                                ),
                              )
                          ).toList()
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Past Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: pastAppointments.map((e) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: WhiteContainer(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                        title: Text(e['purpose']),
                                        subtitle: Text(e['mode']),
                                      ),
                                      Divider(),
                                      e['status'] == "waiting" ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
                                    ],
                                  )
                              ),
                            )
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
  
  Future<void> getList() async {
    List<String> apps = await firestore.collection('Patient').doc(currentUserId).collection('appointments').get() as List<String>;
    for(String a in apps){
      Map<String, dynamic> data = await firestore.collection('Appointment').doc(a).get() as Map<String, dynamic>;
      if(data['status']=='accepted'){
        upcomingAppointments.add(data);
      }
      else if(data['status']=='attended'){
        pastAppointments.add(data);
      }
    }
  }
  
}