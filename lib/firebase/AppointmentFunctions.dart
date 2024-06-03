import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentFunctions{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> addAppointment({
    required String patient,
    required String doctor,
    required String status,
    required String mode,
    required String purpose,
  }) async {
    firestore.collection('Appointment').add(
        {
          'patient': patient,
          'doctor': doctor,
          'mode': mode,
          'status': status,
          'purpose': purpose
        }
    );
    return '';
  }
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> createAppointment({
  required String patient,
  required String doctor,
  required String status,
  required String mode,
  required String purpose,
}) async {
  DocumentReference appointmentRef = firestore.collection('Appointment').doc();

  Map<String, dynamic> appointmentData = {
    'doctorUid': doctor,
    'patientUid': patient,
    'mode': mode,
    'status': status,
    'purpose': purpose
  };

  // Set appointment data in Firestore
  await appointmentRef.set(appointmentData);

  // Get the ID of the newly created appointment
  String appointmentId = appointmentRef.id;

  // Update patient's 'appointments' field with the new appointment ID
  await firestore.collection('Patient').doc(patient).update({
    'appointments': FieldValue.arrayUnion([appointmentId]),
  });

  // Update doctor's 'appointments' field with the new appointment ID
  await firestore.collection('Doctor').doc(doctor).update({
    'appointments': FieldValue.arrayUnion([appointmentId]),
  });

}

Future<void> selectDateTime(BuildContext context, String appId) async {
  DateTime? pickedDate;
  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;
  bool isUpdating = false;
  String? errorMessage;

  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dialog from closing on outside tap
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void updateAppointment() async {
            if (pickedDate != null && pickedStartTime != null && pickedEndTime != null) {
              setState(() {
                isUpdating = true; // Show circular progress indicator
                errorMessage = null; // Clear previous error message
              });

              try {
                await FirebaseFirestore.instance.collection('Appointment').doc(appId).update({
                  'status': 'accepted',
                  'date': pickedDate,
                  'start': pickedStartTime,
                  'end': pickedEndTime,
                });

                setState(() {
                  isUpdating = false; // Hide circular progress indicator
                  errorMessage = null; // Clear error message
                });
              } catch (e) {
                print('Error updating appointment: $e');
                setState(() {
                  isUpdating = false; // Hide circular progress indicator
                  errorMessage = 'Error updating appointment: $e'; // Set error message
                });
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Select Date and Time...'),
                ),
              );
            }
          }

          return AlertDialog(
            title: Text('Select Date and Time'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${pickedDate != null ? '${pickedDate!.day.toString().padLeft(2, '0')}-${pickedDate!.month.toString().padLeft(2, '0')}-${pickedDate!.year}' : 'Not Selected'}'),
                Text('Start Time: ${pickedStartTime != null ? '${pickedStartTime!.hour.toString().padLeft(2, '0')}:${pickedStartTime!.minute.toString().padLeft(2, '0')}' : 'Not Selected'}'),
                Text('End Time: ${pickedEndTime != null ? '${pickedEndTime!.hour.toString().padLeft(2, '0')}:${pickedEndTime!.minute.toString().padLeft(2, '0')}' : 'Not Selected'}'),
                ElevatedButton(
                  onPressed: () async {
                    pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2024, 12, 30),
                    );
                    if (pickedDate != null) {
                      pickedStartTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedStartTime != null) {
                        pickedEndTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedEndTime != null) {
                          setState(() {}); // Refresh the AlertDialog content
                        }
                      }
                    }
                  },
                  child: Text('Select'),
                ),
                if (errorMessage != null) // Show error message if present
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: isUpdating
                    ? null
                    : () {
                  updateAppointment(); // Call function to update appointment
                },
                child: Text('Accept', style: TextStyle(color: Colors.green)),
              ),
            ],
          );
        },
      );
    },
  );
}