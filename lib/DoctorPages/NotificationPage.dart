import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/PatientViewPage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AppointmentFunctions.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class NotificationPage extends StatefulWidget {
  final List<String> appId;
  const NotificationPage({super.key, required this.appId});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ...widget.appId.map((appointmentId) {
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

                    Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data == null || data['status'] != 'waiting') {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: WhiteContainer(
                        child: Column(
                          children: [
                            Text(data['purpose']),
                            Text(data['mode']),
                            FutureBuilder<DocumentSnapshot>(
                              future: firestore.collection('Patient').doc(data['patientUid']).get(),
                              builder: (context, patSnapshot) {
                                if (patSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                if (patSnapshot.hasError) {
                                  return Text('Error: ${patSnapshot.error}');
                                }
                                if (!patSnapshot.hasData || !patSnapshot.data!.exists) {
                                  return const SizedBox(); // Or some error widget
                                }

                                Map<String, dynamic>? patient = patSnapshot.data!.data() as Map<String, dynamic>?;
                                if (patient == null) {
                                  return const SizedBox(); // Or some error widget
                                }

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
                                  subtitle: Text('Age: ${patient['age']} / Gender: ${patient['gender']}'),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => PatientViewPage(uid: patient['uid']),
                                    ));
                                  },
                                );
                              },
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await firestore.collection('Appointment').doc(appointmentId).update({'status': 'denied'});
                                  },
                                  child: const Text('Deny', style: TextStyle(color: Colors.red)),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await selectDateTime(context, appointmentId);
                                  },
                                  child: const Text('Accept', style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
