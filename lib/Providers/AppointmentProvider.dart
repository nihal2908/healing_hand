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
  String status;

  Appointment({
    required this.patient,
    required this.doctor,
    required this.purpose,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.type,
    required this.status,
  });
}

Appointment sampleAppointment1 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 13),
    type: 'Online',
  status: 'waiting'
);

Appointment sampleAppointment2 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 20),
    type: 'Online',
  status: 'waiting'
);

Appointment sampleAppointment3 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 10),
    type: 'Online',
    status: 'accepted'
);

Appointment sampleAppointment4 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 10),
    type: 'Online',
    status: 'denied'
);

Appointment sampleAppointment5 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 12),
    type: 'Online',
    status: 'accepted'
);

Appointment sampleAppointment6 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 18),
    type: 'Online',
    status: 'waiting'
);

Appointment sampleAppointment7 = Appointment(
    patient: samplePatient,
    doctor: sampleDoctor,
    purpose: 'First Checkup',
    startTime: TimeOfDay(hour: 10, minute: 00),
    endTime: TimeOfDay(hour: 10, minute: 30),
    date: DateTime(2024, 03, 09),
    type: 'Online',
    status: 'accepted'
);

List<Appointment> appointments = [sampleAppointment1, sampleAppointment2, sampleAppointment3, sampleAppointment4, sampleAppointment5, sampleAppointment6, sampleAppointment7];