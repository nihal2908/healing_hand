import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  State<AppointmentRequestPage> createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Requests'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: firestore.collection('Patient').doc(currentUserId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.black,));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No data found for this doctor.'));
            }
            else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              else {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                List<String> appointmentIds = List<String>.from(data['appointments'] ?? []);
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: appointmentIds.map((appointmentId) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: firestore.collection('Appointment').doc(appointmentId).get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const SizedBox(); // Or some error widget
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
      
                            Map<String, dynamic> appointmentData = snapshot.data!.data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: WhiteContainer(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                        title: Text(appointmentData['purpose']),
                                        subtitle: Text(appointmentData['mode']),
                                      ),
                                      Divider(),
                                      appointmentData['status'] == "waiting" ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
                                    ],
                                  )
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              }
            }
          }
      ),
    );
  }
  // Widget ShowPostList(BuildContext context,List<prodModal2> posts)
  // {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Notifications'),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: EdgeInsets.all(8),
  //         child: ListView.builder(
  //             shrinkWrap: true,
  //             itemBuilder: (context, index){
  //               if(posts[index].status.toString() == "wait" || posts[index].status.toString() == "denied")
  //                 return Column(
  //                   children: [
  //                     WhiteContainer(
  //                         child: Column(
  //                           children: [
  //                             ListTile(
  //                               leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
  //                               title: Text(posts[index].purpose.toString()),
  //                               subtitle: Text(posts[index].email.toString()),
  //                             ),
  //                             Divider(),
  //                             posts[index].status == "wait" ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
  //                           ],
  //                         )
  //                     ),
  //                     SizedBox(height: 7,)
  //                   ],
  //                 );
  //               else
  //                 return Container();
  //             },
  //             itemCount: posts.length
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
