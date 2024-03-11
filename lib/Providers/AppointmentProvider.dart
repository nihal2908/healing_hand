import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';

class Appointment{
  Patient patient;
  Doctor doctor;
  String purpose;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime date;
  String type;

  Appointment({
    required this.patient,
    required this.doctor,
    required this.purpose,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.type
  });
}

Appointment sampleAppointment = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 10),
    type: 'Online'
);

List<Appointment> appointments = [sampleAppointment, sampleAppointment, sampleAppointment, sampleAppointment];