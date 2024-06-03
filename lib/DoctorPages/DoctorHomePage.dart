import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorAccountPage.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
          future: firestore.collection('Doctor').doc(currentUserId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No data found for this doctor.'));
            }
            else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              else {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                List<String> appointmentIds = List<String>.from(data['appointments'] ?? []);
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      AppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        leadingWidth: 300,
                        toolbarHeight: 150,
                        leading: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const DoctorAccountRequest()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data['profile'] == null ?
                              CircleImage(image: const AssetImage('assets/images/default_dp.jpg')) :
                              CircleImage(image: NetworkImage(data['profile'])),
                              const Text('Welcome back,'),
                              Text(data['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
                            ],
                          ),
                        ),
                        actionsIconTheme: const IconThemeData(
                          size: 30,
                        ),
                        actions: [
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage(appId: appointmentIds,)));
                              },
                              icon: const Icon(Icons.notifications)
                          ),
                        ],
                      ),
                      const Text('Scheduled Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                              children: appointmentIds.map((appointmentId) {
                                return FutureBuilder<DocumentSnapshot>(
                                  future: firestore.collection('Appointments').doc(appointmentId).get(),
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
                                      child: DocAppointmentContainer(
                                        app: appointmentData,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ]
                  ),
                );
              }
            }
          }
        );
    }
}
